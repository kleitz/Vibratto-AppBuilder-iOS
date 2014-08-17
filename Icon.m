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
        self.customValue = 0;
        self.constants = [AppBuilderConstants getAppBuilderConstants];
        self.isHighlighted = NO;
        self.iconType = ICON_CUSTOM;
        self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * ((1.0f - self.constants.iconImagePercent)/2), self.frame.size.height * ((1.0f - self.constants.iconImagePercent)/2), self.frame.size.width * self.constants.iconImagePercent, self.frame.size.height * self.constants.iconImagePercent)];
        self.customImage = [[UIImage alloc] init];
        self.layer.cornerRadius = self.frame.size.width/2;
        
        self.customLabel = [[UILabel alloc] init];
        [self.customLabel setTextAlignment:NSTextAlignmentCenter];
        [self.customLabel setBackgroundColor:[UIColor clearColor]];
        //[self addSubview:self.customLabel];
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

-(void)changeCustomValue:(int)customValue setAsIconType:(BOOL)changeIconType{
    self.customValue = customValue;
    if(changeIconType){
        [self changeIconType:ICON_CUSTOM_VALUE];
    }
}

-(void)changeIconType:(ICON_TYPE)iconType{
    //NSLog(@"Icon changeIconType");
    [self setIconType:iconType];
    [self.customLabel removeFromSuperview];
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
        
        case ICON_GESTURE:
            [self.bgImage setImage:self.constants.gestureImageDefault];
            break;
        
        case ICON_REGION:
            [self.bgImage setImage:self.constants.regionImageDefault];
            break;
        
        case ICON_COMPARATOR:
            [self.bgImage setImage:self.constants.comparatorImage];
            break;
        
        case ICON_GREATERTHEN:
            [self.bgImage setImage:self.constants.greaterThenImage];
            break;
        
        case ICON_LESSTHEN:
            [self.bgImage setImage:self.constants.lessThenImage];
            break;
            
        case ICON_LISTENER:
            [self.bgImage setImage:self.constants.listenerImageDefault];
            break;
        
        case ICON_UPLOAD:
            [self.bgImage setImage:self.constants.uploadImageDefault];
            break;
            
        case ICON_MAP:
            [self.bgImage setImage:self.constants.mapImageDefault];
            break;
            
        case ICON_TILT:
            [self.bgImage setImage:self.constants.tiltImageDefault];
            break;
        
        case ICON_NUMBER:
            [self.bgImage setImage:self.constants.numberImage];
            break;
        
        case ICON_DECREASE_POWER:
            [self.bgImage setImage:self.constants.decreasePowerImage];
            break;
        
        case ICON_INCREASE_POWER:
            [self.bgImage setImage:self.constants.increasePowerImage];
            break;
        
        case ICON_ALL:
            [self.bgImage setImage:self.constants.allImage];
            break;
        
        case ICON_CONFIRM:
            [self.bgImage setImage:self.constants.confirmImage];
            break;

        case ICON_CUSTOM_VALUE:
            [self.customLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self.customLabel.layer setCornerRadius:self.frame.size.height];
            [self.customLabel setText:[NSString stringWithFormat:@"%i", self.customValue]];
            [self addSubview:self.customLabel];
            
        case ICON_CUSTOM:
            [self.bgImage setImage:self.customImage];
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
