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
    NSLog(@"DeviceViewController init");
    self = [super init];
    if(self){
        self.constants = [AppBuilderConstants getAppBuilderConstants];
    }
    
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"DeviceViewController viewDidLoad");
    [super viewDidLoad];
    [self.view setBackgroundColor:self.constants.primaryColor1];
    self.topBox = [[TopBox alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.constants.iconHeight * 1.2)];
    
    [self.view addSubview:self.topBox];
}

/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.isTouching = YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.isTouching = NO;
}
*/

@end
