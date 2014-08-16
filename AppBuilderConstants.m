//
//  AppBuilderConstants.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "AppBuilderConstants.h"

@implementation AppBuilderConstants

static AppBuilderConstants *abc;

+(AppBuilderConstants *)getAppBuilderConstants {
    if(!abc){
        abc = [[AppBuilderConstants alloc] init];
        
        abc.plusImage = [UIImage imageNamed:@"plus.png"];
        abc.sensorImageDefault = [UIImage imageNamed:@"binocular.png"];
        abc.actuatorImageDefault = [UIImage imageNamed:@"bulb.png"];
        
        abc.primaryColor1 = [[UIColor alloc] initWithRed:0.671 green:1.0 blue:0.945 alpha:1.0];
        abc.primaryColor2 = [[UIColor alloc] initWithRed:0.671 green:0.725 blue:1.00 alpha:1.0];
        abc.primaryColor3 = [[UIColor alloc] initWithRed:.698 green:1.0 blue:0.671 alpha:1.0];
        abc.seeThruColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:0.4];
        
        abc.primaryButtonDiameter = 60.0f;
        abc.topBoxHeight = 80.0f;
        abc.iconHeight = 60.0f;
        abc.iconImageHeight = 45.0f;
        abc.iconImagePercent = 0.7f;
    }
    
    return abc;
}

@end
