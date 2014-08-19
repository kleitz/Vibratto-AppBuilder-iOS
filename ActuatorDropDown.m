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
        self.hasIcons = NO;
        
        [self createTextField:@"Name (Optional)"];
        [self createTextField:@"Pin Number"];
        
        NSLog(@"ADD textFields count: %i", self.textFields.count);
        
        CGFloat ddHeight = self.titleY + (self.textFields.count * self.abc.dropDownMenuFeildHeight);
        if(self.hasIcons){
            ddHeight += self.iconBoxHeight;
        }
        
        NSLog(@"Add textFields height: %f", ddHeight);
        
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, ddHeight)];
        
        [self setFieldName:@"Create Actuator"];
        [self addFields];
        
        if(self.hasIcons){
            [self displayIcons];
        }
    }
    
    return self;
}

@end
