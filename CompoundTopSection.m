//
//  CompoundTopSection.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/16/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "CompoundTopSection.h"

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
        [self.categories addIcon:ICON_SENSOR andIconImage:nil andDelegate:self andTag:11];
        [self.categories addIcon:ICON_ACTUATOR andIconImage:nil andDelegate:self andTag:10];
        [self.categories addIcon:ICON_REGION andIconImage:nil andDelegate:self andTag:12];
        [self.categories addIcon:ICON_GESTURE andIconImage:nil andDelegate:self andTag:13];
        [self.categories addIcon:ICON_LISTENER andIconImage:nil andDelegate:self andTag:14];
        [self.categories addIconWithoutDisplay:ICON_COMPARATOR andDelegate:self andTag:15];
        //[self.categories addIcon:ICON_COMPARATOR andIconImage:nil andDelegate:self andTag:15];
        [self.categories addIconWithoutDisplay:ICON_VALUE andDelegate:self andTag:16];
        
        [self.categories changeTrayColor:self.abc.primaryColor3];
        [self.categories changeIsCentered:YES];
        
        Icon *listenerIcon = [self.categories returnItemAtIndex:4];
        [listenerIcon toggleHighlighted];
        self.selectedCategory = listenerIcon;
        
        self.iconBox = [[TopBox alloc] initWithFrame:CGRectMake(0, self.abc.topBoxHeight, self.frame.size.width, self.abc.topBoxHeight) andHasAddBox:NO];
        
        [self.iconBox addIcon:ICON_TILT andIconImage:nil andDelegate:self andTag:20];
        [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:21];
        
        [self.sensorArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.sensorArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_GREATERTHEN andIconImage:nil andDelegate:self andTag:30];
        [self.iconBox addIcon:ICON_LESSTHEN andIconImage:nil andDelegate:self andTag:31];
        
        [self.comparatorsArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.comparatorsArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_NUMBER andIconImage:nil andDelegate:self andTag:40];
        [self.iconBox addIcon:ICON_TILT andIconImage:nil andDelegate:self andTag:41];
        [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:42];
        
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:2]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_INCREASE_POWER andIconImage:nil andDelegate:self andTag:50];
        [self.iconBox addIcon:ICON_DECREASE_POWER andIconImage:nil andDelegate:self andTag:51];
        
        [self.gesturesArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.gesturesArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_ALL andIconImage:nil andDelegate:self andTag:60];
        
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

-(void)addNewIconInCategory:(ICON_TYPE)iconCategory iconType:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag{
    NSMutableArray *thisArray;
    Icon *icon;
    switch (iconCategory) {
        case ICON_ACTUATOR:
            /*
            self.actuatorsArray.count * self.abc.iconHeight + (self.actuatorsArray.count + 1) * self.iconBox.iconBuffer
            Icon *icon = [Icon alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, , <#CGFloat height#>)
            [self.actuatorsArray addObject:icon];
            */
            thisArray = self.actuatorsArray;
        
            //break;
        
        case ICON_SENSOR:
            //[self.sensorArray addObject:icon];
            //break;
            thisArray = self.sensorArray;
        
        case ICON_GESTURE:
            //[self.gesturesArray addObject:icon];
            //break;
            thisArray = self.gesturesArray;
        
        case ICON_REGION:
            //[self.regionsArray addObject:icon];
            //break;
            thisArray = self.regionsArray;
        
        case ICON_LISTENER:
            thisArray = self.listenersArray;
            //[self.listenersArray addObject:icon];
            //break;
            
        default:{
            CGFloat iconX = thisArray.count * self.abc.iconHeight + (thisArray.count + 1) * self.iconBox.iconBuffer;
            icon = [[Icon alloc] initWithFrame:CGRectMake(iconX, (self.abc.topBoxHeight - self.abc.iconHeight)/2, self.abc.iconHeight, self.abc.iconHeight)];
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
        [self.iconBox addIcon:icon.iconType andIconImage:nil andDelegate:nil andTag:0];
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
