//
//  Icon.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBuilderConstants.h"

typedef enum {
    ICON_ADD,
    ICON_ACTUATOR,
    ICON_SENSOR,
    ICON_CUSTOM
} ICON_TYPE;

@interface Icon : UIView

@property(strong, nonatomic) UIImageView *bgImage;
@property(strong, nonatomic) UIImage *customImage;

@property(strong, nonatomic) AppBuilderConstants *constants;
@property(assign, nonatomic) ICON_TYPE iconType;

-(void)changeIconType:(ICON_TYPE)iconType;

@end
