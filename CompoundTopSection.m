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
#import "ListenerDropDown.h"
#import "RegionDropDown.h"
#import "TypeData.h"

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
        
        [self setFrame:frame];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.categories = [[TopBox alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.abc.topBoxHeight) andHasAddBox:NO];
        [self.categories addIcon:ICON_SENSOR andIconImage:nil andDelegate:self andTag:11 andSubtitle: @"Sensors" andIconData:nil];
        //[self.categories addIcon:ICON_ACTUATOR andIconImage:nil andDelegate:self andTag:10 andSubtitle:@"Actuators" andIconData:nil];
        [self.categories addIcon:ICON_REGION andIconImage:nil andDelegate:self andTag:12 andSubtitle:@"Regions" andIconData:nil];
        [self.categories addIcon:ICON_GESTURE andIconImage:nil andDelegate:self andTag:13 andSubtitle:@"Actions" andIconData:nil];
        [self.categories addIcon:ICON_LISTENER andIconImage:nil andDelegate:self andTag:14 andSubtitle:@"Listeners" andIconData:nil];
        [self.categories addIconWithoutDisplay:ICON_COMPARATOR andDelegate:self andTag:15];
        [self.categories addIconWithoutDisplay:ICON_VALUE andDelegate:self andTag:16];
        
        [self.categories changeTrayColor:self.abc.primaryColor3];
        [self.categories changeIsCentered:YES];
        
        Icon *listenerIcon = [self.categories returnItemByType:ICON_LISTENER];
        
        [listenerIcon toggleHighlighted];
        self.selectedCategory = listenerIcon;
        
        self.iconBox = [[TopBox alloc] initWithFrame:CGRectMake(0, self.abc.topBoxHeight, self.frame.size.width, self.abc.topBoxHeight) andHasAddBox:NO];
        [self.iconBox setDelegate:self];
        
        /*
        Sensor *rotationSensor = [[Sensor alloc] init];
        [rotationSensor setPinNumber:-1];
        [rotationSensor setName:@"Rotation"];
        [rotationSensor setSensitivity:-1];
        */
        
        Sensor *rotationSensor = [[Sensor alloc] initWithPinNumber:-1 hasName:YES andName:@"Rotation" andSensitivity:-1 andIsCustom:NO];
        [rotationSensor setIsCustom:NO];
        
        Sensor *gpsSensor = [[Sensor alloc] initWithPinNumber:-1 hasName:YES andName:@"GPS" andSensitivity:-1 andIsCustom:NO];
        [gpsSensor setIsCustom:NO];
        
        Action *increasePowerAction = [[Action alloc] initWithName:@"increasePower" isCustom:NO];
        Action *decreasePowerAction = [[Action alloc] initWithName:@"decreasePower" isCustom:NO];
        
        Comparator *greaterThenComparator = [[Comparator alloc] initWithType:ICON_GREATERTHEN];
        Comparator *lessThenComparator = [[Comparator alloc] initWithType:ICON_LESSTHEN];
        
        RegionDropDown *rdd = [[RegionDropDown alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        Region *deviceRegion = [[Region alloc] initWithName:@"Device" andActuators:rdd.regionIcons isCustom:NO];
        
        [self addNewIconInCategory:ICON_SENSOR iconType:ICON_TILT andIconImage:nil andDelegate:self andTag:(ICON_SENSOR * 100) subtitle:@"Rotation" andData:rotationSensor];
        [self addNewIconInCategory:ICON_SENSOR iconType:ICON_MAP andIconImage:nil andDelegate:self andTag:(ICON_SENSOR * 100) + 1 subtitle:@"GPS" andData:gpsSensor];
        
        [self addNewIconInCategory:ICON_COMPARATOR iconType:ICON_GREATERTHEN andIconImage:nil andDelegate:self andTag:(ICON_COMPARATOR * 100) subtitle:@"above" andData:greaterThenComparator];
        [self addNewIconInCategory:ICON_COMPARATOR iconType:ICON_LESSTHEN andIconImage:nil andDelegate:self andTag:(ICON_COMPARATOR * 100) + 1 subtitle:@"below" andData:lessThenComparator];
        
        [self addNewIconInCategory:ICON_VALUE iconType:ICON_NUMBER andIconImage:nil andDelegate:self andTag:(ICON_VALUE * 100) subtitle:@"Value..."];
        [self addNewIconInCategory:ICON_VALUE iconType:ICON_TILT andIconImage:nil andDelegate:self andTag:(ICON_VALUE * 100) + 1 subtitle:@"Rotation" andData:rotationSensor];
        [self addNewIconInCategory:ICON_VALUE iconType:ICON_MAP andIconImage:nil andDelegate:self andTag:(ICON_VALUE * 100) + 2 subtitle:@"GPS" andData:gpsSensor];
        
        [self addNewIconInCategory:ICON_GESTURE iconType:ICON_INCREASE_POWER andIconImage:nil andDelegate:self andTag:(ICON_GESTURE * 100) subtitle:@"+ Power" andData:increasePowerAction];
        [self addNewIconInCategory:ICON_GESTURE iconType:ICON_DECREASE_POWER andIconImage:nil andDelegate:self andTag:(ICON_GESTURE * 100) + 1 subtitle:@"- Power" andData:decreasePowerAction];
        
        [self addNewIconInCategory:ICON_REGION iconType:ICON_ALL andIconImage:nil andDelegate:self andTag:(ICON_REGION * 100) subtitle:@"Device" andData:deviceRegion];

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

-(void)showDropDownByType:(ICON_TYPE)iconType isEditing:(BOOL)isEditing typeData:(TypeData *)typeData representingIcon:(Icon *)icon{
    if(iconType == ICON_ACTUATOR){
        self.visibleDropDown = [[ActuatorDropDown alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    } else if(iconType == ICON_SENSOR){
        self.visibleDropDown = [[SensorDropDown alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    } else if(iconType == ICON_LISTENER){
        self.visibleDropDown = [[ListenerDropDown alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    } else if(iconType == ICON_REGION){
        self.visibleDropDown = [[RegionDropDown alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    }
    
    [self.visibleDropDown setDelegate:self];
    [self.visibleDropDown setIsEditing:isEditing];
    [self.visibleDropDown changeTypeData:typeData];
    [self.visibleDropDown setRepresentedIcon:icon];
    [self showDropDown:self.visibleDropDown];
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

    if(self.selectedCategory.iconType == ICON_ACTUATOR){
        if(((ActuatorDropDown *)ddm).pinNumber == 0){
            [self retractDropDown];
        } else {
            if(((ActuatorDropDown *)ddm).name == nil){
                ((ActuatorDropDown *)ddm).name = [NSString stringWithFormat:@"%i",((ActuatorDropDown *)ddm).pinNumber];
            }
            
            [self.visibleDropDown colapseDropDown];
            [self.compoundDelegate collapsingStarted:self.visibleDropDown];
        }
    } else if(self.selectedCategory.iconType == ICON_SENSOR){
        SensorDropDown *sensorDropDown = (SensorDropDown *)ddm;
        if(sensorDropDown.pinNumber == 0){
            [self retractDropDown];
        } else {
            
            if(self.visibleDropDown.isEditing){
                NSLog(@"CTS sensor isEditing, name: %@, pin: %i, sensitivity: %i", sensorDropDown.name, sensorDropDown.pinNumber, sensorDropDown.sensitivity);
                Sensor *thisSensor = (Sensor *)self.visibleDropDown.typeData;
                [thisSensor setName:sensorDropDown.name];
                [thisSensor setPinNumber:sensorDropDown.pinNumber];
                [thisSensor setSensitivity:sensorDropDown.sensitivity];
                
                Icon *sensorIcon = sensorDropDown.representedIcon;
                [sensorIcon changeSubtitle:thisSensor.name];
                
                [self retractDropDown];
            } else {
                [self.visibleDropDown colapseDropDown];
                [self.compoundDelegate collapsingStarted:self.visibleDropDown];
            }

        }
    } else if([ddm isKindOfClass:[ListenerDropDown class]]){
        if(self.selectedCategory.iconType != ICON_LISTENER){
            [self selectCategoryByType:ICON_LISTENER];
        }
        
        [self.visibleDropDown colapseDropDown];
        [self.compoundDelegate collapsingStarted:self.visibleDropDown];
        //[self.compoundDelegate buildListener:self];
    } else if([ddm isKindOfClass:[RegionDropDown class]]){
        if(((RegionDropDown *)ddm).name == nil){
            [self retractDropDown];
        } else {
            [self.visibleDropDown colapseDropDown];
            [self.compoundDelegate collapsingStarted:self.visibleDropDown];
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
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.visibleDropDown setFrame:CGRectMake(xVal, yVal, self.visibleDropDown.frame.size.width, self.visibleDropDown.frame.size.height)];
    } completion:^(BOOL finished){
        
        [self.compoundDelegate addedNewItemFromDropDown:self.visibleDropDown];
        
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - [self.visibleDropDown getProjectedHeight])];
        [self.visibleDropDown removeFromSuperview];
        self.visibleDropDown = nil;
    }];
}

-(void)iconLongPressed:(Icon *)icon{
    NSLog(@"CTS iconLongPress, tag: %i, isCustom: %i", icon.tag, icon.iconData.isCustom);
    
    if(icon.iconData.isCustom){
        if([icon.iconData isKindOfClass:[Sensor class]]){
            [self showDropDownByType:ICON_SENSOR isEditing:YES typeData:icon.iconData representingIcon:icon];
        } else if([icon.iconData isKindOfClass:[Listener class]]){
            [self showDropDownByType:ICON_LISTENER isEditing:YES typeData:icon.iconData representingIcon:icon];
        } else if([icon.iconData isKindOfClass:[Region class]]){
            [self showDropDownByType:ICON_REGION isEditing:YES typeData:icon.iconData representingIcon:icon];
        } else if([icon.iconData isKindOfClass:[Action class]]){
            
        }
    } else {
        
    }
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
                [self showDropDownByType:ICON_ACTUATOR isEditing:NO typeData:nil representingIcon:nil];
            } else if(self.selectedCategory.iconType == ICON_SENSOR){
                NSLog(@"CTS sensor");
                [self showDropDownByType:ICON_SENSOR isEditing:NO typeData:nil representingIcon:nil];
            } else if(self.selectedCategory.iconType == ICON_REGION){
                [self showDropDownByType:ICON_REGION isEditing:NO typeData:nil representingIcon:nil];
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
    [self addNewIconInCategory:iconCategory iconType:iconType andIconImage:iconImage andDelegate:delegate andTag:tag subtitle:subtitle andData:nil];
}

-(void)addNewIconInCategory:(ICON_TYPE)iconCategory iconType:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag subtitle:(NSString *)subtitle andData:(TypeData *)iconData{
    
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
        
        case ICON_COMPARATOR:
            NSLog(@"CTS iconComparator");
            NSLog(@"CTS comparatorType: %i", ((Comparator *)iconData).type);
            NSLog(@"CTS iconCategory: %i", iconCategory);
            thisArray = self.comparatorsArray;
            break;
            
        case ICON_VALUE:
            NSLog(@"CTS iconValue");
            thisArray = self.valueArray;
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
    NSInteger tagNum = (iconCategory * 100) + thisArray.count;
    
    [icon setTag:tagNum];
    
    if([iconData isKindOfClass:[Comparator class]]){
        NSLog(@"CTS iconData is comparator");
    }
    
    [icon setIconData:iconData];
    
    if(delegate != nil){
        [icon setMyDelegate:delegate];
    } else {
        [icon setMyDelegate:self];
    }
    
    [thisArray addObject:icon];
    
    if(iconCategory == self.selectedCategory.iconType){
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

@end
