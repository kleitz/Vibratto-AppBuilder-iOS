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
@property(assign, nonatomic) CGFloat iconHeight;

@property(assign, nonatomic) NSInteger displayCount;

@property(weak, nonatomic) id<IconDelegate> delegate;

@property(assign, nonatomic) BOOL hasAddButton;
@property(assign, nonatomic) BOOL isCentered;

-(void)addIcon:(ICON_TYPE)iconType andIconImage:(UIImage *)iconImage andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag andSubtitle:(NSString *)subtitle andIconData:(TypeData *)iconData;
-(void)addIconWithoutDisplay:(ICON_TYPE)iconType andDelegate:(id<IconDelegate>)delegate andTag:(NSInteger)tag;
-(id)initWithFrame:(CGRect)frame andHasAddBox:(BOOL)hasAddButton;
-(void)changeIsCentered:(BOOL)isCentered;
-(void)changeTrayColor:(UIColor *)color;
-(void)setHighlightedIcon:(NSInteger)index;
-(void)emptyBox;
-(void)fillBox:(NSArray *)newItems andDelegate:(id<IconDelegate>)delegate;
-(void)changeHasAddBox:(BOOL)hasAddBox;
-(void)addIcon:(Icon *)iconToAdd;

-(Icon *)returnItemAtIndex:(NSInteger)index;
-(Icon *)returnItemByType:(ICON_TYPE)iconType;

@end
