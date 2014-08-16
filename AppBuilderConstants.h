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

@property(strong, nonatomic) UIColor *primaryColor1;
@property(strong, nonatomic) UIColor *primaryColor2;
@property(strong, nonatomic) UIColor *primaryColor3;

@property(assign, nonatomic) CGFloat primaryButtonDiameter;

@end
