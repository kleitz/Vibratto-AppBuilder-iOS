//
//  ViewController.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "ViewController.h"
#import "AppBuilderConstants.h"
#import "DeviceViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(id)init{
    NSLog(@"ViewController init");
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
    //[self.view setBackgroundColor:[UIColor blueColor]];
    
    //self.newDeviceButton = [UIButton alloc] initWithFrame:[CGRectMake(self.view.frame.size.width/2, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    //self.newDeviceButton = [[UIButton alloc] initWithFrame:[self createCenteredButtonWithDiameter:self.constants.primaryButtonDiameter]];
    
    self.addDeviceButton = [[Icon alloc] initWithFrame:CGRectMake(self.view.center.x - self.constants.primaryButtonDiameter/2, self.view.frame.size.height * 0.8f, self.constants.primaryButtonDiameter, self.constants.primaryButtonDiameter)];
    [self.addDeviceButton changeIconType:ICON_ADD];
    [self.addDeviceButton.layer setBorderWidth:1.0f];
    [self.addDeviceButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.addDeviceButton setMyDelegate:self];
    
    /*
    self.addDeviceButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - self.constants.primaryButtonDiameter/2, self.view.frame.size.height * 0.8, self.constants.primaryButtonDiameter, self.constants.primaryButtonDiameter)];
    [self.addDeviceButton.layer setCornerRadius:self.constants.primaryButtonDiameter/2];
    [self.addDeviceButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.addDeviceButton.layer setBorderWidth:1.0f];
    [self.addDeviceButton setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3]];
    [self.addDeviceButton addTarget:self action:@selector(newDeviceButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    */
    
    [self.view addSubview:self.addDeviceButton];
    
    NSLog(@"Done setting up!");
}

-(void)newDeviceButtonClicked{
    NSLog(@"New device button clicked!");
    DeviceViewController *dvc = [[DeviceViewController alloc] init];
    
    [self presentViewController:dvc animated:YES completion:nil];
}

-(void)iconClicked:(Icon *)icon{
    [self newDeviceButtonClicked];
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
