//
//  DeviceViewController.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBuilderConstants.h"
#import "CompoundTopSection.h"
#import "ListenerDropDown.h"

typedef enum {
    PRE_SELECT,
    SENSOR_SELECT,
    COMPARATOR_SELECT,
    VALUE_SELECT,
    ACTION_SELECT,
    REGION_SELECT,
    CONFIRM_LISTENER,
    NAME_LISTENER,
    BUILD_LISTENER
} BUILD_LISTENER_STATUS;

@class DeviceViewController;

@protocol DeviceBuilderDelegate <NSObject>

@optional
-(void)sketchFinishedBuilding:(DeviceViewController *)sketch;
-(void)sketchCanceled:(DeviceViewController *)sketch;
@end

@interface DeviceViewController : UIView<IconDelegate, UIAlertViewDelegate, DropDownDelegate, CompoundTopSectionDelegate>

@property(strong, nonatomic) AppBuilderConstants *abc;

@property(strong, nonatomic) CompoundTopSection *topSection;

@property(strong, nonatomic) TopBox *bottomSection;

@property(strong, nonatomic) Icon *bigAddIcon;
@property(strong, nonatomic) Icon *uploadIcon;
@property(strong, nonatomic) Icon *confirmListenerIcon;
@property(strong, nonatomic) Icon *createdListenerIcon;

@property(strong, nonatomic) Icon *sensorIcon;
@property(strong, nonatomic) Icon *comparatorIcon;
@property(strong, nonatomic) Icon *valueIcon;
@property(strong, nonatomic) Icon *regionIcon;
@property(strong, nonatomic) Icon *gestureIcon;

@property(strong, nonatomic) Icon *buildStageIcon;

@property(strong, nonatomic) ListenerDropDown *ldd;

@property(weak, nonatomic) id<DeviceBuilderDelegate> delegate;

@property(strong, nonatomic) NSMutableArray *actuators;
@property(strong, nonatomic) NSMutableArray *sensors;
@property(strong, nonatomic) NSMutableArray *regions;
@property(strong, nonatomic) NSMutableArray *gestures;
@property(strong, nonatomic) NSMutableArray *listeners;

@property(strong, nonatomic) UILabel *ifLabel;
@property(strong, nonatomic) UILabel *isLabel;
@property(strong, nonatomic) UILabel *applyLabel;
@property(strong, nonatomic) UILabel *ontoLabel;

@property(strong, nonatomic) UIImageView *arrow1;

@property(strong, nonatomic) UIView *editBox;
@property(strong, nonatomic) UIView *mainView;

@property(strong, nonatomic) UIButton *createButton;
@property(strong, nonatomic) UIButton *cancelButton;

@property(assign, nonatomic) CGPoint currentPoint;

@property(assign, nonatomic) CGSize ifSize;
@property(assign, nonatomic) CGSize isSize;
@property(assign, nonatomic) CGSize applySize;
@property(assign, nonatomic) CGSize ontoSize;

@property(assign, nonatomic) BUILD_LISTENER_STATUS buildStage;
@property(assign, nonatomic) BUILD_LISTENER_STATUS frontierStage;
@property(assign, nonatomic) BUILD_LISTENER_STATUS nextStage;

@property(assign, nonatomic) BOOL isTouching;

@end
