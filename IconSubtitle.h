//
//  IconSubtitle.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/18/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Icon.h"

@interface IconSubtitle : UIView

@property(strong, nonatomic) Icon *icon;

@property(strong, nonatomic) UILabel *subtitle;

@property(assign, nonatomic) CGFloat iconRatio;

@property(assign, nonatomic) CGSize subtitleSize;

@end
