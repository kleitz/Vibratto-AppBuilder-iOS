//
//  CompoundTopSection.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/16/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "CompoundTopSection.h"
#import "IconSubtitle.h"
#import "ActuatorDropDown.h"
#import "SensorDropDown.h"

@implementation CompoundTopSection

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.visibleCount = 0;
        self.visibleDropDown = nil;
        
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
        [self.iconBox setDelegate:self];
        
        [self.iconBox addIcon:ICON_TILT andIconImage:nil andDelegate:self andTag:20 andSubtitle:@"Rotation"];
        [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:21 andSubtitle:@"GPS"];
        
        [self.sensorArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.sensorArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_GREATERTHEN andIconImage:nil andDelegate:self andTag:30 andSubtitle:@"above"];
        [self.iconBox addIcon:ICON_LESSTHEN andIconImage:nil andDelegate:self andTag:31 andSubtitle:@"below"];
        
        [self.comparatorsArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.comparatorsArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_NUMBER andIconImage:nil andDelegate:self andTag:40 andSubtitle:@"Value..."];
        [self.iconBox addIcon:ICON_TILT andIconImage:nil andDelegate:self andTag:41 andSubtitle:@"Rotation"];
        [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:42 andSubtitle:@"GPS"];
        
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:2]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_INCREASE_POWER andIconImage:nil andDelegate:self andTag:50 andSubtitle:@"+ Power"];
        [self.iconBox addIcon:ICON_DECREASE_POWER andIconImage:nil andDelegate:self andTag:51 andSubtitle:@"- Power"];
        
        [self.gesturesArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.gesturesArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_ALL andIconImage:nil andDelegate:self andTag:60 andSubtitle:@"Device"];
        
        [self.regionsArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.iconBox emptyBox];
        
        [self addSubview:self.iconBox];
        [self addSubview:self.categories];
    }
    return self;
}

-(void)showDropDown:(DropDownMenu *)dropDown{
    NSLog(@"CTS showDropDown: %f, height: %f", dropDown.frame.size.height, self.frame.size.height);
    [dropDown setFrame:CGRectMake(0, self.frame.size.height - dropDown.frame.size.height, dropDown.frame.size.width, dropDown.frame.size.height)];
    //[self addSubview:dropDown];
    NSLog(@"CTS showDropDown post: %f, height: %f", dropDown.frame.size.height, self.frame.size.height);
    NSLog(@"CTS dropDown y: %f", dropDown.frame.origin.y);
    
    [self insertSubview:dropDown belowSubview:[self.subviews objectAtIndex:0]];
    
    [UIView animateWithDuration:0.4f animations:^{
        [dropDown setFrame:CGRectMake(0, self.frame.size.height, dropDown.frame.size.width, dropDown.frame.size.height)];
    } completion:^(BOOL finished){
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + dropDown.frame.size.height)];
        
    }];
}

-(void)retractDropDown{
    [UIView animateWithDuration:0.4f animations:^{
        [self.visibleDropDown setFrame:CGRectMake(self.visibleDropDown.frame.origin.x, self.visibleDropDown.frame.origin.y - self.visibleDropDown.frame.size.height, self.visibleDropDown.frame.size.width, self.visibleDropDown.frame.size.height)];
    } completion: ^(BOOL finished){
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - self.visibleDropDown.frame.size.height)];
        [self.visibleDropDown removeFromSuperview];
        self.visibleDropDown = nil;
    }];
}

-(void)dropDowncancelClicked:(DropDownMenu *)ddm{
    NSLog(@"CTS drop down cancel clicked");
    [self retractDropDown];
}

-(void)dropDownOkClicked:(DropDownMenu *)ddm{
    NSLog(@"CTS drop down ok clicked");
    //[self retractDropDown];
    [self.visibleDropDown colapseDropDown];
}

-(void)finishedCollapsingDropDown:(DropDownMenu *)ddm{
    NSLog(@"CTS drop down fished collapsing");
    [self.visibleDropDown removeFromSuperview];
    [self addSubview:self.visibleDropDown];
    
    CGFloat xVal =
        self.iconBox.addIconBox.frame.size.width +
        self.iconBox.iconBuffer +
        (self.iconBox.boxItems.count * (self.iconBox.iconBuffer + self.abc.iconHeight));
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.visibleDropDown setFrame:CGRectMake(xVal, self.abc.topBoxHeight +  ((self.abc.topBoxHeight - self.visibleDropDown.frame.size.height)/2), self.visibleDropDown.frame.size.width, self.visibleDropDown.frame.size.height)];
    } completion:^(BOOL finished){
        
        /*
        switch (self.selectedCategory.iconType) {
            case ICON_SENSOR:
                
                break;
            
            case ICON_ACTUATOR:
                break;
            
            case ICON_REGION:
                break;
            
            case ICON_GESTURE:
                break;
                
            default:
                break;
        }
        */
        [self addNewIconInCategory:self.selectedCategory.iconType iconType:self.visibleDropDown.selectedIcon.iconType andIconImage:nil andDelegate:self andTag:0 subtitle:nil];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [self.visibleDropDown getProjectedHeight])];
        [self.visibleDropDown removeFromSuperview];
        self.visibleDropDown = nil;
        //[self.createdListenerIcon changeIconType:ICON_CUSTOM];
        //[self.createdListenerIcon removeFromSuperview];

    }];
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"CompoundTopSection iconClicked");
    switch (icon.tag) {
        case 10000:{
            NSLog(@"CTS Clicked add button");
            if(self.visibleDropDown != nil){
                [self retractDropDown];
            } else if(self.selectedCategory.iconType == ICON_ACTUATOR){
                NSLog(@"CTS actuator");
                self.visibleDropDown = [[ActuatorDropDown alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
                [self.visibleDropDown setDelegate:self];
                
                [self showDropDown:self.visibleDropDown];
            } else if(self.selectedCategory.iconType == ICON_SENSOR){
                NSLog(@"CTS sensor");
                //SensorDropDown *dropDown = [[S]]
                self.visibleDropDown = [[SensorDropDown alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
                [self.visibleDropDown setDelegate:self];
                
                [self showDropDown:self.visibleDropDown];
            }
            
            break;
        }
            
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
    
    if(icon.tag != 10000){
        [self.delegate iconClicked:icon];
    }
}

-(void)addNewIconInCategory:(ICON_TYPE)iconCategory iconType:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag subtitle:(NSString *)subtitle{
    NSLog(@"CTS addNewIconInCategory: %i", iconCategory);
    
    NSMutableArray *thisArray;
    Icon *icon;
    switch (iconCategory) {
        case ICON_ACTUATOR:
            NSLog(@"CTS iconActuator");
            thisArray = self.actuatorsArray;
            break;
        
        case ICON_SENSOR:
            NSLog(@"CTS iconSensor");
            thisArray = self.sensorArray;
            break;
        
        case ICON_GESTURE:
            NSLog(@"CTS iconGesture");
            thisArray = self.gesturesArray;
            break;
        
        case ICON_REGION:
            NSLog(@"CTS iconRegion");
            thisArray = self.regionsArray;
            break;
        
        case ICON_LISTENER:
            NSLog(@"CTS iconListener");
            thisArray = self.listenersArray;
            break;
            
        default:{
            NSLog(@"CTS default");
            break;
        }
            
    }
    
    CGFloat iconX = (thisArray.count * self.abc.iconHeight) + ((thisArray.count + 1) * self.iconBox.iconBuffer);
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
