//
//  DropDownMenu.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/19/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBox.h"
#import "AppBuilderConstants.h"
#import "Icon.h"

@interface DropDownMenu : UIView<IconDelegate, UITextFieldDelegate>

@property(strong, nonatomic) AppBuilderConstants *abc;
@property(strong, nonatomic) UILabel *title;
@property(strong, nonatomic) UILabel *chooseIconLabel;
@property(strong, nonatomic) NSMutableArray *textFields;
@property(strong, nonatomic) NSMutableArray *iconTypes;
@property(strong, nonatomic) TopBox *iconBox;

@property(assign, nonatomic) CGFloat titleY;
@property(assign, nonatomic) CGFloat iconBoxHeight;

@property(assign, nonatomic) BOOL hasIcons;

-(void)setFieldName:(NSString *)name;
-(void)createTextField:(NSString *)text;
-(void)addFields;
-(void)displayIcons;

@end
