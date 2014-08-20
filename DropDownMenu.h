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

@class DropDownMenu;

@protocol DropDownDelegate <NSObject>

@optional
-(void)dropDowncancelClicked:(DropDownMenu *)ddm;
-(void)dropDownOkClicked:(DropDownMenu *)ddm;
-(void)finishedCollapsingDropDown:(DropDownMenu *)ddm;
@end


@interface DropDownMenu : UIView<IconDelegate, UITextFieldDelegate>

@property(strong, nonatomic) AppBuilderConstants *abc;
@property(strong, nonatomic) UILabel *title;
@property(strong, nonatomic) UILabel *chooseIconLabel;
@property(strong, nonatomic) NSMutableArray *textFields;
@property(strong, nonatomic) NSMutableArray *iconTypes;
@property(strong, nonatomic) TopBox *iconBox;

@property(strong, nonatomic) id<DropDownDelegate> delegate;
@property(strong, nonatomic) Icon *selectedIcon;

@property(strong, nonatomic) UIButton *okButton;
@property(strong, nonatomic) UIButton *cancelButton;

@property(assign, nonatomic) CGFloat titleY;
@property(assign, nonatomic) CGFloat iconBoxHeight;

@property(assign, nonatomic) BOOL hasIcons;

-(void)setFieldName:(NSString *)name;
-(void)createTextField:(NSString *)text;
-(void)createTextField:(NSString *)text keyboardType:(UIKeyboardType)keyboardType;
-(void)addFields;
-(void)displayIcons;
-(void)setButtons;
-(void)colapseDropDown;

-(CGFloat)getProjectedHeight;

@end
