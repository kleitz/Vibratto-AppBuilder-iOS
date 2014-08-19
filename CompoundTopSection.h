//
//  CompoundTopSection.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/16/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBox.h"
#import "DropDownMenu.h"

@protocol CompoundTopSectionDelegate <NSObject>

@optional
-(void)showDropDown:(DropDownMenu *)dropDown;
@end

@interface CompoundTopSection : UIView<IconDelegate>

@property(strong, nonatomic) AppBuilderConstants *abc;

@property(strong, nonatomic) TopBox *categories;
@property(strong, nonatomic) TopBox *iconBox;

@property(strong, nonatomic) DropDownMenu *visibleDropDown;

@property(strong, nonatomic) Icon *selectedCategory;

@property(strong, nonatomic) NSMutableArray *categoriesArray;

@property(strong, nonatomic) NSMutableArray *listenersArray;
@property(strong, nonatomic) NSMutableArray *actuatorsArray;
@property(strong, nonatomic) NSMutableArray *sensorArray;
@property(strong, nonatomic) NSMutableArray *regionsArray;
@property(strong, nonatomic) NSMutableArray *gesturesArray;
@property(strong, nonatomic) NSMutableArray *comparatorsArray;
@property(strong, nonatomic) NSMutableArray *valueArray;

@property(strong, nonatomic) id<IconDelegate>delegate;
@property(strong, nonatomic) id<CompoundTopSectionDelegate>dropDownDelegate;

@property(assign, nonatomic) int visibleCount;

-(void)selectCategoryByType:(ICON_TYPE)iconType;
//-(void)addNewIconInCategory:(Icon *)icon;
-(void)addNewIconInCategory:(ICON_TYPE)iconCategory iconType:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag;

@end
