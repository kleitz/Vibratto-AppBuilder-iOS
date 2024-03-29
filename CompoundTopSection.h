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

@class CompoundTopSection;

@protocol CompoundTopSectionDelegate <NSObject>

@optional
//-(void)buildListener:(CompoundTopSection *)compoundTopSection;
-(void)collapsingStarted:(DropDownMenu *)newItem;
-(void)addedNewItemFromDropDown:(DropDownMenu *)newItem;
@end

@interface CompoundTopSection : UIView<IconDelegate, DropDownDelegate>

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

@property(assign, nonatomic) int sensorsBaseTag;
@property(assign, nonatomic) int actuatorsBaseTag;
@property(assign, nonatomic) int regionsBaseTag;
@property(assign, nonatomic) int gesturesBaseTag;
@property(assign, nonatomic) int listenersBaseTag;

@property(strong, nonatomic) id<IconDelegate>delegate;
@property(strong, nonatomic) id<CompoundTopSectionDelegate>compoundDelegate;

@property(assign, nonatomic) int visibleCount;

-(void)selectCategoryByType:(ICON_TYPE)iconType;
-(void)addNewIconInCategory:(ICON_TYPE)iconCategory iconType:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag subtitle:(NSString *)text;
-(void)addNewIconInCategory:(ICON_TYPE)iconCategory iconType:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag subtitle:(NSString *)subtitle andData:(TypeData *)iconData;
-(void)showDropDown:(DropDownMenu *)dropDown;
-(void)showDropDownByType:(ICON_TYPE)iconType isEditing:(BOOL)isEditing typeData:(TypeData *)typeData representingIcon:(Icon *)icon;

@end
