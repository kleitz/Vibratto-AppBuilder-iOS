//
//  CompoundTopSection.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/16/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "CompoundTopSection.h"
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
        
        self.actuatorsBaseTag = 100;
        self.sensorsBaseTag = 200;
        self.gesturesBaseTag = 500;
        self.regionsBaseTag = 600;
        self.listenersBaseTag = 700;

/*
    } else if(icon.tag >= 200 && icon.tag < 300 && self.buildStage == SENSOR_SELECT){
        [self.sensorIcon changeIconType:icon.iconType];
        [self gotoStage: COMPARATOR_SELECT];
    } else if(icon.tag >= 300 && icon.tag < 400 && self.buildStage == COMPARATOR_SELECT){
        [self.comparatorIcon changeIconType:icon.iconType];
        [self gotoStage:VALUE_SELECT];
    } else if(icon.tag == 400 && self.buildStage == VALUE_SELECT){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Set Value" message:@"Enter Value (0-1023)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [alertView setTag:1];
        [alertView show];
    } else if(icon.tag >= 400 && icon.tag < 500 && self.buildStage == VALUE_SELECT){
        [self.valueIcon changeIconType:icon.iconType];
        [self gotoStage:ACTION_SELECT];
    } else if(icon.tag >= 500 && icon.tag < 600 && self.buildStage == ACTION_SELECT){
        [self.gestureIcon changeIconType:icon.iconType];
        [self gotoStage:REGION_SELECT];
    } else if(icon.tag >= 600 && icon.tag < 700 && self.buildStage == REGION_SELECT){
        [self.regionIcon changeIconType:icon.iconType];
        [self gotoStage:CONFIRM_LISTENER];
    }
*/
        
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
        
        [self.iconBox addIcon:ICON_TILT andIconImage:nil andDelegate:self andTag:(ICON_SENSOR * 100) andSubtitle:@"Rotation"];
        [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:(ICON_SENSOR * 100) + 1 andSubtitle:@"GPS"];
        
        [self.sensorArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.sensorArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_GREATERTHEN andIconImage:nil andDelegate:self andTag:(ICON_COMPARATOR * 100) andSubtitle:@"above"];
        [self.iconBox addIcon:ICON_LESSTHEN andIconImage:nil andDelegate:self andTag:(ICON_COMPARATOR * 100) + 1 andSubtitle:@"below"];
        
        [self.comparatorsArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.comparatorsArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_NUMBER andIconImage:nil andDelegate:self andTag:(ICON_VALUE * 100) andSubtitle:@"Value..."];
        [self.iconBox addIcon:ICON_TILT andIconImage:nil andDelegate:self andTag:(ICON_VALUE * 100) + 1 andSubtitle:@"Rotation"];
        [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:(ICON_VALUE * 100) + 2 andSubtitle:@"GPS"];
        
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.valueArray addObject:[self.iconBox returnItemAtIndex:2]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_INCREASE_POWER andIconImage:nil andDelegate:self andTag:(ICON_GESTURE * 100) andSubtitle:@"+ Power"];
        [self.iconBox addIcon:ICON_DECREASE_POWER andIconImage:nil andDelegate:self andTag:(ICON_GESTURE * 100) + 1 andSubtitle:@"- Power"];
        
        [self.gesturesArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.gesturesArray addObject:[self.iconBox returnItemAtIndex:1]];
        [self.iconBox emptyBox];
        
        
        [self.iconBox addIcon:ICON_ALL andIconImage:nil andDelegate:self andTag:(ICON_REGION * 100) andSubtitle:@"Device"];
        
        [self.regionsArray addObject:[self.iconBox returnItemAtIndex:0]];
        [self.iconBox emptyBox];

/*
 } else if(icon.tag >= (ICON_SENSOR * 100) && icon.tag < ((ICON_SENSOR * 100) + 100) && self.buildStage == SENSOR_SELECT){
 [self.sensorIcon changeIconType:icon.iconType];
 [self gotoStage: COMPARATOR_SELECT];
 } else if(icon.tag >= (ICON_COMPARATOR * 100) && icon.tag < ((ICON_COMPARATOR * 100) + 100) && self.buildStage == COMPARATOR_SELECT){
 [self.comparatorIcon changeIconType:icon.iconType];
 [self gotoStage:VALUE_SELECT];
 } else if(icon.tag == (ICON_VALUE * 100) && self.buildStage == VALUE_SELECT){
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Set Value" message:@"Enter Value (0-1023)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
 [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
 [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
 [alertView setTag:1];
 [alertView show];
 } else if(icon.tag >= (ICON_VALUE * 100) && icon.tag < ((ICON_VALUE * 100) + 100) && self.buildStage == VALUE_SELECT){
 [self.valueIcon changeIconType:icon.iconType];
 [self gotoStage:ACTION_SELECT];
 } else if(icon.tag >= (ICON_ACTION * 100) && icon.tag < ((ICON_ACTION * 100) + 100) && self.buildStage == ACTION_SELECT){
 [self.gestureIcon changeIconType:icon.iconType];
 [self gotoStage:REGION_SELECT];
 } else if(icon.tag >= (ICON_REGION * 100) && icon.tag < ((ICON_REGION * 100) + 100) && self.buildStage == REGION_SELECT){
 [self.regionIcon changeIconType:icon.iconType];
 [self gotoStage:CONFIRM_LISTENER];
 }
*/
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
    if(self.selectedCategory.iconType == ICON_ACTUATOR){
        if(((ActuatorDropDown *)ddm).pinNumber == 0){
            [self retractDropDown];
        } else {
            if(((ActuatorDropDown *)ddm).name == nil){
                ((ActuatorDropDown *)ddm).name = [NSString stringWithFormat:@"%i",((ActuatorDropDown *)ddm).pinNumber];
            }
            
            [self.visibleDropDown colapseDropDown];            
        }
    } else if(self.selectedCategory.iconType == ICON_SENSOR){
        if(((SensorDropDown *)ddm).pinNumber == 0){
            [self retractDropDown];
        } else {
            if(((SensorDropDown *)ddm).name == nil){
                ((SensorDropDown *)ddm).name = [NSString stringWithFormat:@"%i",((SensorDropDown *)ddm).pinNumber];
            }
            
            [self.visibleDropDown colapseDropDown];
        }
    }
}

-(void)finishedCollapsingDropDown:(DropDownMenu *)ddm{
    NSLog(@"CTS drop down fished collapsing");
    [self.visibleDropDown removeFromSuperview];
    [self addSubview:self.visibleDropDown];
    
    CGFloat xVal =
        self.iconBox.addIconBox.frame.size.width +
        self.iconBox.iconBuffer +
        (self.iconBox.boxItems.count * (self.iconBox.iconBuffer + self.abc.iconHeight));
    
    CGFloat yVal = 0;
    
    yVal = self.abc.topBoxHeight + self.abc.iconTopBuffer;
    
    /*
    if(self.visibleDropDown.name == nil){
        yVal = self.abc.topBoxHeight +  ((self.abc.topBoxHeight - self.visibleDropDown.frame.size.height)/2);
    } else {
        yVal = self.abc.topBoxHeight + self.abc.iconTopBuffer;
    }
    */
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.visibleDropDown setFrame:CGRectMake(xVal, yVal, self.visibleDropDown.frame.size.width, self.visibleDropDown.frame.size.height)];
    } completion:^(BOOL finished){

        [self addNewIconInCategory:self.selectedCategory.iconType iconType:self.visibleDropDown.selectedIcon.iconType andIconImage:nil andDelegate:self andTag:0 subtitle:self.visibleDropDown.name];
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
    if(subtitle == nil){
        NSLog(@"CTS subtitle is nil");
        icon = [[Icon alloc] initWithFrame:CGRectMake(iconX, (self.abc.topBoxHeight - self.abc.iconHeight)/2, self.abc.iconHeight, self.abc.iconHeight)];
    } else {
        icon = [[Icon alloc] initWithFrame:CGRectMake(iconX, self.abc.iconTopBuffer, self.abc.iconHeight, self.abc.iconHeight)];
        [icon changeSubtitle:subtitle];
    }
    
    [icon changeIconType:iconType];
    [icon setCustomImage:iconImage];
    int tagNum = (iconCategory * 100) + thisArray.count;

    [icon setTag:tagNum];
    
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
