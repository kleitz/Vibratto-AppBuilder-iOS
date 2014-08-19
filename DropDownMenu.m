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
        [self setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
        self.textFields = [[NSMutableArray alloc] init];
        self.iconTypes = [[NSMutableArray alloc] init];
        self.selectedIcon = nil;
        
        self.iconBoxHeight = self.abc.dropDownChooseIconLabelHeight + self.abc.topBoxHeight;
        self.titleY = self.abc.dropDownMenuTitleHeight + self.abc.dropDownGroupBuffer + self.abc.dropDownGroupBuffer;
        
    }
    
    return self;
}

-(void)createTextField:(NSString *)text{

    //[textField setText:text];
    [self createTextField:text keyboardType:UIKeyboardTypeDefault];
}

-(void)createTextField:(NSString *)text keyboardType:(UIKeyboardType)keyboardType{
    UITextField *textField = [[UITextField alloc] init];
    
    [textField setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
    [textField setTextColor:[UIColor darkGrayColor]];
    [textField setPlaceholder:text];
    [textField setFont:self.abc.dropDownFieldFont];
    [textField setTextAlignment:NSTextAlignmentCenter];
    [textField setDelegate:self];
    [textField setKeyboardType:keyboardType];
    
    [self.textFields addObject:textField];
}

-(void)addFields{
    for(int i=0; i<self.textFields.count; i++){
        UITextField *thisTextField = [self.textFields objectAtIndex:i];
        [thisTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        CGFloat fieldY = self.title.frame.size.height + self.abc.dropDownGroupBuffer + self.abc.dropDownGroupBuffer + (i * (self.abc.dropDownMenuFeildHeight + (self.abc.dropDownFieldBuffer * 2)));
        
        NSLog(@"DDM fieldY: %f", fieldY);
        
        [thisTextField setFrame:CGRectMake(0, fieldY, self.frame.size.width, self.abc.dropDownMenuFeildHeight)];
        [self addSubview:thisTextField];
    }
}

-(void)displayIcons{
    CGFloat chooseIconLabelY = self.title.frame.size.height + self.abc.dropDownGroupBuffer + self.abc.dropDownFieldBuffer + (self.textFields.count * (self.abc.dropDownMenuFeildHeight + (self.abc.dropDownFieldBuffer * 2))) + self.abc.dropDownGroupBuffer;
    NSString *textString = @"Choose Icon: ";
    CGSize iconLabelSize = [textString sizeWithFont:self.abc.dropDownChooseIconFont];
    self.chooseIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.abc.dropDownGroupBuffer, chooseIconLabelY, iconLabelSize.width, self.abc.dropDownChooseIconLabelHeight)];
    [self.chooseIconLabel setFont:self.abc.dropDownChooseIconFont];
    [self.chooseIconLabel setBackgroundColor:[UIColor clearColor]];
    [self.chooseIconLabel setTextColor:[UIColor darkGrayColor]];
    [self.chooseIconLabel setText:textString];
    
    //[self addSubview:self.chooseIconLabel];
    
    NSLog(@"DDM displayIcons: %f", self.chooseIconLabel.frame.origin.x + self.chooseIconLabel.frame.size.width);

    self.iconBox = [[TopBox alloc] initWithFrame:CGRectMake(0, chooseIconLabelY, self.frame.size.width, self.abc.topBoxHeight) andHasAddBox:NO];

//    self.iconBox = [[TopBox alloc] initWithFrame:CGRectMake(self.chooseIconLabel.frame.origin.x + self.chooseIconLabel.frame.size.width, chooseIconLabelY, self.frame.size.width - (self.chooseIconLabel.frame.origin.x + self.chooseIconLabel.frame.size.width), self.abc.topBoxHeight - 10.0f) andHasAddBox:NO];
    //[self.iconBox setBackgroundColor:[UIColor clearColor]];
    //[self.iconBox setIconHeight:self.abc.iconHeight - 5.0f];
    //[self.iconBox changeTrayColor:[UIColor clearColor]];
    
    /*
    for(int i=0; i<self.iconTypes.count; i++){
        ICON_TYPE thisIconType = ((NSNumber *)[self.iconTypes objectAtIndex:i]).intValue;
        [self.iconBox addIcon:thisIconType andIconImage:nil andDelegate:self andTag:0];
    }
    */
    [self.iconBox addIcon:ICON_CUSTOM andIconImage:nil andDelegate:self andTag:0];
    [self.iconBox addIcon:ICON_ACTUATOR andIconImage:nil andDelegate:self andTag:0];
    [self.iconBox addIcon:ICON_ALL andIconImage:nil andDelegate:self andTag:0];
    [self.iconBox addIcon:ICON_MAP andIconImage:nil andDelegate:self andTag:0];
    [self.iconBox changeIsCentered:YES];
    [self.iconBox changeTrayColor:[UIColor clearColor]];
    //[self.iconBox changeTrayColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
    
    [self addSubview:self.iconBox];
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"DDM iconClicked");

    [icon toggleHighlighted];
    
    if(self.selectedIcon != nil){
        [self.selectedIcon toggleHighlighted];
    }
    
    if(self.selectedIcon == icon){
        NSLog(@"DDM icon is equal");
        [self.selectedIcon toggleHighlighted];
        self.selectedIcon = nil;
    } else {
        self.selectedIcon = icon;
    }
}


-(void)setButtons{
    CGFloat originY;
    if(self.hasIcons){
        originY = self.iconBox.frame.origin.y + self.iconBox.frame.size.height + self.abc.dropDownGroupBuffer;
    } else {
        originY = self.titleY + self.textFields.count * (self.abc.dropDownMenuFeildHeight);
    }
    
    self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(0, originY, (self.frame.size.width/2) - 1, self.abc.dropDownMenuFeildHeight * 1.2f)];
    [self.okButton setBackgroundColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.0f]];
    [self.okButton setTitle:@"OK" forState:UIControlStateNormal];
    [self.okButton addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.okButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [self addSubview:self.okButton];
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width/2) + 1, originY, (self.frame.size.width/2) -1, self.abc.dropDownMenuFeildHeight * 1.2f)];
    [self.cancelButton setBackgroundColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.0f]];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //self.okButton = [[Icon alloc] initWithFrame:CGRectMake(50.0f, originY, self.abc.iconHeight, self.abc.iconHeight)];
    //[self.okButton changeIconType:ICON_CONFIRM];
    [self addSubview:self.cancelButton];
    [self addSubview:self.okButton];
}

-(void)okButtonClicked{
    NSLog(@"DDM okButtonClicked");
    [self.delegate dropDownOkClicked:self];
}

-(void)cancelClicked{
    NSLog(@"DDM cancelClicked");
    [self.delegate dropDowncancelClicked:self];
}

-(void)setFieldName:(NSString *)name{

    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.abc.dropDownGroupBuffer, self.frame.size.width, self.abc.dropDownMenuTitleHeight)];
    [self.title setFont:self.abc.dropDownTitleFont];
    [self.title setTextColor:[UIColor whiteColor]];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    [self.title setBackgroundColor:[UIColor clearColor]];
    [self.title setText:name];
    
    [self addSubview:self.title];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"DDM textFieldShould return");
    [textField resignFirstResponder];
    return YES;
}
@end
