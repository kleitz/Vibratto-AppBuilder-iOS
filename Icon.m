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
    NSLog(@"Icon initWithFrame");
    if (self) {
        self.customValue = 0;
        self.abc = [AppBuilderConstants getAppBuilderConstants];
        self.isHighlighted = NO;
        self.iconType = ICON_CUSTOM;
        self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * ((1.0f - self.abc.iconImagePercent)/2), self.frame.size.height * ((1.0f - self.abc.iconImagePercent)/2), self.frame.size.width * self.abc.iconImagePercent, self.frame.size.height * self.abc.iconImagePercent)];
        self.customImage = [[UIImage alloc] init];
        self.layer.cornerRadius = self.frame.size.width/2;
        self.iconData = nil;
        
        self.customLabel = [[UILabel alloc] init];
        [self.customLabel setTextAlignment:NSTextAlignmentCenter];
        [self.customLabel setBackgroundColor:[UIColor clearColor]];

        self.iconRatio = 0.8f;
        
        self.subtitle = [[UILabel alloc] init];
        [self.subtitle setBackgroundColor:[UIColor clearColor]];
        [self.subtitle setTextColor:[UIColor darkGrayColor]];
        [self.subtitle setFont:[UIFont systemFontOfSize:9]];
        [self.subtitle setNumberOfLines:1];
        [self.subtitle setAdjustsFontSizeToFitWidth:YES];
        
        [self addSubview:self.subtitle];
        
        self.hasSubtitle = NO;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClicked)];
        [self addGestureRecognizer:tapGesture];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMade)];
        [self addGestureRecognizer:longPressGesture];

        [self setBackgroundColor:self.abc.seeThruColor];
        [self addSubview:self.bgImage];
        
    }
    
    return self;
}

-(void)iconClicked{
    NSLog(@"Icon iconClicked");
    [self.myDelegate iconClicked:self];
}

-(void)longPressMade{
    NSLog(@"Icon longPressMade");
    [self.myDelegate iconLongPressed:self];
}

-(void)toggleHighlighted{
    self.isHighlighted = !self.isHighlighted;
    
    if(self.isHighlighted){
        [self setBackgroundColor:self.abc.seeThruColorHighlight];
    } else {
        [self setBackgroundColor:self.abc.seeThruColor];
    }
}

-(void)changeCustomValue:(int)customValue setAsIconType:(BOOL)changeIconType{
    NSLog(@"Icon changeCustonValue: %i", customValue);
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
            [self.bgImage setImage:self.abc.plusImage];
            break;
            
        case ICON_ACTUATOR:
            [self.bgImage setImage:self.abc.actuatorImageDefault];
            break;
            
        case ICON_SENSOR:
            [self.bgImage setImage:self.abc.sensorImageDefault];
            break;
        
        case ICON_GESTURE:
            [self.bgImage setImage:self.abc.lightningImage];
            break;
        
        case ICON_REGION:
            [self.bgImage setImage:self.abc.regionImageDefault];
            break;
        
        case ICON_COMPARATOR:
            [self.bgImage setImage:self.abc.comparatorImage];
            break;
        
        case ICON_GREATERTHEN:
            [self.bgImage setImage:self.abc.greaterThenImage];
            break;
        
        case ICON_LESSTHEN:
            [self.bgImage setImage:self.abc.lessThenImage];
            break;
            
        case ICON_LISTENER:
            [self.bgImage setImage:self.abc.listenerImageDefault];
            break;
        
        case ICON_UPLOAD:
            [self.bgImage setImage:self.abc.uploadImageDefault];
            break;
            
        case ICON_MAP:
            [self.bgImage setImage:self.abc.mapImageDefault];
            break;
            
        case ICON_TILT:
            [self.bgImage setImage:self.abc.tiltImageDefault];
            break;
        
        case ICON_NUMBER:
            [self.bgImage setImage:self.abc.numberImage];
            break;
        
        case ICON_DECREASE_POWER:
            [self.bgImage setImage:self.abc.decreasePowerImage];
            break;
        
        case ICON_INCREASE_POWER:
            [self.bgImage setImage:self.abc.increasePowerImage];
            break;
        
        case ICON_ALL:
            [self.bgImage setImage:self.abc.allImage];
            break;
        
        case ICON_CONFIRM:
            [self.bgImage setImage:self.abc.confirmImage];
            break;
        
        case ICON_LIGHTNING:
            [self.bgImage setImage:self.abc.lightningImage];
            break;
        
        case ICON_ACTION:
            [self.bgImage setImage:self.abc.actionImage];
            break;
        
        case ICON_ANNOUNCER:
            [self.bgImage setImage:self.abc.announcerImage];
            break;
        
        case ICON_BEAKER:
            [self.bgImage setImage:self.abc.beakerImage];
            break;
        
        case ICON_CANCEL:
            [self.bgImage setImage:self.abc.cancelImage];
            break;
        
        case ICON_SAVE:
            [self.bgImage setImage:self.abc.saveImage];
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

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"Icon gestureRecognizerShouldBegin");
    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]){
        NSLog(@"Icon longpress about to begin");
        [self longPressMade];
        return NO;
    } else {
        NSLog(@"Icon other gesture about to begin");
        return YES;
    }
}

-(void)changeSubtitle:(NSString *)text{

    if(text != nil){
        self.subtitleSize = [text sizeWithFont:self.subtitle.font];
        [self.subtitle setText:text];
        [self.subtitle setFrame:CGRectMake((self.frame.size.width/2) - (self.subtitleSize.width/2), (self.frame.size.height), self.subtitleSize.width, self.subtitleSize.height)];
        self.hasSubtitle = YES;
    } else {
        [self.subtitle setText:@""];
        self.hasSubtitle = NO;
    }
}

-(void)fireChangeAnimation{
    NSLog(@"Icon fireChangeAnimation");
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    
    CGFloat xVal = self.frame.origin.x;
    CGFloat yVal = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat scaleFactor = 0.8f;
    
    [UIView animateWithDuration:0.2f animations:^{
        //[self setFrame:CGRectMake(xVal * scaleFactor * scaleFactor, yVal * scaleFactor * scaleFactor, width/scaleFactor, height/scaleFactor)];
        [self setFrame:CGRectMake(xVal, yVal - 10, width, height)];
        //[self.layer setBorderWidth:3.0f];
    
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.2f animations:^{
            [self setFrame:CGRectMake(xVal, yVal, width, height)];
        }];
    }];
    /*
    [self.layer setBorderColor:[UIColor greenColor].CGColor];
    
    [UIView animateWithDuration:0.1f animations:^{
        [self setBackgroundColor:self.abc.primaryColor1];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.1f animations:^{
            [self setBackgroundColor:self.abc.seeThruColor];
        }];
    }];
    */
    /*
    [UIView animateWithDuration:1.0f animations:^{
        [self.layer setBorderColor:[UIColor yellowColor].CGColor];
        [self.layer setBorderWidth:3.0f];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.0f animations:^{
            [self.layer setBorderColor:[UIColor clearColor].CGColor];
            [self.layer setBorderWidth:0];
        }];
    }];
    */
}

@end
