//
//  TopBox.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Icon.h"

@interface TopBox : UIView

@property(strong, nonatomic) NSMutableArray *boxItems;
@property(strong, nonatomic) UIScrollView *scrollBar;
@property(strong, nonatomic) Icon *addIcon;

@end
