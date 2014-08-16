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
        abc.listenerImageDefault = [UIImage imageNamed:@"beaker.png"];
        abc.regionImageDefault = [UIImage imageNamed:@"layout3.png"];
        abc.gestureImageDefault = [UIImage imageNamed:@"reload.png"];
        abc.uploadImageDefault = [UIImage imageNamed:@"box1.png"];
        
        abc.primaryColor1 = [[UIColor alloc] initWithRed:0.671 green:1.0 blue:0.945 alpha:1.0];
        abc.primaryColor2 = [[UIColor alloc] initWithRed:0.671 green:0.725 blue:1.00 alpha:1.0];
        abc.primaryColor3 = [[UIColor alloc] initWithRed:.698 green:1.0 blue:0.671 alpha:1.0];
        abc.primaryColor4 = [[UIColor alloc] initWithRed:1.0 green:0.906f blue:0.671 alpha:1.0f];
        abc.seeThruColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:0.65];
        abc.seeThruColorHighlight = [[UIColor alloc] initWithRed:0.7f green:0.7f blue:0.7f alpha:0.65];
        
        abc.primaryButtonDiameter = 60.0f;
        abc.iconHeight = 50.0f;
        abc.topBoxHeight = abc.iconHeight * 1.2f;
        abc.iconImageHeight = 45.0f;
        abc.iconImagePercent = 0.7f;
        
        abc.topBoxAddIconBoxWidth = 80.0f;
    }
    
    return abc;
}

@end
