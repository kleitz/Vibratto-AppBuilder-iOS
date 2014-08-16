//
//  DeviceViewController.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBuilderConstants.h"

@interface DeviceViewController : UIViewController

@property(strong, nonatomic) AppBuilderConstants *constants;
@property(strong, nonatomic) UIView *topBox;
@property(strong, nonatomic) UIView *editBox;
@property(strong, nonatomic) UIButton *createButton;
@property(strong, nonatomic) UIButton *cancelButton;
@end
