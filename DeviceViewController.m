//
//  DeviceViewController.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "DeviceViewController.h"
#import "AppBuilderConstants.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController

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
    self.topBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.2f)];
    [self.topBox setBackgroundColor:self.constants.primaryColor2];
    
}

@end
