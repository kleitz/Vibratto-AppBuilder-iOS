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
        self.abc = [AppBuilderConstants getAppBuilderConstants];
        self.addIconBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        self.scrollBar = [[UIScrollView alloc] initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
        [self.scrollBar setUserInteractionEnabled:YES];
        [self.scrollBar setBackgroundColor:self.abc.primaryColor2];
        [self.addIconBox setBackgroundColor:self.abc.primaryColor3];
        [self.scrollBar setScrollEnabled:YES];
        NSLog(@"TopBox scrollBar width: %f", self.scrollBar.contentSize.width);
        
        self.boxItems = [[NSMutableArray alloc] init];
        self.iconBuffer = self.addIconBox.frame.size.width/2 - self.abc.iconHeight/2;
        self.addIcon = [[Icon alloc] initWithFrame:CGRectMake(self.iconBuffer, self.iconBuffer, self.abc.iconHeight, self.abc.iconHeight)];
        [self.addIcon changeIconType:ICON_ADD];
        [self.addIconBox addSubview:self.addIcon];
        
        [self addSubview:self.addIconBox];
        [self addSubview:self.scrollBar];
        
        
        for(int i=0; i<9; i++){
            [self addIcon:ICON_ACTUATOR andIconImage:nil];
        }
        
    }
    
    return self;
}

-(void)addIcon:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage{
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
    
    NSLog(@"TopBox addIcon: %f", newIcon.frame.size.width + newIcon.frame.origin.x);
    [self.boxItems addObject:newIcon];
    [self.scrollBar addSubview:newIcon];
}

@end
