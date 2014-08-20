//
//  ActuatorDropDown.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/19/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "DropDownMenu.h"

@interface ActuatorDropDown : DropDownMenu

@property(strong, nonatomic) NSString *namePlaceholder;
@property(strong, nonatomic) NSString *pinNumberPlaceholder;
@property(assign, nonatomic) int pinNumber;

@end
