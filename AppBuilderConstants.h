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
@property(strong, nonatomic) UIImage *listenerImageDefault;
@property(strong, nonatomic) UIImage *gestureImageDefault;
@property(strong, nonatomic) UIImage *uploadImageDefault;
@property(strong, nonatomic) UIImage *mapImageDefault;
@property(strong, nonatomic) UIImage *tiltImageDefault;
@property(strong, nonatomic) UIImage *rightArrowImage;
@property(strong, nonatomic) UIImage *greaterThenImage;
@property(strong, nonatomic) UIImage *lessThenImage;
@property(strong, nonatomic) UIImage *comparatorImage;
@property(strong, nonatomic) UIImage *numberImage;
@property(strong, nonatomic) UIImage *increasePowerImage;
@property(strong, nonatomic) UIImage *decreasePowerImage;
@property(strong, nonatomic) UIImage *allImage;
@property(strong, nonatomic) UIImage *confirmImage;
@property(strong, nonatomic) UIImage *actionImage;
@property(strong, nonatomic) UIImage *lightningImage;
@property(strong, nonatomic) UIImage *headphoneImage;
@property(strong, nonatomic) UIImage *announcerImage;
@property(strong, nonatomic) UIImage *beakerImage;

@property(strong, nonatomic) UIFont *labelFont;
@property(strong, nonatomic) UIFont *dropDownTitleFont;
@property(strong, nonatomic) UIFont *dropDownFieldFont;
@property(strong, nonatomic) UIFont *dropDownChooseIconFont;

@property(strong, nonatomic) UIColor *primaryColor1;
@property(strong, nonatomic) UIColor *primaryColor2;
@property(strong, nonatomic) UIColor *primaryColor3;
@property(strong, nonatomic) UIColor *primaryColor4;
@property(strong, nonatomic) UIColor *seeThruColor;
@property(strong, nonatomic) UIColor *seeThruColorHighlight;

@property(assign, nonatomic) CGFloat primaryButtonDiameter;
@property(assign, nonatomic) CGFloat topBoxHeight;
@property(assign, nonatomic) CGFloat iconHeight;
@property(assign, nonatomic) CGFloat addIconHeight;
@property(assign, nonatomic) CGFloat iconTopBuffer;
@property(assign, nonatomic) CGFloat iconImageHeight;
@property(assign, nonatomic) CGFloat iconImagePercent;
@property(assign, nonatomic) CGFloat topBoxAddIconBoxWidth;
@property(assign, nonatomic) CGFloat builderIconHeight;
@property(assign, nonatomic) CGFloat builderBuffer;
@property(assign, nonatomic) CGFloat confirmListenerButtonHeight;
@property(assign, nonatomic) CGFloat bigAddButtonHeight;
@property(assign, nonatomic) CGFloat dropDownMenuFeildHeight;
@property(assign, nonatomic) CGFloat dropDownMenuTitleHeight;
@property(assign, nonatomic) CGFloat dropDownChooseIconLabelHeight;
@property(assign, nonatomic) CGFloat dropDownFieldBuffer;
@property(assign, nonatomic) CGFloat dropDownGroupBuffer;

@end
