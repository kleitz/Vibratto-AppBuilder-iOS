//
//  SensorDropDown.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/19/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "DropDownMenu.h"

@interface SensorDropDown : DropDownMenu

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *namePlaceholder;
@property(strong, nonatomic) NSString *pinNumberPlaceholder;
@property(strong, nonatomic) NSString *sensitivityPlaceholder;

@property(assign, nonatomic) int sensitivity;
@property(assign, nonatomic) int pinNumber;

@end
