//
//  AppBuilderConstants.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppBuilderConstants : NSObject

+(AppBuilderConstants *)getAppBuilderConstants;

@property(strong, nonatomic) UIImage *plusImage;
@property(strong, nonatomic) UIImage *actuatorImageDefault;
@property(strong, nonatomic) UIImage *sensorImageDefault;
@property(strong, nonatomic) UIImage *regionImageDefault;

@property(strong, nonatomic) UIColor *primaryColor1;
@property(strong, nonatomic) UIColor *primaryColor2;
@property(strong, nonatomic) UIColor *primaryColor3;
@property(strong, nonatomic) UIColor *seeThruColor;
@property(strong, nonatomic) UIColor *seeThruColorHighlight;

@property(assign, nonatomic) CGFloat primaryButtonDiameter;
@property(assign, nonatomic) CGFloat topBoxHeight;
@property(assign, nonatomic) CGFloat iconHeight;
@property(assign, nonatomic) CGFloat iconImageHeight;
@property(assign, nonatomic) CGFloat iconImagePercent;
@property(assign, nonatomic) CGFloat topBoxAddIconBoxWidth;

@end
