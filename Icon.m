//
//  Icon.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "Icon.h"

@implementation Icon

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.constants = [AppBuilderConstants getAppBuilderConstants];
        self.isHighlighted = NO;
        self.iconType = ICON_CUSTOM;
        self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * ((1.0f - self.constants.iconImagePercent)/2), self.frame.size.height * ((1.0f - self.constants.iconImagePercent)/2), self.frame.size.width * self.constants.iconImagePercent, self.frame.size.height * self.constants.iconImagePercent)];
        self.customImage = [[UIImage alloc] init];
        self.layer.cornerRadius = self.frame.size.width/2;
        //self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //self.layer.borderWidth = 1.0f;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClicked)];
        [self addGestureRecognizer:tapGesture];
        [self setBackgroundColor:self.constants.seeThruColor];
        [self addSubview:self.bgImage];
    }
    
    return self;
}

-(void)iconClicked{
    NSLog(@"Icon iconClicked");
    [self.myDelegate iconClicked:self];
}

-(void)toggleHighlighted{
    self.isHighlighted = !self.isHighlighted;
    
    if(self.isHighlighted){
        [self setBackgroundColor:self.constants.seeThruColorHighlight];
    } else {
        [self setBackgroundColor:self.constants.seeThruColor];
    }
}

-(void)changeIconType:(ICON_TYPE)iconType{
    //NSLog(@"Icon changeIconType");
    [self setIconType:iconType];
    switch (self.iconType) {
        case ICON_ADD:
            [self.bgImage setImage:self.constants.plusImage];
            break;
            
        case ICON_ACTUATOR:
            [self.bgImage setImage:self.constants.actuatorImageDefault];
            break;
            
        case ICON_SENSOR:
            [self.bgImage setImage:self.constants.sensorImageDefault];
            break;
            
        default:
            break;
    }
}
/*
- (void)drawRect:(CGRect)rect{
    
}
*/

@end
