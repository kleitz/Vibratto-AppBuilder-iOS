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
        self.buildStage = PRE_SELECT;
        
        self.ifLabel = [[UILabel alloc] init];
        self.isLabel = [[UILabel alloc] init];
        self.applyLabel = [[UILabel alloc] init];
        self.ontoLabel = [[UILabel alloc] init];
        
        self.sensorIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        self.comparatorIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        self.valueIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        self.gestureIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        self.regionIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        
        self.confirmListenerIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.confirmListenerButtonHeight, self.abc.confirmListenerButtonHeight)];
        [self.confirmListenerIcon changeIconType:ICON_CONFIRM];
        [self.confirmListenerIcon setMyDelegate:self];
        [self.confirmListenerIcon setTag:2];
        
        [self initLabel:self.ifLabel text:@"If" andSize:self.ifSize];
        [self.ifLabel setText:@"If"];

        [self initLabel:self.isLabel text:@"is" andSize:self.isSize];
        [self.isLabel setText:@"is"];
        
        [self initLabel:self.applyLabel text:@"then" andSize:self.applySize];
        [self.applyLabel setText:@"then"];
        
        [self initLabel:self.ontoLabel text:@"on" andSize:self.ontoSize];
        [self.ontoLabel setText:@"on"];
        
        self.ifSize = [@"If" sizeWithFont:self.abc.labelFont];
        self.isSize = [@"is" sizeWithFont:self.abc.labelFont];
        self.applySize = [@"then" sizeWithFont:self.abc.labelFont];
        self.ontoSize = [@"on" sizeWithFont:self.abc.labelFont];
        
        self.arrow1 = [[UIImageView alloc] initWithImage:self.abc.rightArrowImage];
    }
    
    return self;
}

-(void)initLabel:(UILabel *)label text:(NSString *)text andSize:(CGSize)labelSize{
    //label = [[UILabel alloc] init];
    //[label setText:text];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:self.abc.labelFont];
    [label setBackgroundColor:[UIColor clearColor]];

    //labelSize = [text sizeWithFont:[UIFont systemFontOfSize:22]];
    
    //NSLog(@"DVC labelSize height: %f, width: %f", labelSize.height, labelSize.width);
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
    [self.topSection setDelegate:self];
    
    self.uploadIcon = [[Icon alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - self.abc.primaryButtonDiameter/2, self.view.frame.size.height - 80.0f + self.abc.topBoxHeight, self.abc.primaryButtonDiameter, self.abc.primaryButtonDiameter)];
    [self.uploadIcon changeIconType:ICON_UPLOAD];
    
    CGFloat addButtonWidth = 120.0f;
    self.bigAddIcon = [[Icon alloc] initWithFrame:CGRectMake(self.view.center.x - addButtonWidth/2, self.view.center.y + self.abc.topBoxHeight - addButtonWidth/2, addButtonWidth, addButtonWidth)];
    [self.bigAddIcon changeIconType:ICON_ADD];
    [self.bigAddIcon setTag:1];
    [self.bigAddIcon setMyDelegate:self];
    
    [self.mainView addSubview:self.topSection];
    [self.mainView addSubview:self.bigAddIcon];
    //[self.mainView addSubview:self.uploadIcon];
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"DVC iconClicked: %i, buildStage: %i", icon.tag, self.buildStage);
    if(icon.tag == 1){
        NSLog(@"DVC big add button");
        
        [UIView animateWithDuration:0.5f animations:^{
            [self.bigAddIcon setFrame:CGRectMake(self.abc.builderBuffer + self.ifSize.width + self.abc.builderBuffer, 90.0f + self.abc.topBoxHeight, self.abc.builderIconHeight, self.abc.builderIconHeight)];
            [self.bigAddIcon.layer setCornerRadius:self.abc.builderIconHeight/2];
            [self.bigAddIcon changeIconType:ICON_CUSTOM];
        } completion:^(BOOL finished){
            [self.sensorIcon setFrame:CGRectMake(self.bigAddIcon.frame.origin.x, self.bigAddIcon.frame.origin.y, self.bigAddIcon.frame.size.width, self.bigAddIcon.frame.size.height)];
            [self.mainView addSubview:self.sensorIcon];
            
            [self.bigAddIcon removeFromSuperview];
            NSLog(@"DVC ifLabel width: %f, height: %f", self.ifSize.width, self.ifSize.height);
            self.buildStage = SENSOR_SELECT;
            
            CGFloat heightAdjust = (self.bigAddIcon.frame.size.height - self.ifSize.height)/2;
            [self.ifLabel setFrame:CGRectMake(self.abc.builderBuffer, 90.0f + self.abc.topBoxHeight + heightAdjust, self.ifSize.width, self.ifSize.height)];
            [self.mainView addSubview:self.ifLabel];
            
            //[self.arrow1 setFrame:CGRectMake(self.ifLabel.frame.origin.y + self.ifLabel.frame.size.width, 90.0f + self.abc.topBoxHeight, self.arrow1.frame.size.width, self.arrow1.frame.size.height)];
            //[self.mainView addSubview:self.arrow1];
            
            
            [self.topSection selectCategoryByType:ICON_SENSOR];
        }];
    } else if(icon.tag == 2){
        NSLog(@"DVC confirm listener clicked");
    } else if(icon.tag >= 20 && icon.tag < 30 && self.buildStage == SENSOR_SELECT){
        [self.sensorIcon changeIconType:icon.iconType];
        [self gotoStage: COMPARATOR_SELECT];
    } else if(icon.tag >= 30 && icon.tag < 40 && self.buildStage == COMPARATOR_SELECT){
        [self.comparatorIcon changeIconType:icon.iconType];
        [self gotoStage:VALUE_SELECT];
    } else if(icon.tag >= 40 && icon.tag < 50 && self.buildStage == VALUE_SELECT){
        [self.valueIcon changeIconType:icon.iconType];
        [self gotoStage:ACTION_SELECT];
    } else if(icon.tag >= 50 && icon.tag < 60 && self.buildStage == ACTION_SELECT){
        [self.gestureIcon changeIconType:icon.iconType];
        [self gotoStage:REGION_SELECT];
    } else if(icon.tag >= 60 && icon.tag < 70 && self.buildStage == REGION_SELECT){
        [self.regionIcon changeIconType:icon.iconType];
        [self gotoStage:CONFIRM_LISTENER];
    }
}

-(void)gotoStage:(BUILD_LISTENER_STATUS)stage{
    switch (stage) {
        case PRE_SELECT:
            self.buildStage = PRE_SELECT;
            break;
        
        case SENSOR_SELECT:
            self.buildStage = SENSOR_SELECT;
            break;
        
        case COMPARATOR_SELECT:
            self.buildStage = COMPARATOR_SELECT;
            [self.isLabel setFrame:CGRectMake(self.bigAddIcon.frame.size.width + self.bigAddIcon.frame.origin.x + self.abc.builderBuffer, self.bigAddIcon.frame.origin.y + (self.bigAddIcon.frame.size.height - self.isSize.height)/2, self.isSize.width, self.isSize.height)];
            [self.mainView addSubview:self.isLabel];
            [self.comparatorIcon setFrame:CGRectMake(self.isLabel.frame.origin.x + self.isLabel.frame.size.width + self.abc.builderBuffer, self.bigAddIcon.frame.origin.y, self.comparatorIcon.frame.size.width, self.comparatorIcon.frame.size.height)];
            [self.mainView addSubview:self.comparatorIcon];
            [self.topSection selectCategoryByType:ICON_COMPARATOR];
            break;
        
        case VALUE_SELECT:
            self.buildStage = VALUE_SELECT;
            [self.valueIcon setFrame:CGRectMake(self.comparatorIcon.frame.origin.x + self.comparatorIcon.frame.size.width + self.abc.builderBuffer, self.comparatorIcon.frame.origin.y, self.abc.builderIconHeight, self.abc.builderIconHeight)];
            [self.mainView addSubview:self.valueIcon];
            [self.topSection selectCategoryByType:ICON_VALUE];
            break;
        
        case ACTION_SELECT:
            self.buildStage = ACTION_SELECT;
            [self.applyLabel setFrame:CGRectMake(self.abc.builderBuffer, self.comparatorIcon.frame.origin.y + self.comparatorIcon.frame.size.height + self.abc.builderBuffer + (self.comparatorIcon.frame.size.height - self.applySize.height)/2, self.applySize.width, self.applySize.height)];
            [self.mainView addSubview:self.applyLabel];
            
            [self.gestureIcon setFrame:CGRectMake(self.applyLabel.frame.origin.x + self.applyLabel.frame.size.width + self.abc.builderBuffer, self.comparatorIcon.frame.size.height + self.comparatorIcon.frame.origin.y + self.abc.builderBuffer, self.abc.builderIconHeight, self.abc.builderIconHeight)];
            [self.mainView addSubview:self.gestureIcon];
            [self.topSection selectCategoryByType:ICON_GESTURE];
            
            break;
        
        case REGION_SELECT:
            self.buildStage = REGION_SELECT;
            [self.ontoLabel setFrame:CGRectMake(self.gestureIcon.frame.origin.x + self.gestureIcon.frame.size.width + self.abc.builderBuffer, self.gestureIcon.frame.origin.y + (self.gestureIcon.frame.size.height - self.ontoSize.height)/2, self.ontoSize.width, self.ontoSize.height)];
            [self.mainView addSubview:self.ontoLabel];
            
            [self.regionIcon setFrame:CGRectMake(self.ontoLabel.frame.origin.x + self.ontoLabel.frame.size.width + self.abc.builderBuffer, self.gestureIcon.frame.origin.y, self.abc.builderIconHeight, self.abc.builderIconHeight)];
            [self.mainView addSubview:self.regionIcon];
            [self.topSection selectCategoryByType:ICON_REGION];
            break;
        
        case CONFIRM_LISTENER:
            self.buildStage = CONFIRM_LISTENER;
            [self.confirmListenerIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.confirmListenerButtonHeight/2, self.gestureIcon.frame.origin.y + self.gestureIcon.frame.size.height + self.abc.builderBuffer, self.abc.confirmListenerButtonHeight, self.abc.confirmListenerButtonHeight)];
            [self.mainView addSubview:self.confirmListenerIcon];
            
            break;
            
        default:
            break;
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
