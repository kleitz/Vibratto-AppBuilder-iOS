//
//  TopBox.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Icon.h"
#import "AppBuilderConstants.h"

@interface TopBox : UIView<IconDelegate>

@property(strong, nonatomic) AppBuilderConstants *abc;
@property(strong, nonatomic) UIScrollView *scrollBar;
@property(strong, nonatomic) UIView *addIconBox;

@property(strong, nonatomic) Icon *addIcon;
@property(strong, nonatomic) Icon *selectedIcon;

@property(strong, nonatomic) NSMutableArray *boxItems;

@property(assign, nonatomic) CGFloat iconBuffer;

@property(assign, nonatomic) BOOL hasAddButton;

-(void)addIcon:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage;
-(id)initWithFrame:(CGRect)frame andHasAddBox:(BOOL)hasAddButton;

@end
