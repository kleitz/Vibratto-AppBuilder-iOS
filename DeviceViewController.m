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
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.mainView setBackgroundColor:self.constants.primaryColor1];
    [self.view addSubview:self.mainView];
    
    self.topBox = [[TopBox alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.constants.iconHeight * 1.2) andHasAddBox:YES];
    
    for(int i=0; i<7; i++){
        [self.topBox addIcon:ICON_SENSOR andIconImage:nil];
    }
    
    self.componentsTray = [[TopBox alloc] initWithFrame:CGRectMake(0, self.constants.iconHeight * -1.2, self.view.frame.size.width, self.constants.iconHeight * 1.2) andHasAddBox:NO];
    NSLog(@"About to setbgcolor");
    
    [self.componentsTray changeTrayColor:self.constants.primaryColor3];
    
    for(int i=0; i<4; i++){
        [self.componentsTray addIcon:ICON_ACTUATOR andIconImage:nil];
    }
    
    [self.componentsTray changeIsCentered:YES];
    
    [self.mainView addSubview:self.topBox];
    [self.mainView addSubview:self.componentsTray];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"DVC touchesBegan");
    self.isTouching = YES;
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    self.currentPoint = touchPoint;

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"DVC touchesMoved");
    UITouch *newTouch = [touches anyObject];
    CGPoint newPoint = [newTouch locationInView:self.view];
    CGPoint translation = CGPointMake(newPoint.x - self.currentPoint.x, newPoint.y - self.currentPoint.y);
    
    NSLog(@"CEV touchesMoved: %f", translation.y);
    if(self.mainView.frame.origin.y + translation.y <= 0){
    } else if(self.mainView.frame.origin.y + translation.y < self.constants.topBoxHeight - 20.f) {
        [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y + translation.y, self.mainView.frame.size.width, self.mainView.frame.size.height)];
    } else {
    }

    self.currentPoint = newPoint;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"DVC touchesEnded");
    self.isTouching = NO;
    
    if(self.mainView.frame.origin.y < (self.constants.topBoxHeight - 20.f)/2){
        [UIView animateWithDuration:0.2f animations:^{
            [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, 0, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, self.constants.topBoxHeight - 20.f, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        }];
    }
}

@end
