//
//  ActuatorDropDown.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/19/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "ActuatorDropDown.h"

@implementation ActuatorDropDown

-(id)initWithFrame:(CGRect)frame{
    NSLog(@"ADD initWithFrame");
    self = [super initWithFrame:frame];
    
    if(self){
        self.hasIcons = YES;
        
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_CUSTOM]];
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_ANNOUNCER]];
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_ACTUATOR]];
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_LIGHTNING]];
        
        [self createTextField:@"Name (Optional)"];
        [self createTextField:@"Pin Number" keyboardType:UIKeyboardTypeNumberPad];
        
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, [self getProjectedHeight])];
        
        [self setFieldName:@"Add Actuator"];
        [self addFields];

        if(self.hasIcons){
            [self displayIcons];
        }
        
        [self setButtons];
    }
    
    return self;
}

@end