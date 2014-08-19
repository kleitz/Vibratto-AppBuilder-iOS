//
//  DropDownMenu.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/19/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "DropDownMenu.h"
#import "AppBuilderConstants.h"

@implementation DropDownMenu

-(id)initWithFrame:(CGRect)frame{
    NSLog(@"DDM init");   
    self = [super initWithFrame:frame];

    if(self){
        self.abc = [AppBuilderConstants getAppBuilderConstants];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.textFields = [[NSMutableArray alloc] init];
        self.iconTypes = [[NSMutableArray alloc] init];
        
        self.iconBoxHeight = self.abc.dropDownChooseIconLabelHeight + self.abc.topBoxHeight;
        self.titleY = self.abc.dropDownMenuTitleHeight;
    }
    
    return self;
}

-(void)createTextField:(NSString *)text{
    UITextField *textField = [[UITextField alloc] init];
    //[textField setText:text];
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setTextColor:[UIColor darkGrayColor]];
    [textField setPlaceholder:text];
    [textField setFont:self.abc.dropDownTitleFont];
    [textField setTextAlignment:NSTextAlignmentCenter];
    
    [self.textFields addObject:textField];
}

-(void)addFields{
    for(int i=0; i<self.textFields.count; i++){
        UITextField *thisTextField = [self.textFields objectAtIndex:i];
        CGFloat fieldY = self.title.frame.size.height + (i * self.abc.dropDownMenuFeildHeight);
        
        NSLog(@"DDM fieldY: %f", fieldY);
        
        [thisTextField setFrame:CGRectMake(0, fieldY, self.frame.size.width, self.abc.dropDownMenuFeildHeight)];
        [self addSubview:thisTextField];
    }
}

-(void)displayIcons{
    CGFloat chooseIconLabelY = self.title.frame.size.height + (self.textFields.count * self.abc.dropDownMenuFeildHeight);
    self.chooseIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, chooseIconLabelY, self.frame.size.width, self.abc.dropDownChooseIconLabelHeight)];
    [self.chooseIconLabel setFont:self.abc.dropDownChooseIconFont];
    [self.chooseIconLabel setBackgroundColor:[UIColor clearColor]];
    [self.chooseIconLabel setTextColor:[UIColor darkGrayColor]];
    [self.chooseIconLabel setText:@"Choose Icon:"];
    
    [self addSubview:self.chooseIconLabel];
    
    self.iconBox = [[TopBox alloc] initWithFrame:CGRectMake(0, chooseIconLabelY + self.chooseIconLabel.frame.size.height, self.frame.size.width, self.abc.topBoxHeight) andHasAddBox:NO];
    
    for(int i=0; i<self.iconTypes.count; i++){
        ICON_TYPE thisIconType = ((NSNumber *)[self.iconTypes objectAtIndex:i]).intValue;
        [self.iconBox addIcon:thisIconType andIconImage:nil andDelegate:self andTag:0];
    }
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"DDM iconClicked");
}

-(void)setFieldName:(NSString *)name{

    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.abc.dropDownMenuTitleHeight)];
    [self.title setFont:self.abc.dropDownTitleFont];
    [self.title setTextColor:[UIColor darkGrayColor]];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    
    [self.title setText:name];
    
    [self addSubview:self.title];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"DDM textFieldShould return");
    [textField resignFirstResponder];
    return YES;
}
@end
