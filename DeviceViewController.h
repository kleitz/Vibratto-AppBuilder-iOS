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

@interface DeviceViewController : UIViewController<IconDelegate>

@property(strong, nonatomic) AppBuilderConstants *abc;

/*
@property(strong, nonatomic) TopBox *topBox;
@property(strong, nonatomic) TopBox *componentsTray;
*/

@property(strong, nonatomic) CompoundTopSection *topSection;

@property(strong, nonatomic) Icon *bigAddIcon;
@property(strong, nonatomic) Icon *uploadIcon;

@property(strong, nonatomic) UIView *editBox;
@property(strong, nonatomic) UIView *mainView;

@property(strong, nonatomic) UIButton *createButton;
@property(strong, nonatomic) UIButton *cancelButton;

@property(assign, nonatomic) CGPoint currentPoint;

@property(assign, nonatomic) BOOL isTouching;

@end
