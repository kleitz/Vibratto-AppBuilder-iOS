//
//  ListenerDropDown.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/20/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "ListenerDropDown.h"

@implementation ListenerDropDown

-(id)initWithFrame:(CGRect)frame{
    NSLog(@"ADD initWithFrame");
    self = [super initWithFrame:frame];
    
    if(self){
        self.hasIcons = YES;
        self.namePlaceholder = @"Name (Optional)";
        
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_CUSTOM]];
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_ANNOUNCER]];
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_ACTUATOR]];
        [self.iconTypes addObject:[NSNumber numberWithInt:ICON_LIGHTNING]];
        
        [self createTextField:self.namePlaceholder];
        
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, [self getProjectedHeight])];
        
        [self setFieldName:@"Add Listener"];
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
        }
    }
    
    [super okButtonClicked];
    
    NSLog(@"ADD name: %@", self.name);
}

@end
