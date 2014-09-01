//
//  RegionDropDown.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/31/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "DropDownMenu.h"

@interface RegionDropDown : DropDownMenu

@property(strong, nonatomic) NSString *namePlaceholder;
@property(strong, nonatomic) NSMutableArray *regionIcons;

@property(assign, nonatomic) CGFloat regionBuilderHeight;
@end
