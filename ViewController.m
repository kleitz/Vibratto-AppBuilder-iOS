//
//  ViewController.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "ViewController.h"
#import "AppBuilderConstants.h"

@interface ViewController ()

@end

@implementation ViewController

-(id)init{
    self = [super init];
    if(self){
        self.constants = [AppBuilderConstants getAppBuilderConstants];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:self.constants.primaryColor1];
    //self.newDeviceButton = [UIButton alloc] initWithFrame:[CGRectMake(self.view.frame.size.width/2, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    //self.newDeviceButton = [[UIButton alloc] initWithFrame:[self createCenteredButtonWithDiameter:self.constants.primaryButtonDiameter]];
    self.newDeviceButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - self.constants.primaryButtonDiameter/2, self.view.frame.size.height * 0.7, self.constants.primaryButtonDiameter, self.constants.primaryButtonDiameter)];
    [self.newDeviceButton.layer setCornerRadius:self.constants.primaryButtonDiameter/2];
    [self.newDeviceButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.newDeviceButton.layer setBorderWidth:1.0f];
    [self.newDeviceButton setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3]];
    [self.newDeviceButton addTarget:self action:@selector(newDeviceButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.newDeviceButton];
}

-(void)newDeviceButtonClicked{
    NSLog(@"New device button clicked!");
}

/*
-(CGRect)createCenteredButtonWithDiameter:(CGFloat)diameter{
    return CGRectMake(self.view.frame.size.width/2 - diameter/2, 0, diameter, diameter);
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
