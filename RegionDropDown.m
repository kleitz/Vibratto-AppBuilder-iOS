//
//  RegionDropDown.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/31/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "RegionDropDown.h"

@implementation RegionDropDown

-(id)initWithFrame:(CGRect)frame{
    NSLog(@"ADD initWithFrame");
    self = [super initWithFrame:frame];
    
    if(self){
        self.hasIcons = NO;
        self.regionIcons = [[NSMutableArray alloc] init];
        self.regionBuilderHeight = self.abc.regionSelectorIconHeight * 3.5;
        
        self.dropDownTypeIcon = ICON_REGION;
        
        for(int i=1; i<=10; i++){
            Icon *actuatorIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.regionSelectorIconHeight, self.abc.regionSelectorIconHeight)];
            //[actuatorIcon changeCustomValue:i setAsIconType:YES];
            
            Actuator *actuatorData = [[Actuator alloc] initWithPinNumber:i andIsCustom:YES];
            [actuatorIcon setIconData:actuatorData];
            
            [self.regionIcons addObject:actuatorIcon];
        }
        
        self.namePlaceholder = @"Name";
        
        [self createTextField:self.namePlaceholder];
        
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, [self getProjectedHeight])];
        
        [self setFieldName:@"Add Region"];
        [self addFields];
        
        if(self.hasIcons){
            [self displayIcons];
        }
        
        [self buildRegionSection];
        
        [self setButtons];
    }
    
    return self;
}

-(void)buildRegionSection{
    CGFloat chooseIconLabelY =
        self.title.frame.size.height +
        (self.textFields.count * (self.abc.dropDownMenuFeildHeight + (self.abc.dropDownFieldBuffer * 2))) +
        self.abc.dropDownGroupBuffer;
    
    //CGFloat regionBoxHeight = self.abc.regionSelectorIconHeight * 3;
    
    //UIView *regionBuilderSection = [[UIView alloc] initWithFrame:CGRectMake(0, chooseIconLabelY, self.frame.size.width, regionBoxHeight)];
    //[regionBuilderSection setBackgroundColor:[UIColor redColor]];
    
    for(int i=0; i<self.regionIcons.count; i++){
        Icon *thisIcon = [self.regionIcons objectAtIndex:i];
        [thisIcon setMyDelegate:self];
        
        int xIndex = (i % (self.regionIcons.count/2));
        int yIndex = ((int)(i / (self.regionIcons.count/2)));
        
        CGFloat xBuffer = (self.frame.size.width - ((self.regionIcons.count/2) * (self.abc.regionSelectorIconHeight * 1.5f)) + (self.abc.regionSelectorIconHeight * 0.5f))/2;
        CGFloat xVal =
            xBuffer +
            ((self.abc.regionSelectorIconHeight * 1.5f) * xIndex);

        CGFloat yVal =
            chooseIconLabelY +
            self.abc.regionSelectorIconHeight * 0.5f +
            ((self.abc.regionSelectorIconHeight * 1.5f) * yIndex);
        
        NSLog(@"RDD xIndex: %i, yIndex: %i, xVal: %f, yVal: %f", xIndex, yIndex, xVal, yVal);
        
        [thisIcon setFrame:CGRectMake(xVal, yVal, thisIcon.frame.size.width, thisIcon.frame.size.height)];
        
        [self addSubview:thisIcon];
    }
    
    //self.regionBuilderHeight = regionBuilderSection.frame.size.height;
    
    //[self addSubview:regionBuilderSection];
}

-(CGFloat)getProjectedHeight{
    CGFloat projectedHeight = [super getProjectedHeight];
    //CGFloat regionBoxHeight = self.abc.regionSelectorIconHeight * 3;
    
    return projectedHeight + self.regionBuilderHeight + self.abc.dropDownGroupBuffer;
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"DDM iconClicked");
    
    [icon toggleHighlighted];
    
    /*
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
    */
}


-(void)setButtons{
    CGFloat originY;

    originY =
        self.titleY +
        (self.textFields.count * (self.abc.dropDownMenuFeildHeight + (self.abc.dropDownFieldBuffer * 2))) +
        self.regionBuilderHeight;

    
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
    
    for(int i=0; i<self.textFields.count; i++){
        UITextField *thisTextField = [self.textFields objectAtIndex:i];
        if([thisTextField.placeholder isEqualToString:self.namePlaceholder]){
            if(![thisTextField.text isEqualToString: @""]){
                self.name = thisTextField.text;
            } else {
                self.name = nil;
            }
        }
    }
    
    [super okButtonClicked];
    
    NSLog(@"RDD name: %@", self.name);
}

@end
