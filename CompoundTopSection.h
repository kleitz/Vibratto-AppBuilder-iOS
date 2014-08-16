//
//  CompoundTopSection.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/16/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBox.h"

@interface CompoundTopSection : UIView<IconDelegate>

@property(strong, nonatomic) AppBuilderConstants *abc;

@property(strong, nonatomic) TopBox *categories;
@property(strong, nonatomic) TopBox *iconBox;

@property(strong, nonatomic) Icon *selectedCategory;

@property(strong, nonatomic) NSMutableArray *categoriesArray;

@property(strong, nonatomic) NSMutableArray *listenersArray;
@property(strong, nonatomic) NSMutableArray *actuatorsArray;
@property(strong, nonatomic) NSMutableArray *sensorArray;
@property(strong, nonatomic) NSMutableArray *regionsArray;
@property(strong, nonatomic) NSMutableArray *gesturesArray;

-(void)selectCategoryByType:(ICON_TYPE)iconType;

@end
