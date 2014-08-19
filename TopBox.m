//
//  TopBox.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "TopBox.h"
#import "Icon.h"

@implementation TopBox

-(id)initWithFrame:(CGRect)frame{
    NSLog(@"TopBox initWithFrame");
    self = [super initWithFrame:frame];
    if(self){
        self.hasAddButton = NO;
        [self initialize];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame andHasAddBox:(BOOL)hasAddButton{
    self = [super initWithFrame:frame];
    if(self){
        self.hasAddButton = hasAddButton;
        [self initialize];
    }
    
    return self;
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"TopBox iconClicked: %i", icon.tag);
    if(icon.tag == 10000){
        [self.delegate iconClicked:icon];
    } else {
        [icon toggleHighlighted];
        
        if(self.selectedIcon != nil){
            [self.selectedIcon toggleHighlighted];
        }
        
        if(self.selectedIcon == icon){
            NSLog(@"TopBox icon is equal");
            [self.selectedIcon toggleHighlighted];
            self.selectedIcon = nil;
        } else {
            self.selectedIcon = icon;
        }
    }
}

-(void)emptyBox{
    for(int i=self.boxItems.count -1; i>=0; i--){
        [[self.boxItems objectAtIndex:i] removeFromSuperview];
        [self.boxItems removeObjectAtIndex:i];
    }
    
    [self.scrollBar setContentSize:CGSizeMake(0, self.scrollBar.contentSize.height)];
}

-(void)fillBox:(NSArray *)newItems andDelegate:(id<IconDelegate>)delegate{
    for(int i=0; i<newItems.count; i++){
        Icon *thisIcon = [newItems objectAtIndex:i];
        [self addIcon:thisIcon.iconType andIconImage:thisIcon.customImage andDelegate:delegate andTag:thisIcon.tag];
    }
}

-(void)initialize{
    NSLog(@"TopBox initialize");
    
    self.abc = [AppBuilderConstants getAppBuilderConstants];
    self.displayCount = 0;
    
    self.boxItems = [[NSMutableArray alloc] init];
    self.iconBuffer = self.frame.size.height/2 - self.abc.iconHeight/2;
    self.selectedIcon = nil;
    self.isCentered = NO;
    
    if(self.hasAddButton){
        self.addIconBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];

    } else {
        self.addIconBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    
    self.addIcon = [[Icon alloc] initWithFrame:CGRectMake(self.iconBuffer, self.iconBuffer, self.abc.iconHeight, self.abc.iconHeight)];
    [self.addIcon changeIconType:ICON_ADD];
    [self.addIcon setTag:10000];
    [self.addIcon setMyDelegate:self];
    [self.addIconBox addSubview:self.addIcon];
    
    [self.addIconBox setBackgroundColor:self.abc.primaryColor1];
    
    self.scrollBar = [[UIScrollView alloc] initWithFrame:CGRectMake(self.addIconBox.frame.origin.x + self.addIconBox.frame.size.width, 0, self.frame.size.width - self.addIconBox.frame.size.width, self.frame.size.height)];
    [self.scrollBar setUserInteractionEnabled:YES];
    [self.scrollBar setBackgroundColor:self.abc.primaryColor2];
    [self.scrollBar setScrollEnabled:YES];
    
    [self addSubview:self.addIconBox];
    [self addSubview:self.scrollBar];
    
    /*
    for(int i=0; i<9; i++){
        [self addIcon:ICON_ACTUATOR andIconImage:nil];
    }
    */
}

-(void)changeIsCentered:(BOOL)isCentered{
    self.isCentered = isCentered;
    
    if(isCentered){
        self.iconBuffer = (self.frame.size.width - (self.displayCount * self.abc.iconHeight))/(self.displayCount + 1);
    } else {
        
        self.iconBuffer = self.frame.size.height/2 - self.abc.iconHeight/2;
    }
    
    for(int i=0; i<self.boxItems.count; i++){
        Icon *thisIcon = [self.boxItems objectAtIndex:i];
        [thisIcon setFrame:CGRectMake(self.iconBuffer + (self.iconBuffer * i) + (self.abc.iconHeight * i), thisIcon.frame.origin.y, thisIcon.frame.size.width, thisIcon.frame.size.height)];
    }
}

-(void)addIcon:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag{
    //NSLog(@"TopBox addIcon");
    Icon *newIcon;
    if(self.boxItems.count > 0){
        Icon *lastIcon = [self.boxItems objectAtIndex:self.boxItems.count-1];
        
        newIcon = [[Icon alloc] initWithFrame:CGRectMake(lastIcon.frame.size.width + lastIcon.frame.origin.x + (2 * self.iconBuffer), lastIcon.frame.origin.y, self.abc.iconHeight, self.abc.iconHeight)];

    } else {
        newIcon = [[Icon alloc] initWithFrame:CGRectMake(self.iconBuffer, self.iconBuffer, self.abc.iconHeight, self.abc.iconHeight)];
    }
    
    [self.scrollBar setContentSize:CGSizeMake(self.scrollBar.contentSize.width + newIcon.frame.size.width + (2 * self.iconBuffer), self.scrollBar.contentSize.height)];
    [newIcon changeIconType:iconType];
    
    if(iconImage != nil){
        [newIcon setCustomImage:iconImage];
    }
    
    if(delegate != nil){
        [newIcon setMyDelegate:delegate];
    } else {
        [newIcon setMyDelegate:self];
    }
    
    [newIcon setTag:tag];
    
    NSLog(@"TopBox addIcon: %f", newIcon.frame.size.width + newIcon.frame.origin.x);
    [self.boxItems addObject:newIcon];
    [self.scrollBar addSubview:newIcon];
    
    self.displayCount++;
}

-(void)addIcon:(Icon *)iconToAdd{
    [self.boxItems addObject:iconToAdd];
    [self.scrollBar addSubview:iconToAdd];
    self.displayCount++;
}

-(void)addIconWithoutDisplay:(ICON_TYPE)iconType andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag{
    Icon *newIcon;
    newIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [newIcon changeIconType:iconType];
    [newIcon setTag:tag];
    [self.boxItems addObject:newIcon];
}

-(Icon *)returnItemAtIndex:(NSInteger)index{
    Icon *thisIcon = [self.boxItems objectAtIndex:index];
    return thisIcon;
}

-(void)setHighlightedIcon:(NSInteger)index{
    Icon *thisIcon = [self.boxItems objectAtIndex:index];
    [thisIcon toggleHighlighted];
}

-(void)changeTrayColor:(UIColor *)color{
    [self.scrollBar setBackgroundColor:color];
}

-(void)changeHasAddBox:(BOOL)hasAddBox{
    self.hasAddButton = hasAddBox;
    
    if(self.hasAddButton){
        [self.addIconBox setFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        
    } else {
        [self.addIconBox setFrame:CGRectMake(0, 0, 0, 0)];
    }
    
    [self.addIconBox setBackgroundColor:self.abc.primaryColor1];
    
    [self.scrollBar setFrame:CGRectMake(self.addIconBox.frame.origin.x + self.addIconBox.frame.size.width, 0, self.frame.size.width - self.addIconBox.frame.size.width, self.frame.size.height)];
    [self changeIsCentered:self.isCentered];
}

@end
