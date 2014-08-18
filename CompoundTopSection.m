//
//  CompoundTopSection.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/16/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "CompoundTopSection.h"
#import "IconSubtitle.h"

@implementation CompoundTopSection

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.visibleCount = 0;
        
        self.abc = [AppBuilderConstants getAppBuilderConstants];
        self.actuatorsArray = [[NSMutableArray alloc] init];
        self.sensorArray = [[NSMutableArray alloc] init];
        self.regionsArray = [[NSMutableArray alloc] init];
        self.gesturesArray = [[NSMutableArray alloc] init];
        self.listenersArray = [[NSMutableArray alloc] init];
        self.categoriesArray = [[NSMutableArray alloc] init];
        self.comparatorsArray = [[NSMutableArray alloc] init];
        self.valueArray = [[NSMutableArray alloc] init];
        
        [self setFrame:frame];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.categories = [[TopBox alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.abc.topBoxHeight) andHasAddBox:NO];
        [self.categories addIcon:ICON_SENSOR andIconImage:nil andDelegate:self andTag:11 andSubtitle: @"Sensors"];
        [self.categories addIcon:ICON_ACTUATOR andIconImage:nil andDelegate:self andTag:10 andSubtitle:@"Actuators"];
        [self.categories addIcon:ICON_REGION andIconImage:nil andDelegate:self andTag:12 andSubtitle:@"Regions"];
        [self.categories addIcon:ICON_GESTURE andIconImage:nil andDelegate:self andTag:13 andSubtitle:@"Actions"];
        [self.categories addIcon:ICON_LISTENER andIconImage:nil andDelegate:self andTag:14 andSubtitle:@"Listeners"];
        [self.categories addIconWithoutDisplay:ICON_COMPARATOR andDelegate:self andTag:15];
        //[self.categories addIcon:ICON_COMPARATOR andIconImage:nil andDelegate:self andTag:15];
        [self.categories addIconWithoutDisplay:ICON_VALUE andDelegate:self andTag:16];
        
        [self.categories changeTrayColor:self.abc.primaryColor3];
        [self.categories changeIsCentered:YES];
        
        Icon *listenerIcon = [self.categories returnItemAtIndex:4];
        [listenerIcon toggleHighlighted];
        self.selectedCategory = listenerIcon;
        
        self.iconBox = [[TopBox alloc] initWithFrame:CGRectMake(0, self.abc.topBoxHeight, self.frame.size.width, self.abc.topBoxHeight) andHasAddBox:NO];
        
        [self.iconBox addIcon:ICON_TILT andIconImage:nil andDelegate:self andTag:20 andSubtitle:nil];
        [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:21 andSubtitle:nil];
        
        [self.sensorArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.sensorArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_GREATERTHEN andIconImage:nil andDelegate:self andTag:30 andSubtitle:nil];
        [self.iconBox addIcon:ICON_LESSTHEN andIconImage:nil andDelegate:self andTag:31 andSubtitle:nil];
        
        [self.comparatorsArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.comparatorsArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_NUMBER andIconImage:nil andDelegate:self andTag:40 andSubtitle:nil];
        [self.iconBox addIcon:ICON_TILT andIconImage:nil andDelegate:self andTag:41 andSubtitle:nil];
        [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:42 andSubtitle:nil];
        
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:2]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_INCREASE_POWER andIconImage:nil andDelegate:self andTag:50 andSubtitle:nil];
        [self.iconBox addIcon:ICON_DECREASE_POWER andIconImage:nil andDelegate:self andTag:51 andSubtitle:nil];
        
        [self.gesturesArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.gesturesArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_ALL andIconImage:nil andDelegate:self andTag:60 andSubtitle:nil];
        
        [self.regionsArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.iconBox emptyBox];
        
        [self addSubview:self.iconBox];
        [self addSubview:self.categories];
    }
    return self;
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"CompoundTopSection iconClicked");
    switch (icon.tag) {
        case 10:
            NSLog(@"CTS actuator category");
            [self selectCategory:icon];
            break;
        
        case 11:
            NSLog(@"CTS sensor category");
            [self selectCategory:icon];
            break;
        
        case 12:
            NSLog(@"CTS region category");
            [self selectCategory:icon];
            break;
        
        case 13:
            NSLog(@"CTS gesture category");
            [self selectCategory:icon];
            break;
        
        case 14:
            NSLog(@"CTS listener category");
            [self selectCategory:icon];
            break;
        
        case 15:
            NSLog(@"CTS comparator category");
            [self selectCategory:icon];
            break;
            
        default:
            break;
    }
    
    [self.delegate iconClicked:icon];
}

-(void)addNewIconInCategory:(ICON_TYPE)iconCategory iconType:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag subtitle:(NSString *)subtitle{
    NSMutableArray *thisArray;
    Icon *icon;
    switch (iconCategory) {
        case ICON_ACTUATOR:
            thisArray = self.actuatorsArray;
        
        case ICON_SENSOR:
            thisArray = self.sensorArray;
        
        case ICON_GESTURE:
            thisArray = self.gesturesArray;
        
        case ICON_REGION:
            thisArray = self.regionsArray;
        
        case ICON_LISTENER:
            thisArray = self.listenersArray;
            
        default:{
            CGFloat iconX = thisArray.count * self.abc.iconHeight + (thisArray.count + 1) * self.iconBox.iconBuffer;
            if(subtitle != nil){
                icon = [[Icon alloc] initWithFrame:CGRectMake(iconX, (self.abc.topBoxHeight - self.abc.iconHeight)/2, self.abc.iconHeight, self.abc.iconHeight)];
            } else {
                icon = [[IconSubtitle alloc] initWithFrame:CGRectMake(iconX, (self.abc.topBoxHeight - self.abc.iconHeight)/2, self.abc.iconHeight, self.abc.iconHeight)];
                [((IconSubtitle *)icon) changeSubtitle:subtitle];
            }
            
            [icon changeIconType:iconType];
            [icon setCustomImage:iconImage];
            [icon setTag:tag];
            if(delegate != nil){
                [icon setMyDelegate:delegate];
            } else {
                [icon setMyDelegate:self];
            }
            
            [thisArray addObject:icon];
        }
            break;
    }
    
    
    if(iconCategory == self.selectedCategory.iconType){
        //[self.iconBox addIcon:icon.iconType andIconImage:nil andDelegate:nil andTag:0];
        [self.iconBox addIcon:icon];
    }
}

-(void)selectCategory:(Icon *)icon{
    
    [icon toggleHighlighted];
    
    if(self.selectedCategory != nil){
        [self.selectedCategory toggleHighlighted];
    }
    
    if(self.selectedCategory == icon){
        NSLog(@"CTS icon is equal");
        [self.selectedCategory toggleHighlighted];
        self.selectedCategory = nil;
    } else {
        NSLog(@"CTS icon not equal");
        self.selectedCategory = icon;
        
        [UIView animateWithDuration:0.2f animations:^{
            [self.iconBox setFrame:CGRectMake(self.iconBox.frame.origin.x, 0, self.iconBox.frame.size.width, self.iconBox.frame.size.height)];
        } completion:^(BOOL finished){
            NSLog(@"CTS animate completion");
            [self fillIconBox];
            [UIView animateWithDuration:0.2f animations:^{
                [self.iconBox setFrame:CGRectMake(self.iconBox.frame.origin.x, self.abc.topBoxHeight, self.iconBox.frame.size.width, self.abc.topBoxHeight)];
            }];
        }];
        
    }
}

-(void)selectCategoryByType:(ICON_TYPE)iconType{
    for(int i=0; i<self.categories.boxItems.count; i++){
        Icon *thisIcon = [self.categories.boxItems objectAtIndex:i];
        if(thisIcon.iconType == iconType){
            [self selectCategory:thisIcon];
        }
    }
}

-(void)fillIconBox{
    [self.iconBox emptyBox];
    
    switch (self.selectedCategory.iconType) {
        case ICON_ACTUATOR:
            [self.iconBox fillBox:self.actuatorsArray andDelegate:self];
            [self.iconBox changeHasAddBox:YES];
            break;
        
        case ICON_SENSOR:
            [self.iconBox fillBox:self.sensorArray andDelegate:self];
            [self.iconBox changeHasAddBox:YES];
            break;
        
        case ICON_REGION:
            [self.iconBox fillBox:self.regionsArray andDelegate:self];
            [self.iconBox changeHasAddBox:YES];
            break;
        
        case ICON_GESTURE:
            [self.iconBox fillBox:self.gesturesArray andDelegate:self];
            [self.iconBox changeHasAddBox:YES];
            break;
        
        case ICON_LISTENER:
            [self.iconBox fillBox:self.listenersArray andDelegate:self];
            [self.iconBox changeHasAddBox:NO];
            break;
        
        case ICON_COMPARATOR:
            [self.iconBox fillBox:self.comparatorsArray andDelegate:self];
            [self.iconBox changeHasAddBox:NO];
            break;
        
        case ICON_VALUE:
            [self.iconBox fillBox:self.valueArray andDelegate:self];
            [self.iconBox changeHasAddBox:NO];
            break;
            
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
