//
//  Icon.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBuilderConstants.h"
#import "AppBuilderProtocols.h"

typedef enum {
    ICON_ADD,
    ICON_ACTUATOR,
    ICON_SENSOR,
    ICON_REGION,
    ICON_GESTURE,
    ICON_LISTENER,
    ICON_COMPARATOR,
    ICON_LESSTHEN,
    ICON_GREATERTHEN,
    ICON_UPLOAD,
    ICON_MAP,
    ICON_TILT,
    ICON_NUMBER,
    ICON_VALUE,
    ICON_INCREASE_POWER,
    ICON_DECREASE_POWER,
    ICON_CUSTOM
} ICON_TYPE;

@class Icon;

@protocol IconDelegate <NSObject>

@optional
-(void)iconClicked:(Icon *)icon;
@end

@interface Icon : UIView<IconDelegate>

@property(strong, nonatomic) UIImageView *bgImage;
@property(strong, nonatomic) UIImage *customImage;

@property(strong, nonatomic) AppBuilderConstants *constants;
@property(weak, nonatomic) id<IconDelegate> myDelegate;
@property(assign, nonatomic) ICON_TYPE iconType;

@property(assign, nonatomic) BOOL isHighlighted;

-(void)changeIconType:(ICON_TYPE)iconType;
-(void)toggleHighlighted;

@end