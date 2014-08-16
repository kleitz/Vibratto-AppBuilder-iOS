//
//  DeviceViewController.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "DeviceViewController.h"
#import "AppBuilderConstants.h"
#import "CompoundTopSection.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController

-(id)init{
    NSLog(@"DeviceViewController init");
    self = [super init];
    if(self){
        self.abc = [AppBuilderConstants getAppBuilderConstants];
    }
    
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"DeviceViewController viewDidLoad");
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.abc.topBoxHeight * -1, self.view.frame.size.width, self.view.frame.size.height + self.abc.topBoxHeight)];
    [self.mainView setBackgroundColor:self.abc.primaryColor4];
    [self.view addSubview:self.mainView];
    
    self.topSection = [[CompoundTopSection alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2 * self.abc.topBoxHeight)];
    
    self.uploadIcon = [[Icon alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - self.abc.primaryButtonDiameter/2, self.view.frame.size.height - 80.0f + self.abc.topBoxHeight, self.abc.primaryButtonDiameter, self.abc.primaryButtonDiameter)];
    [self.uploadIcon changeIconType:ICON_UPLOAD];
    
    CGFloat addButtonWidth = 120.0f;
    self.bigAddIcon = [[Icon alloc] initWithFrame:CGRectMake(self.view.center.x - addButtonWidth/2, self.view.center.y + self.abc.topBoxHeight - addButtonWidth/2, addButtonWidth, addButtonWidth)];
    [self.bigAddIcon changeIconType:ICON_ADD];
    [self.bigAddIcon setTag:11];
    [self.bigAddIcon setMyDelegate:self];
    
    [self.mainView addSubview:self.topSection];
    [self.mainView addSubview:self.bigAddIcon];
    [self.mainView addSubview:self.uploadIcon];
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"DVC iconClicked");
    if(icon.tag == 11){
        NSLog(@"DVC big add button");
        
        [UIView animateWithDuration:0.5f animations:^{
            [self.bigAddIcon setFrame:CGRectMake(40.0f, 90.0f + self.abc.topBoxHeight, 60.0f, 60.0f)];
            [self.bigAddIcon.layer setCornerRadius:30.0f];
            [self.bigAddIcon changeIconType:ICON_CUSTOM];
        } completion:^(BOOL finished){
            [self.topSection selectCategoryByType:ICON_SENSOR];
        }];
    }
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
    if(self.mainView.frame.origin.y + translation.y <= -1 * self.abc.topBoxHeight){
        CGFloat viewRatio = (float)(self.mainView.frame.size.height + translation.y)/self.mainView.frame.size.height;
        CGFloat invertRatio = 1.0 - viewRatio;
        //[self.mainView setFrame:CGRectMake(invertRatio * self.mainView.frame.size.width, invertRatio * self.mainView.frame.size.height, self.mainView.frame.size.width * viewRatio, self.mainView.frame.size.height * viewRatio)];
        
    } else if(self.mainView.frame.origin.y + translation.y < 0) {
        [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y + translation.y, self.mainView.frame.size.width, self.mainView.frame.size.height)];
    }

    self.currentPoint = newPoint;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"DVC touchesEnded");
    self.isTouching = NO;
    
    if(self.mainView.frame.origin.y < -1 * (self.abc.topBoxHeight)/2){
        [UIView animateWithDuration:0.2f animations:^{
            [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, self.abc.topBoxHeight * -1, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            [self.mainView setFrame:CGRectMake(self.mainView.frame.origin.x, 0, self.mainView.frame.size.width, self.mainView.frame.size.height)];
        }];
    }
}

@end
