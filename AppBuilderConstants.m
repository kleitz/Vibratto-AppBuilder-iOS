//
//  AppBuilderConstants.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "AppBuilderConstants.h"

@implementation AppBuilderConstants

static AppBuilderConstants *appBuilderConstants;

+(AppBuilderConstants *)getAppBuilderConstants {
    if(!appBuilderConstants){
        appBuilderConstants = [[AppBuilderConstants alloc] init];
        
        appBuilderConstants.primaryColor1 = [[UIColor alloc] initWithRed:0.671 green:1.0 blue:0.945 alpha:1.0];
        appBuilderConstants.primaryColor2 = [[UIColor alloc] initWithRed:0.671 green:0.725 blue:1.00 alpha:1.0];
        appBuilderConstants.primaryColor3 = [[UIColor alloc] initWithRed:.698 green:1.0 blue:0.671 alpha:1.0];
        
        appBuilderConstants.primaryButtonDiameter = 30.0f;
    }
    
    return appBuilderConstants;
}

@end
