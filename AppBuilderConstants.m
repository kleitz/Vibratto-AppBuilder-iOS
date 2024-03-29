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
        abc.listenerImageDefault = [UIImage imageNamed:@"headphone.png"];
        abc.regionImageDefault = [UIImage imageNamed:@"layout3.png"];
        abc.gestureImageDefault = [UIImage imageNamed:@"reload.png"];
        abc.uploadImageDefault = [UIImage imageNamed:@"box1.png"];
        abc.tiltImageDefault = [UIImage imageNamed:@"refresh.png"];
        abc.mapImageDefault = [UIImage imageNamed:@"map_pin.png"];
        abc.rightArrowImage = [UIImage imageNamed:@"arrow.png"];
        abc.comparatorImage = [UIImage imageNamed:@"arrow17.png"];
        abc.greaterThenImage = [UIImage imageNamed:@"arrow17.png"];
        abc.lessThenImage = [UIImage imageNamed:@"arrow18.png"];
        abc.numberImage = [UIImage imageNamed:@"calcuator.png"];
        abc.increasePowerImage = [UIImage imageNamed:@"arrow4.png"];
        abc.decreasePowerImage = [UIImage imageNamed:@"arrow2.png"];
        abc.allImage = [UIImage imageNamed:@"earth.png"];
        abc.confirmImage = [UIImage imageNamed:@"right.png"];
        abc.actionImage = [UIImage imageNamed:@"clapper.png"];
        abc.lightningImage = [UIImage imageNamed:@"flash.png"];
        abc.headphoneImage = [UIImage imageNamed:@"headphone.png"];
        abc.announcerImage = [UIImage imageNamed:@"announcer.png"];
        abc.beakerImage = [UIImage imageNamed:@"beaker.png"];
        abc.cancelImage = [UIImage imageNamed:@"multiply.png"];
        abc.saveImage = [UIImage imageNamed:@"box2.png"];
        
        abc.labelFont = [UIFont systemFontOfSize:42];
        abc.dropDownTitleFont = [UIFont systemFontOfSize:25];
        abc.dropDownFieldFont = [UIFont systemFontOfSize:20];
        abc.dropDownChooseIconFont = [UIFont systemFontOfSize:22];
        abc.builderIconSubtitleFont = [UIFont systemFontOfSize:14];
        
        //abfff1
        abc.primaryColor1 = [[UIColor alloc] initWithRed:0.671 green:1.0 blue:0.945 alpha:1.0];
        //abb9ff
        abc.primaryColor2 = [[UIColor alloc] initWithRed:0.671 green:0.725 blue:1.00 alpha:1.0];
        //b2ffab
        abc.primaryColor3 = [[UIColor alloc] initWithRed:.698 green:1.0 blue:0.671 alpha:1.0];
        //ffe7ab
        abc.primaryColor4 = [[UIColor alloc] initWithRed:1.0 green:0.906f blue:0.671 alpha:1.0f];
        abc.seeThruColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:0.65];
        abc.seeThruColorHighlight = [[UIColor alloc] initWithRed:0.7f green:0.7f blue:0.7f alpha:0.65];
        abc.dropDownBgColor = [[UIColor alloc] initWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f];
        //abc.dropDownBgColor = abc.seeThruColor;
        
        abc.primaryButtonDiameter = 50.0f;
        abc.primaryAddButtonDiameter = 60.0f;
        abc.primaryScreenBuffer = 20.0f;
        
        abc.iconHeight = 46.0f;
        abc.addIconHeight = 50.0f;
        abc.iconTopBuffer = 4.0f;
        abc.topBoxHeight = abc.iconHeight * 1.38f;
        abc.iconImageHeight = 45.0f;
        abc.iconImagePercent = 0.7f;
        abc.builderIconHeight = 60.0f;
        abc.builderBuffer = 15.0f;
        abc.confirmListenerButtonHeight = 80.0f;
        abc.bigAddButtonHeight = 120.0f;
        
        abc.topBoxAddIconBoxWidth = 80.0f;
        
        abc.dropDownMenuFeildHeight = 44.0f;
        abc.dropDownMenuTitleHeight = 50.0f;
        abc.dropDownChooseIconLabelHeight = 35.0f;
        abc.dropDownGroupBuffer = 6.0f;
        abc.dropDownFieldBuffer = 1.0f;
        abc.dropDownOkButtonHeight = 60.0f;
        
        abc.regionSelectorIconHeight = 30.0f;
    }
    
    return abc;
}

@end
