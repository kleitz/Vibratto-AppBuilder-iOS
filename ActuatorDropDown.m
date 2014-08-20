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
        
        for(int i=0; i<10; i++){
            [self.iconTypes addObject:[NSNumber numberWithInt:i]];
        }
        
        [self createTextField:@"Name (Optional)"];
        [self createTextField:@"Pin Number" keyboardType:UIKeyboardTypeNumberPad];
        
        NSLog(@"ADD textFields count: %i", self.textFields.count);
        
        CGFloat ddHeight = self.titleY + self.abc.dropDownGroupBuffer + (self.abc.dropDownMenuFeildHeight + (self.abc.dropDownFieldBuffer * 2)) + self.abc.dropDownGroupBuffer;
        if(self.hasIcons){
            ddHeight += self.iconBoxHeight;
        }
        
        ddHeight += self.abc.dropDownMenuFeildHeight * 1.3f;
        
        NSLog(@"Add textFields height: %f", ddHeight);
        
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, ddHeight)];
        
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
