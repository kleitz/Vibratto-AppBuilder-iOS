//
//  SensorDropDown.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/19/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "SensorDropDown.h"

@implementation SensorDropDown

-(id)initWithFrame:(CGRect)frame{
    NSLog(@"ADD initWithFrame");
    self = [super initWithFrame:frame];
    
    if(self){
        self.hasIcons = NO;
        
        self.dropDownTypeIcon = ICON_SENSOR;
        
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_CUSTOM]];
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_SENSOR]];
        
        self.pinNumberPlaceholder = @"Pin Number";
        self.sensitivityPlaceholder = @"Sensitivity (Optional)";
        self.namePlaceholder = @"Name (Optional)";
        
        [self createTextField:self.pinNumberPlaceholder keyboardType:UIKeyboardTypeNumberPad];
        [self createTextField:self.namePlaceholder];
        [self createTextField:self.sensitivityPlaceholder keyboardType:UIKeyboardTypeNumberPad];
        
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, [self getProjectedHeight])];
        
        [self setFieldName:@"Add Sensor"];
        [self addFields];
        
        if(self.hasIcons){
            [self displayIcons];
        }
        
        [self setButtons];
    }
    
    return self;
}

-(void)okButtonClicked{
    
    for(int i=0; i<self.textFields.count; i++){
        UITextField *thisTextField = [self.textFields objectAtIndex:i];
        if([thisTextField.placeholder isEqualToString:self.namePlaceholder]){
            if(![thisTextField.text isEqualToString: @""] && thisTextField.text != nil){
                self.name = thisTextField.text;
            } else {
                self.name = nil;
            }
        } else if([thisTextField.placeholder isEqualToString:self.pinNumberPlaceholder]){
            if(![thisTextField.text isEqualToString:@""] && thisTextField.text != nil){
                self.pinNumber = [thisTextField.text intValue];
            } else {
                self.pinNumber = 0;
            }
        } else if([thisTextField.placeholder isEqualToString:self.sensitivityPlaceholder]){
            if(![thisTextField.text isEqualToString:@""] && thisTextField.text != nil){
                NSLog(@"SDD Sensitivity is not empty: %@", thisTextField.text);
                self.sensitivity = [thisTextField.text intValue];
            } else {
                NSLog(@"SDD sensitivity is epty");
                self.sensitivity = -1;
            }
        }
    }
    
    NSLog(@"SDD name: %@, pinNumber: %i", self.name, self.pinNumber);
    
    [super okButtonClicked];
    
    NSLog(@"SDD name: %@, pinNumber: %i", self.name, self.pinNumber);
}

-(void)changeTypeData:(TypeData *)typeData{
    NSLog(@"SensorDropDown changeDataType");
    [super changeTypeData:typeData];
    
    if(typeData != nil){
        Sensor *sensorTypeData = (Sensor *)typeData;
        
        [[self getTextFieldByPlaceHolder:self.pinNumberPlaceholder] setText:[NSString stringWithFormat:@"%i", sensorTypeData.pinNumber]];
        [[self getTextFieldByPlaceHolder:self.namePlaceholder] setText:sensorTypeData.name];
        [self setFieldName:@"Edit Sensor"];
        
        if(sensorTypeData.sensitivity >= 0){
            [[self getTextFieldByPlaceHolder:self.sensitivityPlaceholder] setText:[NSString stringWithFormat:@"%i", sensorTypeData.sensitivity]];
        }
    }
}


@end
