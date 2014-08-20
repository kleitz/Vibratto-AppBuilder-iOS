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
        self.hasIcons = YES;
        
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_CUSTOM]];
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_SENSOR]];
        
        self.pinNumberPlaceholder = @"Pin Number";
        self.sensitivityPlaceholder = @"Sensitivity (Optional)";
        self.namePlaceholder = @"Name (Optional)";
        
        [self createTextField:self.namePlaceholder];
        [self createTextField:self.pinNumberPlaceholder keyboardType:UIKeyboardTypeNumberPad];
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
            if(![thisTextField.text isEqualToString: @""]){
                self.name = thisTextField.text;
            } else {
                self.name = nil;
            }
        } else if([thisTextField.placeholder isEqualToString:self.pinNumberPlaceholder]){
            if(![thisTextField.text isEqualToString:@""]){
                self.pinNumber = [thisTextField.text intValue];
            } else {
                self.pinNumber = 0;
            }
        } else if([thisTextField.placeholder isEqualToString:self.sensitivityPlaceholder]){
            if(![thisTextField.text isEqualToString:@""]){
                self.sensitivity = [thisTextField.text intValue];
            } else {
                self.sensitivity = -1;
            }
        }
    }
    
    [super okButtonClicked];
    
    NSLog(@"ADD name: %@, pinNumber: %i", self.name, self.pinNumber);
}


@end
