//
//  DeviceViewController.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "DeviceViewController.h"
#import "AppBuilderConstants.h"
#import "CompoundTopSection.h"
#import "ActuatorDropDown.h"
#import "SensorDropDown.h"
#import "ListenerDropDown.h"
#import "RegionDropDown.h"
#import "TypeData.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController

-(id)initWithFrame:(CGRect)frame{
    NSLog(@"DeviceViewController init");
    self = [super initWithFrame:frame];
    if(self){
        self.abc = [AppBuilderConstants getAppBuilderConstants];
        self.buildStage = PRE_SELECT;
        
        self.ifLabel = [[UILabel alloc] init];
        self.isLabel = [[UILabel alloc] init];
        self.applyLabel = [[UILabel alloc] init];
        self.ontoLabel = [[UILabel alloc] init];
        
        self.actuators = [[NSMutableArray alloc] init];
        self.sensors = [[NSMutableArray alloc] init];
        self.regions = [[NSMutableArray alloc] init];
        self.gestures = [[NSMutableArray alloc] init];
        self.listeners = [[NSMutableArray alloc] init];
        
        self.sensorIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        self.comparatorIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        self.valueIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        self.gestureIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        self.regionIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        
        [self.sensorIcon.subtitle setTextColor:[UIColor whiteColor]];
        [self.sensorIcon.subtitle setFont:self.abc.builderIconSubtitleFont];
        
        [self.comparatorIcon.subtitle setTextColor:[UIColor whiteColor]];
        [self.comparatorIcon.subtitle setFont:self.abc.builderIconSubtitleFont];
        
        [self.valueIcon.subtitle setTextColor:[UIColor whiteColor]];
        [self.valueIcon.subtitle setFont:self.abc.builderIconSubtitleFont];
        
        [self.gestureIcon.subtitle setTextColor:[UIColor whiteColor]];
        [self.gestureIcon.subtitle setFont:self.abc.builderIconSubtitleFont];
        
        [self.regionIcon.subtitle setTextColor:[UIColor whiteColor]];
        [self.regionIcon.subtitle setFont:self.abc.builderIconSubtitleFont];
        
        int tagBase = 1000;
        
        [self.sensorIcon setTag:tagBase + ICON_SENSOR];
        [self.comparatorIcon setTag:tagBase + ICON_COMPARATOR];
        [self.valueIcon setTag:tagBase + ICON_VALUE];
        [self.gestureIcon setTag:tagBase + ICON_GESTURE];
        [self.regionIcon setTag:tagBase + ICON_REGION];
        
        [self.sensorIcon setMyDelegate:self];
        [self.comparatorIcon setMyDelegate:self];
        [self.valueIcon setMyDelegate:self];
        [self.gestureIcon setMyDelegate:self];
        [self.regionIcon setMyDelegate:self];
        
        self.confirmListenerIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.confirmListenerButtonHeight, self.abc.confirmListenerButtonHeight)];
        [self.confirmListenerIcon changeIconType:ICON_CONFIRM];
        [self.confirmListenerIcon setMyDelegate:self];
        [self.confirmListenerIcon setTag:2];
        
        self.createdListenerIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.iconHeight, self.abc.iconHeight)];
        [self.createdListenerIcon setMyDelegate:self];
        [self.createdListenerIcon setTag:3];
        
        [self initLabel:self.ifLabel text:@"If" andSize:self.ifSize];
        [self.ifLabel setText:@"If"];

        [self initLabel:self.isLabel text:@"is" andSize:self.isSize];
        [self.isLabel setText:@"is"];
        
        [self initLabel:self.applyLabel text:@"then" andSize:self.applySize];
        [self.applyLabel setText:@"then"];
        
        [self initLabel:self.ontoLabel text:@"on" andSize:self.ontoSize];
        [self.ontoLabel setText:@"on"];
        
        self.ifSize = [@"If" sizeWithFont:self.abc.labelFont];
        self.isSize = [@"is" sizeWithFont:self.abc.labelFont];
        self.applySize = [@"then" sizeWithFont:self.abc.labelFont];
        self.ontoSize = [@"on" sizeWithFont:self.abc.labelFont];
        
        self.arrow1 = [[UIImageView alloc] initWithImage:self.abc.rightArrowImage];
        
        //-------------
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.abc.topBoxHeight * -1, self.frame.size.width, self.frame.size.height + self.abc.topBoxHeight + self.abc.topBoxHeight)];
        [self.mainView setBackgroundColor:self.abc.primaryColor4];
        [self addSubview:self.mainView];
        
        self.topSection = [[CompoundTopSection alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2 * self.abc.topBoxHeight)];
        [self.topSection setDelegate:self];
        [self.topSection setCompoundDelegate:self];
        
        self.bottomSection = [[TopBox alloc] initWithFrame:CGRectMake(0, self.frame.size.height + self.abc.topBoxHeight, self.mainView.frame.size.width, self.abc.topBoxHeight) andHasAddBox:NO];
        [self.bottomSection setDelegate:self];
        [self.bottomSection changeTrayColor:self.abc.primaryColor3];
        
        [self.bottomSection addIcon:ICON_UPLOAD andIconImage:nil andDelegate:self andTag:3 andSubtitle:@"Upload" andIconData:nil];
        [self.bottomSection addIcon:ICON_SAVE andIconImage:nil andDelegate:self andTag:4 andSubtitle:@"Save" andIconData:nil];
        [self.bottomSection addIcon:ICON_CANCEL andIconImage:nil andDelegate:self andTag:5 andSubtitle:@"Cancel" andIconData:nil];
        
        [self.bottomSection changeIsCentered:YES];
        
        self.bigAddIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.bigAddButtonHeight, self.abc.bigAddButtonHeight)];
        [self.bigAddIcon changeIconType:ICON_ADD];
        [self.bigAddIcon setTag:1];
        [self.bigAddIcon setMyDelegate:self];
        
        [self.mainView addSubview:self.topSection];
        [self.mainView addSubview:self.bottomSection];
        
        [self gotoStage:PRE_SELECT];
        [self.mainView addSubview:self.uploadIcon];
    }
    
    return self;
}

-(void)initLabel:(UILabel *)label text:(NSString *)text andSize:(CGSize)labelSize{

    [label setTextColor:[UIColor whiteColor]];
    [label setFont:self.abc.labelFont];
    [label setBackgroundColor:[UIColor clearColor]];
}

-(void)collapsingStarted:(DropDownMenu *)newItem{
    NSLog(@"DVC collapsingStarted");
    if([newItem isKindOfClass:[ListenerDropDown class]]){
        NSLog(@"DVC newItem is a listenerDropDown");
        [self gotoStage:BUILD_LISTENER];
    }
}

-(void)processStage{
    if(self.buildStage == self.frontierStage){
        [self gotoStage: self.nextStage];
    } else {
        [self gotoStage: self.frontierStage];
    }
}

-(void)addedNewItemFromDropDown:(DropDownMenu *)newItem{
    NSLog(@"DVC addedNewItemFromDropDown");
    
    TypeData *iconData;
    
    if([newItem isKindOfClass:[ActuatorDropDown class]]){
        ActuatorDropDown *thisActuatorDropDown = ((ActuatorDropDown *)newItem);
        
        Actuator *thisActuator = [[Actuator alloc] init];
        [thisActuator setIsCustom:YES];
        
        [thisActuator setPinNumber:thisActuatorDropDown.pinNumber];
        
        iconData = thisActuator;
        
        [self.actuators addObject:thisActuator];
    } else if([newItem isKindOfClass:[SensorDropDown class]]){
        SensorDropDown *thisSensorDropDown = ((SensorDropDown *)newItem);
        
        Sensor *thisSensorData = [[Sensor alloc] init];
        [thisSensorData setIsCustom:YES];
        
        [thisSensorData setPinNumber:thisSensorDropDown.pinNumber];
        
        NSLog(@"DVC sensor name: %@", thisSensorDropDown.name);
        
        if(![thisSensorDropDown.name isEqualToString:@""] && thisSensorDropDown.name != nil){
            NSLog(@"DVC sensor has name");
            [thisSensorData setName:thisSensorDropDown.name];
            [thisSensorData setHasName:YES];
        } else {
            NSLog(@"DVC sensor doesnt have name");
            [thisSensorData setHasName:NO];
            [newItem setName:[NSString stringWithFormat:@"%i", thisSensorDropDown.pinNumber]];
        }
        
        [thisSensorData setSensitivity:thisSensorDropDown.sensitivity];
        
        [self.sensors addObject:thisSensorData];
        
        iconData = thisSensorData;
        
    } else if([newItem isKindOfClass:[RegionDropDown class]]){
        NSLog(@"DVC newItem is regionDropDown");
        RegionDropDown *thisRegionDropDown = ((RegionDropDown *)newItem);
        
        NSMutableArray *selectedActuators = [[NSMutableArray alloc] init];
        for(int i=0; i<thisRegionDropDown.regionIcons.count; i++){
            Icon *thisActuatorIcon = [thisRegionDropDown.regionIcons objectAtIndex:i];
            if(thisActuatorIcon.isHighlighted){
                [selectedActuators addObject:thisActuatorIcon.iconData];
            }
        }
        
        Region *thisRegionData = [[Region alloc] initWithName:newItem.name andActuators:selectedActuators isCustom:YES];
        iconData = thisRegionData;
        
        [self.regions addObject:thisRegionData];
        
    } else if([newItem isKindOfClass:[ListenerDropDown class]]){
        NSLog(@"DVC newItem is listenerDropDown");
        
        Comparator *comparatorData = ((Comparator *)self.comparatorIcon.iconData);
        
        NSLog(@"DVC comparator iconType: %i", comparatorData.type);
        
        ListenerDropDown *thisListenerDropDown = ((ListenerDropDown *)newItem);
        
        Listener *thisListener = [[Listener alloc] init];
        [thisListener setIsCustom:YES];
        
        [thisListener setName:thisListenerDropDown.name];
        
        if([self.valueIcon.iconData isKindOfClass:[TriggerValue class]]){
            NSLog(@"DVC sensorGreaterThenValue");
            
            if(comparatorData.type == ICON_GREATERTHEN){
                [thisListener setType:@"sensorGreaterThenValue"];
            } else if(comparatorData.type == ICON_LESSTHEN){
                [thisListener setType:@"sensorLessThenValue"];
            }
            
            
            [thisListener setTriggerType:SENSOR_TO_VALUE];
            
            TriggerValue *thisValueData = ((TriggerValue *)self.valueIcon.iconData);
            
            [thisListener setTriggerValue:thisValueData.triggerValue];
            
            Sensor *thisSensorData = ((Sensor *)self.sensorIcon.iconData);
            
            if(thisSensorData.hasName){
                [thisListener setSensor:thisSensorData.name];
            } else {
                [thisListener setSensorPin:thisSensorData.pinNumber];
            }
            
        } else {
            NSLog(@"DVC sensorGreaterThenSensor");
            
            if(comparatorData.type == ICON_GREATERTHEN){
                [thisListener setType:@"sensorGreaterThenSensor"];
            } else if(comparatorData.type == ICON_LESSTHEN){
                [thisListener setType:@"sensorLessThenSensor"];
            }

            [thisListener setTriggerType:SENSOR_TO_SENSOR];
            
            Sensor *sensorAData = ((Sensor *)self.sensorIcon.iconData);
            
            if(sensorAData.hasName){
                [thisListener setSensorA:sensorAData.name];
            } else {
                [thisListener setSensorAPin:sensorAData.pinNumber];
            }
            
            
            Sensor *sensorBData = ((Sensor *)self.valueIcon.iconData);
            
            if(sensorBData.hasName){
                [thisListener setSensorB:sensorBData.name];
            } else {
                [thisListener setSensorBPin:sensorBData.pinNumber];
            }
            
            
            //thisListener setValueName:targetSensorData
        }
        
        Action *thisActionData = ((Action *)self.gestureIcon.iconData);
        
        if(thisActionData.isCustom){
            [thisListener setGesture:thisActionData.name];
        } else {
            [thisListener setAction:thisActionData.name];
        }
        
        Region *thisRegionData = ((Region *)self.regionIcon.iconData);
        
        [thisListener setRegion:thisRegionData.name];
        
        NSLog(@"DVC createListener: type: %@, sensorPin: %i, sensorName: %@, sensorAPin: %i, sensorAName: %@, sensorBPin: %i, sensorBName: %@, value: %i, action: %@, gesture: %@, region: %@", thisListener.type, thisListener.sensorPin, thisListener.sensor, thisListener.sensorAPin, thisListener.sensorA, thisListener.sensorBPin, thisListener.sensorB, thisListener.triggerValue, thisListener.action, thisListener.gesture, thisListener.region);
        
        NSLog(@"DVC added listener, new length: %li", (long)self.listeners.count);

        
        /*
        if(comparatorData.type == ICON_GREATERTHEN){


        } else if(self.comparatorIcon.iconType == ICON_LESSTHEN){
            if([self.valueIcon.iconData isKindOfClass:[TriggerValue class]]){
                [thisListener setType:@"sensorLessThenValue"];
            } else {
                [thisListener setType:@"sensorLessThenSensor"];
            }
        }
        */
        
        iconData = thisListener;
        
        [self.listeners addObject:thisListener];
        
        //[self.sensorIcon removeFromSuperview];
        [self.sensorIcon changeIconType:ICON_CUSTOM];
        [self.sensorIcon changeSubtitle:nil];
        
        //[self.comparatorIcon removeFromSuperview];
        [self.comparatorIcon changeIconType:ICON_CUSTOM];
        [self.comparatorIcon changeSubtitle:nil];
        
        //[self.valueIcon removeFromSuperview];
        [self.valueIcon changeIconType:ICON_CUSTOM];
        [self.valueIcon changeSubtitle:nil];
        
        //[self.gestureIcon removeFromSuperview];
        [self.gestureIcon changeIconType:ICON_CUSTOM];
        [self.gestureIcon changeSubtitle:nil];
        
        //[self.regionIcon removeFromSuperview];
        [self.regionIcon changeIconType:ICON_CUSTOM];
        [self.regionIcon changeSubtitle:nil];
    }
    
    NSLog(@"DVC selected iconType: %i, dropDownTypeIcon: %i", newItem.selectedIcon.iconType, newItem.dropDownTypeIcon);
    
    ICON_TYPE usingIconType;
    
    if(newItem.selectedIcon.iconType == 0){
        NSLog(@"DVC Going to change iconType");
        usingIconType = newItem.dropDownTypeIcon;
    } else {
        usingIconType = newItem.selectedIcon.iconType;
    }
    
    NSLog(@"DVC selected iconType: %i, dropDownTypeIcon: %i", newItem.selectedIcon.iconType, newItem.dropDownTypeIcon);
    
    if(self.topSection.selectedCategory.iconType == ICON_SENSOR){
        [self.topSection addNewIconInCategory:ICON_VALUE iconType:usingIconType andIconImage:nil andDelegate:self.topSection andTag:0 subtitle:newItem.name andData:iconData];
    }
    
    [self.topSection addNewIconInCategory:self.topSection.selectedCategory.iconType iconType:usingIconType andIconImage:nil andDelegate:self.topSection andTag:0 subtitle:newItem.name andData:iconData];

}

-(NSArray *)returnActuatorsForJson{
    long long numTrackerLL = 1;
    
    NSLog(@"DVC returnActuatorsForJson");
    //NSLog(@"DVC numTracker pre: %lli", numTrackerLL);
    //numTrackerLL = numTrackerLL << 10;
    
    //NSLog(@"DVC numTracker post: %lli", numTrackerLL);
    
    //long numTrackerL = 0;
    //int numTrackerInt = 1;
    
    //NSLog(@"longlong: %lu, long: %lu, int: %lu", sizeof(numTrackerLL), sizeof(numTrackerL), sizeof(numTrackerInt));
    
    NSMutableArray *actuatorArray = [[NSMutableArray alloc] init];
    for(int i=0; i<self.actuators.count; i++){
        Actuator *thisActuator = [self.actuators objectAtIndex:i];
        long long starter = 1;
        int shiftAmount = thisActuator.pinNumber - 1;
        
        long long shiftedNum = starter << shiftAmount;
        
        numTrackerLL = numTrackerLL | shiftedNum;
        
        //[actuatorArray addObject:[NSNumber numberWithInt:thisActuator.pinNumber]];
    }
    
    for (int i=0; i<self.regions.count; i++){
        Region *thisRegion = [self.regions objectAtIndex:i];

        for(int j=0; j<thisRegion.actuators.count; j++){
            Actuator *thisActuator = [thisRegion.actuators objectAtIndex:j];
            long long starter = 1;
            int shiftAmount = thisActuator.pinNumber - 1;
            
            long long shiftedNum = starter << shiftAmount;
            
            numTrackerLL = numTrackerLL | shiftedNum;

        }

    }
    
    for(int i=0; i<(sizeof(numTrackerLL) * 8); i++){
        long long starter = 1;
        long long shiftedNum = starter << i;
        
        if(shiftedNum & numTrackerLL){
            [actuatorArray addObject:[NSNumber numberWithInt:(i + 1)]];
        }
    }
    
    return actuatorArray;
}

-(NSArray *)returnSensorsForJson{
    NSMutableArray *sensorArray = [[NSMutableArray alloc] init];
    for(int i=0; i<self.sensors.count; i++){
        Sensor *thisSensor = [self.sensors objectAtIndex:i];
        NSMutableDictionary *thisSensorDictionary = [[NSMutableDictionary alloc] init];
        
        if(thisSensor.hasName){
            [thisSensorDictionary setObject:thisSensor.name forKey:@"name"];
        }
        
        if(thisSensor.sensitivity >= 0){
            [thisSensorDictionary setObject:[NSNumber numberWithInt:thisSensor.sensitivity] forKey:@"sensitivity"];
        }
        
        [thisSensorDictionary setObject:[NSNumber numberWithInt:thisSensor.pinNumber] forKey:@"pin"];
        
        [sensorArray addObject:thisSensorDictionary];
    }
    
    return sensorArray;
}

-(NSArray *)returnRegionForJson{
    NSMutableArray *regionArray = [[NSMutableArray alloc] init];
    for(int i=0; i<self.regions.count; i++){
        Region *thisRegion = [self.regions objectAtIndex:i];
        NSMutableDictionary *thisRegionDictionary = [[NSMutableDictionary alloc] init];
        [thisRegionDictionary setObject:thisRegion.name forKey:@"name"];
        
        NSMutableArray *componentsArray = [[NSMutableArray alloc] init];
        for(int j=0; j<thisRegion.actuators.count; j++){
            Actuator *thisActuator = [thisRegion.actuators objectAtIndex:j];
            [componentsArray addObject:[NSNumber numberWithInt:thisActuator.pinNumber]];
        }
        
        [thisRegionDictionary setObject:componentsArray forKey:@"components"];
        
        [regionArray addObject:thisRegionDictionary];
    }
    
    return regionArray;
}

-(NSArray *)returnListenersForJson{
    NSMutableArray *listenersArray = [[NSMutableArray alloc] init];
    NSLog(@"DVC Listeners count: %li", (long)self.listeners.count);
    
    for(int i=0; i<self.listeners.count; i++){
        Listener *thisListener = [self.listeners objectAtIndex:i];
        NSMutableDictionary *thisListenerDictionary = [[NSMutableDictionary alloc] init];
        
        [thisListenerDictionary setObject:thisListener.type forKey:@"type"];
        
        NSLog(@"DVC sensorTriggerType: %i", thisListener.triggerType);
        
        if(thisListener.triggerType == MAP){
        
        } else if(thisListener.triggerType == SENSOR_TO_VALUE){
            NSLog(@"DVC sensorName: %@", thisListener.sensor);
            if(thisListener.sensor != nil){
                [thisListenerDictionary setObject:thisListener.sensor forKey:@"sensor"];
            } else {
                [thisListenerDictionary setObject:[NSNumber numberWithInt:thisListener.sensorPin] forKey:@"sensor"];
            }
            
            [thisListenerDictionary setObject:[NSNumber numberWithInt:thisListener.triggerValue] forKey:@"value"];
        } else if(thisListener.triggerType == SENSOR_TO_SENSOR){
            NSLog(@"DVC sensorToSensor");
            if(thisListener.sensorA != nil){
                [thisListenerDictionary setObject:thisListener.sensorA forKey:@"sensorA"];
            } else {
                [thisListenerDictionary setObject:[NSNumber numberWithInt:thisListener.sensorAPin] forKey:@"sensorA"];
            }
            
            if(thisListener.sensorB != nil){
                [thisListenerDictionary setObject:thisListener.sensorB forKey:@"sensorB"];
            } else {
                [thisListenerDictionary setObject:[NSNumber numberWithInt:thisListener.sensorBPin] forKey:@"sensorB"];
            }
        }
        
        if(thisListener.action != nil){
            [thisListenerDictionary setObject:thisListener.action forKey:@"action"];
        } else {
            [thisListenerDictionary setObject:thisListener.gesture forKey:@"gesture"];
        }
        
        [thisListenerDictionary setObject:thisListener.region forKey:@"region"];
        
        [listenersArray addObject:thisListenerDictionary];
    }
    
    NSLog(@"DVC listnersArray count: %li", (long)listenersArray.count);
    
    return listenersArray;
}

-(void)iconLongPressed:(Icon *)icon{
    NSLog(@"DVC iconLongPressed: %li", (long)icon.tag);
    
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"DVC iconClicked: %li, buildStage: %i", (long)icon.tag, self.buildStage);
    if(icon.tag == 1){
        NSLog(@"DVC big add button");
        [self processStage];
    } else if(icon.tag == 2){
        NSLog(@"DVC confirm listener clicked");
        
        [self gotoStage:self.nextStage];
        //[self processStage];
    } else if(icon.tag == 3){
        NSLog(@"DVC Upload Button Clicked");
        NSMutableDictionary *message = [[NSMutableDictionary alloc] init];
        //create actuators
        [message setObject:[self returnActuatorsForJson] forKey:@"actuators"];
        //create sensors
        [message setObject:[self returnSensorsForJson] forKey:@"sensors"];
        //create regions
        [message setObject:[self returnRegionForJson] forKey:@"regions"];
        //create gestures
        
        //create listeners
        [message setObject:[self returnListenersForJson] forKey:@"listeners"];
        
        NSData *messageJSON = [NSJSONSerialization dataWithJSONObject:message options:0 error:nil];
        NSString *messageString = [[NSString alloc] initWithData:messageJSON encoding:NSUTF8StringEncoding];
        
        NSLog(@"DVC About to sendMessageString: %@", messageString);
    } else if(icon.tag == 4){
        NSLog(@"DVC Save clicked");
        for(int i=self.mainView.subviews.count -1; i>=0; i--){
            [[self.mainView.subviews objectAtIndex:i] removeFromSuperview];
        }
        
        CGFloat topWidth = self.superview.frame.size.width;
        CGFloat topHeight = self.superview.frame.size.height;
        
        [UIView animateWithDuration:0.45f animations:^{
            [self.mainView.layer setCornerRadius:(self.abc.primaryButtonDiameter/2)];
            [self.mainView setFrame:CGRectMake((topWidth/2) - (self.abc.primaryButtonDiameter/2), (topHeight/2) - (self.abc.primaryButtonDiameter/2), self.abc.primaryButtonDiameter, self.abc.primaryButtonDiameter)];
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.2f animations:^{
                [self.mainView setBackgroundColor:self.abc.seeThruColor];
            } completion:^(BOOL finished){
                [self.delegate sketchFinishedBuilding:self];
            }];
        }];
        
    } else if(icon.tag == 5){
        NSLog(@"DVC Cancel clicked");
        /*
        for(int i=self.mainView.subviews.count -1; i>=0; i--){
            [[self.mainView.subviews objectAtIndex:i] removeFromSuperview];
        }
        */
        
        CGFloat topWidth = self.superview.frame.size.width;
        CGFloat topHeight = self.superview.frame.size.height;
        
        [UIView animateWithDuration:0.45f animations:^{
            [self.mainView setFrame:CGRectMake(0, topHeight, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        } completion:^(BOOL finished){
            [self.delegate sketchCanceled:self];
        }];
        
    } else if(icon.tag >= (ICON_SENSOR * 100) && icon.tag < ((ICON_SENSOR * 100) + 100) && self.buildStage == SENSOR_SELECT){
        [self.sensorIcon changeIconType:icon.iconType];
        [self.sensorIcon setIconData:icon.iconData];
        
        if(icon.hasSubtitle){
            [self.sensorIcon changeSubtitle:icon.subtitle.text];
        }
    
        [self processStage];
    } else if(icon.tag >= (ICON_COMPARATOR * 100) && icon.tag < ((ICON_COMPARATOR * 100) + 100) && self.buildStage == COMPARATOR_SELECT){
        [self.comparatorIcon changeIconType:icon.iconType];
        [self.comparatorIcon setIconData:icon.iconData];
        
        if([icon.iconData isKindOfClass:[Comparator class]]){
            NSLog(@"DVC iconData is comparator");
        }
        
        NSLog(@"DVC picked comparatorIcon data: %i", ((Comparator *)icon.iconData).type);
        
        if(icon.hasSubtitle){
            [self.comparatorIcon changeSubtitle:icon.subtitle.text];
        }
        [self processStage];
    } else if(icon.tag == (ICON_VALUE * 100) && self.buildStage == VALUE_SELECT){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Set Value" message:@"Enter Value (0-1023)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [alertView setTag:1];
        [alertView show];
    } else if(icon.tag >= (ICON_VALUE * 100) && icon.tag < ((ICON_VALUE * 100) + 100) && self.buildStage == VALUE_SELECT){
        [self.valueIcon changeIconType:icon.iconType];
        [self.valueIcon setIconData:icon.iconData];
        
        if(icon.hasSubtitle){
            [self.valueIcon changeSubtitle:icon.subtitle.text];
        }
        [self processStage];
    } else if(icon.tag >= (ICON_GESTURE * 100) && icon.tag < ((ICON_GESTURE * 100) + 100) && self.buildStage == ACTION_SELECT){
        [self.gestureIcon changeIconType:icon.iconType];
        [self.gestureIcon setIconData:icon.iconData];
        
        if(icon.hasSubtitle){
            [self.gestureIcon changeSubtitle:icon.subtitle.text];
        }
        [self processStage];
    } else if(icon.tag >= (ICON_REGION * 100) && icon.tag < ((ICON_REGION * 100) + 100) && self.buildStage == REGION_SELECT){
        [self.regionIcon changeIconType:icon.iconType];
        [self.regionIcon setIconData:icon.iconData];
        
        if(icon.hasSubtitle){
            [self.regionIcon changeSubtitle:icon.subtitle.text];
        }
        [self processStage];
    } else if(icon.tag >= 1000 && icon.tag <2000){
        NSInteger tagAdjust = icon.tag - 1000;
        
        switch (tagAdjust) {
            case ICON_SENSOR:
                [self gotoStage:SENSOR_SELECT];
                break;
                
            case ICON_COMPARATOR:
                [self gotoStage:COMPARATOR_SELECT];
                break;
            
            case ICON_VALUE:
                [self gotoStage:VALUE_SELECT];
                break;
            
            case ICON_GESTURE:
                [self gotoStage:ACTION_SELECT];
                break;
            
            case ICON_REGION:
                [self gotoStage:REGION_SELECT];
                break;
                
            default:
                break;
        }
    }
}

-(void)highlightBuildStageIcon:(Icon *)icon{
    
    [icon.layer setBorderColor:self.abc.primaryColor2.CGColor];
    [icon.layer setBorderWidth:1.0f];
    
    if(self.buildStageIcon != nil){
        [self.buildStageIcon.layer setBorderWidth:0.0f];
        [self.buildStageIcon.layer setBorderColor:[UIColor clearColor].CGColor];
    }
    
    self.buildStageIcon = icon;
}

-(void)resetBuild{
    self.nextStage = PRE_SELECT;
    [self gotoStage:PRE_SELECT];
}

-(void)gotoStage:(BUILD_LISTENER_STATUS)stage{
    NSLog(@"DVC gotoStage, stage: %i", stage);
    
    switch (stage) {
        case PRE_SELECT:
            NSLog(@"DVC stage is pre select");
            
            self.buildStage = PRE_SELECT;
            if(self.nextStage == self.buildStage){
                NSLog(@"DVC going to insert bai");
                [self.bigAddIcon setFrame:CGRectMake((self.frame.size.width/2) - self.abc.bigAddButtonHeight/2, (self.frame.size.height/2) + (self.abc.topBoxHeight * 1.0) - self.abc.bigAddButtonHeight/2, self.abc.bigAddButtonHeight, self.abc.bigAddButtonHeight)];
                [self.bigAddIcon changeIconType:ICON_ADD];
                [self.bigAddIcon.layer setCornerRadius:self.abc.bigAddButtonHeight/2];
                
                NSLog(@"DVC bai x: %f, y: %f height: %f, width: %f", self.bigAddIcon.frame.origin.x, self.bigAddIcon.frame.origin.y, self.bigAddIcon.frame.size.height, self.bigAddIcon.frame.size.width);
                
                //[self.mainView addSubview:self.bigAddIcon];
                [self.mainView insertSubview:self.bigAddIcon belowSubview:self.topSection];
                self.frontierStage = PRE_SELECT;
                self.nextStage = SENSOR_SELECT;
            }
            
            break;
        
        case SENSOR_SELECT:{
            self.buildStage = SENSOR_SELECT;
            if(self.nextStage == self.buildStage){
                
                [UIView animateWithDuration:0.5f animations:^{
                    [self.bigAddIcon setFrame:CGRectMake(self.abc.builderBuffer + self.ifSize.width + self.abc.builderBuffer, 90.0f + self.abc.topBoxHeight, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                    [self.bigAddIcon.layer setCornerRadius:self.abc.builderIconHeight/2];
                    [self.bigAddIcon changeIconType:ICON_CUSTOM];
                } completion:^(BOOL finished){
                    [self.sensorIcon setFrame:CGRectMake(self.bigAddIcon.frame.origin.x, self.bigAddIcon.frame.origin.y, self.bigAddIcon.frame.size.width, self.bigAddIcon.frame.size.height)];
                    [self.mainView insertSubview:self.sensorIcon belowSubview:self.topSection];
                    
                    [self.bigAddIcon removeFromSuperview];
                    NSLog(@"DVC ifLabel width: %f, height: %f", self.ifSize.width, self.ifSize.height);
                    self.buildStage = SENSOR_SELECT;
                    
                    CGFloat heightAdjust = (self.bigAddIcon.frame.size.height - self.ifSize.height)/2;
                    [self.ifLabel setFrame:CGRectMake(self.abc.builderBuffer, 90.0f + self.abc.topBoxHeight + heightAdjust, self.ifSize.width, self.ifSize.height)];
                    
                    [self.mainView insertSubview:self.ifLabel belowSubview:self.topSection];
                    
                    self.frontierStage = SENSOR_SELECT;
                    self.nextStage = COMPARATOR_SELECT;
                }];
            }
            
            [self.topSection selectCategoryByType:ICON_SENSOR];
            [self highlightBuildStageIcon:self.sensorIcon];
            break;
        }
        
        case COMPARATOR_SELECT:
            self.buildStage = COMPARATOR_SELECT;
            if(self.nextStage == self.buildStage){
                [self.isLabel setFrame:CGRectMake(self.bigAddIcon.frame.size.width + self.bigAddIcon.frame.origin.x + self.abc.builderBuffer, self.bigAddIcon.frame.origin.y + (self.bigAddIcon.frame.size.height - self.isSize.height)/2, self.isSize.width, self.isSize.height)];
                [self.mainView insertSubview:self.isLabel belowSubview:self.topSection];
                //[self.mainView addSubview:self.isLabel];
                [self.comparatorIcon setFrame:CGRectMake(self.isLabel.frame.origin.x + self.isLabel.frame.size.width + self.abc.builderBuffer, self.bigAddIcon.frame.origin.y, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                [self.mainView insertSubview:self.comparatorIcon belowSubview:self.topSection];
                //[self.mainView addSubview:self.comparatorIcon];
                
                
                self.frontierStage = COMPARATOR_SELECT;
                self.nextStage = VALUE_SELECT;
            }
            
            [self.topSection selectCategoryByType:ICON_COMPARATOR];
            [self highlightBuildStageIcon:self.comparatorIcon];
            break;
        
        case VALUE_SELECT:
            self.buildStage = VALUE_SELECT;
            if(self.nextStage == self.buildStage){
                [self.valueIcon setFrame:CGRectMake(self.comparatorIcon.frame.origin.x + self.comparatorIcon.frame.size.width + self.abc.builderBuffer, self.comparatorIcon.frame.origin.y, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                [self.mainView insertSubview:self.valueIcon belowSubview:self.topSection];
                //[self.mainView addSubview:self.valueIcon];
                
                
                self.frontierStage = VALUE_SELECT;
                self.nextStage = ACTION_SELECT;
            }
            
            [self.topSection selectCategoryByType:ICON_VALUE];
            [self highlightBuildStageIcon:self.valueIcon];
            break;
        
        case ACTION_SELECT:
            self.buildStage = ACTION_SELECT;
            
            if(self.nextStage == self.buildStage){
                [self.applyLabel setFrame:CGRectMake(self.abc.builderBuffer, self.comparatorIcon.frame.origin.y + self.comparatorIcon.frame.size.height + self.abc.builderBuffer + ((self.comparatorIcon.frame.size.height - self.applySize.height)/2) + self.comparatorIcon.subtitle.frame.size.height, self.applySize.width, self.applySize.height)];
                
                [self.mainView insertSubview:self.applyLabel belowSubview:self.topSection];
                [self.gestureIcon setFrame:CGRectMake(self.applyLabel.frame.origin.x + self.applyLabel.frame.size.width + self.abc.builderBuffer, self.comparatorIcon.frame.size.height + self.comparatorIcon.frame.origin.y + self.abc.builderBuffer + self.comparatorIcon.subtitle.frame.size.height, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                
                [self.mainView insertSubview:self.gestureIcon belowSubview:self.topSection];
                
                self.frontierStage = ACTION_SELECT;
                self.nextStage = REGION_SELECT;
            }
            
            [self.topSection selectCategoryByType:ICON_GESTURE];
            [self highlightBuildStageIcon:self.gestureIcon];
            break;
        
        case REGION_SELECT:
            self.buildStage = REGION_SELECT;
            
            if(self.nextStage == self.buildStage){
                [self.ontoLabel setFrame:CGRectMake(self.gestureIcon.frame.origin.x + self.gestureIcon.frame.size.width + self.abc.builderBuffer, self.gestureIcon.frame.origin.y + ((self.gestureIcon.frame.size.height - self.ontoSize.height)/2), self.ontoSize.width, self.ontoSize.height)];
                
                [self.mainView insertSubview:self.ontoLabel belowSubview:self.topSection];
                
                [self.regionIcon setFrame:CGRectMake(self.ontoLabel.frame.origin.x + self.ontoLabel.frame.size.width + self.abc.builderBuffer, self.gestureIcon.frame.origin.y, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                
                [self.mainView insertSubview:self.regionIcon belowSubview:self.topSection];
                
                self.frontierStage = REGION_SELECT;
                self.nextStage = CONFIRM_LISTENER;
            }
            
            [self.topSection selectCategoryByType:ICON_REGION];
            [self highlightBuildStageIcon:self.regionIcon];
            break;
        
        case CONFIRM_LISTENER:
            self.buildStage = CONFIRM_LISTENER;
            //if(self.nextStage == self.buildStage){
                [self.confirmListenerIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.confirmListenerButtonHeight/2, self.gestureIcon.frame.origin.y + self.gestureIcon.frame.size.height + self.abc.builderBuffer + self.gestureIcon.subtitle.frame.size.height, self.abc.confirmListenerButtonHeight, self.abc.confirmListenerButtonHeight)];
                [self.confirmListenerIcon changeIconType:ICON_CONFIRM];
            
                [self.mainView insertSubview:self.confirmListenerIcon belowSubview:self.topSection];
                
                self.frontierStage = CONFIRM_LISTENER;
                self.nextStage = NAME_LISTENER;
            //}
            
            [self highlightBuildStageIcon:self.confirmListenerIcon];
            break;
        
        case NAME_LISTENER:{
            self.buildStage = NAME_LISTENER;
            [self.topSection showDropDownByType:ICON_LISTENER isEditing:NO typeData:nil representingIcon:nil];
            break;
        }
            
        case BUILD_LISTENER:{
            self.buildStage = BUILD_LISTENER;

            [self.sensorIcon changeIconType:ICON_CUSTOM];
            [self.comparatorIcon changeIconType:ICON_CUSTOM];
            [self.valueIcon changeIconType:ICON_CUSTOM];
            [self.gestureIcon changeIconType:ICON_CUSTOM];
            [self.regionIcon changeIconType:ICON_CUSTOM];
            [self.confirmListenerIcon changeIconType:ICON_CUSTOM];

            [UIView animateWithDuration:0.5f animations:^{
             
                [self.sensorIcon setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.comparatorIcon setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.valueIcon setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.gestureIcon setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.regionIcon setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                
                [self.confirmListenerIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.iconHeight/2, self.mainView.center.y - self.abc.iconHeight/2, 0, 0)];
                [self.confirmListenerIcon.layer setCornerRadius:(self.abc.confirmListenerButtonHeight/2)];
                [self.confirmListenerIcon setBackgroundColor:self.abc.seeThruColor];
                
                [self.sensorIcon.subtitle setFrame:CGRectMake(0, 0, 0, 0)];
                [self.comparatorIcon.subtitle setFrame:CGRectMake(0, 0, 0, 0)];
                [self.valueIcon.subtitle setFrame:CGRectMake(0, 0, 0, 0)];
                [self.gestureIcon.subtitle setFrame:CGRectMake(0, 0, 0, 0)];
                [self.regionIcon.subtitle setFrame:CGRectMake(0, 0, 0, 0)];

                [self.ifLabel setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.isLabel setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.applyLabel setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.ontoLabel setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                
            } completion:^(BOOL finished){
                [self.confirmListenerIcon removeFromSuperview];
                
                
                [self.sensorIcon removeFromSuperview];
                //[self.sensorIcon changeIconType:ICON_CUSTOM];
                //[self.sensorIcon changeSubtitle:nil];
                
                [self.comparatorIcon removeFromSuperview];
                //[self.comparatorIcon changeIconType:ICON_CUSTOM];
                //[self.comparatorIcon changeSubtitle:nil];
                
                [self.valueIcon removeFromSuperview];
                //[self.valueIcon changeIconType:ICON_CUSTOM];
                //[self.valueIcon changeSubtitle:nil];
                
                [self.gestureIcon removeFromSuperview];
                //[self.gestureIcon changeIconType:ICON_CUSTOM];
                //[self.gestureIcon changeSubtitle:nil];
                
                [self.regionIcon removeFromSuperview];
                //[self.regionIcon changeIconType:ICON_CUSTOM];
                //[self.regionIcon changeSubtitle:nil];
                
                [self.ifLabel removeFromSuperview];
                [self.isLabel removeFromSuperview];
                [self.applyLabel removeFromSuperview];
                [self.ontoLabel removeFromSuperview];
                [self.ifLabel setFont:self.abc.labelFont];
                [self.isLabel setFont:self.abc.labelFont];
                [self.applyLabel setFont:self.abc.labelFont];
                [self.ontoLabel setFont:self.abc.labelFont];
                
                NSTimer *nextTimer = [NSTimer scheduledTimerWithTimeInterval:0.6f target:self selector:@selector(resetBuild) userInfo:nil repeats:NO];

            }];

            break;
        }
        default:
            break;
    }
}

-(void)dropDownOkClicked:(DropDownMenu *)ddm{
    [ddm removeFromSuperview];
    [self.mainView insertSubview:self.confirmListenerIcon belowSubview:self.topSection];
    
    [self gotoStage:BUILD_LISTENER];
}

-(void)dropDowncancelClicked:(DropDownMenu *)ddm{
    [ddm removeFromSuperview];
    [self.mainView insertSubview:self.confirmListenerIcon belowSubview:self.topSection];
    
    [UIView animateWithDuration:0.4f animations:^{
        [self.confirmListenerIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.confirmListenerButtonHeight/2, self.gestureIcon.frame.origin.y + self.gestureIcon.frame.size.height + self.abc.builderBuffer + self.gestureIcon.subtitle.frame.size.height, self.abc.confirmListenerButtonHeight, self.abc.confirmListenerButtonHeight)];
        [self.confirmListenerIcon.layer setCornerRadius:(self.abc.confirmListenerButtonHeight/2)];
        [self.confirmListenerIcon setBackgroundColor:self.abc.seeThruColor];
    } completion:^(BOOL finished){
        [self.confirmListenerIcon changeIconType:ICON_ADD];
        [self gotoStage:CONFIRM_LISTENER];
        [self.confirmListenerIcon.layer setBorderColor:self.abc.primaryColor2.CGColor];
        [self.confirmListenerIcon.layer setBorderWidth:1.0f];

    }];
}

-(void)showDropDown:(DropDownMenu *)dropDown{
    NSLog(@"DVC showDropDown");
    [dropDown setFrame:CGRectMake(0, self.topSection.frame.origin.y + self.topSection.frame.size.height - dropDown.frame.size.height, dropDown.frame.size.width, dropDown.frame.size.height)];
    [self.mainView insertSubview:dropDown belowSubview:self.topSection];
    //[self.mainView addSubview:dropDown];
    
    [UIView animateWithDuration:0.4f animations:^{
        [dropDown setFrame:CGRectMake(0, self.topSection.frame.origin.y + self.topSection.frame.size.height, dropDown.frame.size.width, dropDown.frame.size.height)];
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"DVC touchesBegan");
    self.isTouching = YES;
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    self.currentPoint = touchPoint;

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"DVC touchesMoved");
    UITouch *newTouch = [touches anyObject];
    CGPoint newPoint = [newTouch locationInView:self];
    CGPoint translation = CGPointMake(newPoint.x - self.currentPoint.x, newPoint.y - self.currentPoint.y);
    
    NSLog(@"CEV touchesMoved: %f", translation.y);
    if(self.mainView.frame.origin.y + translation.y <= 0 && self.mainView.frame.origin.y + translation.y >= (-2 * self.abc.topBoxHeight)){
        [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y + translation.y, self.mainView.frame.size.width, self.mainView.frame.size.height)];
    }
    /*
    if(self.mainView.frame.origin.y + translation.y <= -1 * self.abc.topBoxHeight || self.mainView.frame.origin.y + translation.y >= self.abc.topBoxHeight){
        //CGFloat viewRatio = (float)(self.mainView.frame.size.height + translation.y)/self.mainView.frame.size.height;
        //CGFloat invertRatio = 1.0 - viewRatio;
        //[self.mainView setFrame:CGRectMake(invertRatio * self.mainView.frame.size.width, invertRatio * self.mainView.frame.size.height, self.mainView.frame.size.width * viewRatio, self.mainView.frame.size.height * viewRatio)];
        
    } else if(self.mainView.frame.origin.y + translation.y < 0) {
        [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y + translation.y, self.mainView.frame.size.width, self.mainView.frame.size.height)];
    }
    */

    self.currentPoint = newPoint;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"DVC touchesEnded: mainView origin: %f, topBoxHeight 1.5: %f", self.mainView.frame.origin.y, -1.5 * self.abc.topBoxHeight);
    self.isTouching = NO;
    
    if(self.mainView.frame.origin.y < -1.5 * self.abc.topBoxHeight){
        [UIView animateWithDuration:0.2f animations:^{
            [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, self.abc.topBoxHeight * -2, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        }];
    } else if(self.mainView.frame.origin.y < -1 * (self.abc.topBoxHeight)/2){
        [UIView animateWithDuration:0.2f animations:^{
            [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, self.abc.topBoxHeight * -1, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, 0, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        }];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"DVC alertView clickedbutton: %li, tag: %li", (long)buttonIndex, (long)alertView.tag);
    if(alertView.tag == 1){
        NSLog(@"DVC value input alertview");
        
        if(buttonIndex == 1){
            int textVal = [[[alertView textFieldAtIndex:0] text] intValue];
            if(textVal < 1024){
                int inputValue = [[[alertView textFieldAtIndex:0] text] intValue];
                TriggerValue *valueData = [[TriggerValue alloc] init];
                [valueData setIsCustom:YES];
                [valueData setTriggerValue:inputValue];
                
                [self.valueIcon changeCustomValue:inputValue setAsIconType:YES];
                [self.valueIcon changeSubtitle:nil];
                [self.valueIcon setIconData:valueData];
                
                [self processStage];
            } else {
                //[self gotoStage:VALUE_SELECT];
            }
        }
    }
}

@end
