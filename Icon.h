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
#import "TypeData.h"

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
    ICON_ALL,
    ICON_CONFIRM,
    ICON_CUSTOM_VALUE,
    ICON_ANNOUNCER,
    ICON_ACTION,
    ICON_LIGHTNING,
    ICON_BEAKER,
    ICON_CUSTOM
} ICON_TYPE;

@class Icon;

@protocol IconDelegate <NSObject>

@optional
-(void)iconClicked:(Icon *)icon;
-(void)iconLongPressed:(Icon *)icon;
@end

@interface Icon : UIView<IconDelegate>

@property(strong, nonatomic) TypeData *iconData;

@property(strong, nonatomic) UIImageView *bgImage;
@property(strong, nonatomic) UIImage *customImage;

@property(strong, nonatomic) UILabel *customLabel;
@property(strong, nonatomic) UILabel *subtitle;

@property(strong, nonatomic) AppBuilderConstants *constants;
@property(weak, nonatomic) id<IconDelegate> myDelegate;
@property(assign, nonatomic) ICON_TYPE iconType;

@property(assign, nonatomic) CGSize subtitleSize;
@property(assign, nonatomic) CGFloat iconRatio;

@property(assign, nonatomic) int customValue;

@property(assign, nonatomic) BOOL isHighlighted;
@property(assign, nonatomic) BOOL hasSubtitle;

-(void)changeSubtitle:(NSString *)text;

-(void)changeIconType:(ICON_TYPE)iconType;
-(void)toggleHighlighted;
-(void)changeCustomValue:(int)customValue setAsIconType:(BOOL)changeIconType;

@end