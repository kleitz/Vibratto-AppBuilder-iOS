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
        
        [self createTextField:@"Name (Optional)"];
        [self createTextField:@"Pin Number" keyboardType:UIKeyboardTypeNumberPad];
        [self createTextField:@"Sensitivity (Optional)" keyboardType:UIKeyboardTypeNumberPad];
        
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

@end
