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
        
        int tagBase = 1000;
        
        [self.sensorIcon setTag:tagBase + ICON_SENSOR];
        [self.comparatorIcon setTag:tagBase + ICON_COMPARATOR];
        [self.valueIcon setTag:tagBase + ICON_VALUE];
        [self.gestureIcon setTag:tagBase + ICON_GESTURE];
        [self.regionIcon setTag:tagBase + ICON_REGION];
        
        [self.sensorIcon setMyDelegate:self];
        [self.comparatorIcon setMyDelegate:self];
        [self.valueIcon setMyDelegate:self];
        [self.gestureIcon setMyDelegate:self];
        [self.regionIcon setMyDelegate:self];
        
        self.confirmListenerIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.confirmListenerButtonHeight, self.abc.confirmListenerButtonHeight)];
        [self.confirmListenerIcon changeIconType:ICON_CONFIRM];
        [self.confirmListenerIcon setMyDelegate:self];
        [self.confirmListenerIcon setTag:2];
        
        self.createdListenerIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.builderIconHeight, self.abc.builderIconHeight)];
        [self.createdListenerIcon setMyDelegate:self];
        [self.createdListenerIcon setTag:3];
        
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

    [label setTextColor:[UIColor whiteColor]];
    [label setFont:self.abc.labelFont];
    [label setBackgroundColor:[UIColor clearColor]];
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
    
    self.bigAddIcon = [[Icon alloc] initWithFrame:CGRectMake(0, 0, self.abc.bigAddButtonHeight, self.abc.bigAddButtonHeight)];
    [self.bigAddIcon changeIconType:ICON_ADD];
    [self.bigAddIcon setTag:1];
    [self.bigAddIcon setMyDelegate:self];
    
    [self.mainView addSubview:self.topSection];

    [self gotoStage:PRE_SELECT];
    //[self.mainView addSubview:self.uploadIcon];
}

-(void)processStage{
    if(self.buildStage == self.frontierStage){
        [self gotoStage: self.nextStage];
    } else {
        [self gotoStage: self.frontierStage];
    }
    
}

-(void)iconClicked:(Icon *)icon{
    NSLog(@"DVC iconClicked: %li, buildStage: %i", (long)icon.tag, self.buildStage);
    if(icon.tag == 1){
        NSLog(@"DVC big add button");
        [self processStage];
    } else if(icon.tag == 2){
        NSLog(@"DVC confirm listener clicked");

        [self processStage];
    } else if(icon.tag >= (ICON_SENSOR * 100) && icon.tag < ((ICON_SENSOR * 100) + 100) && self.buildStage == SENSOR_SELECT){
        [self.sensorIcon changeIconType:icon.iconType];
        [self processStage];
    } else if(icon.tag >= (ICON_COMPARATOR * 100) && icon.tag < ((ICON_COMPARATOR * 100) + 100) && self.buildStage == COMPARATOR_SELECT){
        [self.comparatorIcon changeIconType:icon.iconType];
        [self processStage];
    } else if(icon.tag == (ICON_VALUE * 100) && self.buildStage == VALUE_SELECT){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Set Value" message:@"Enter Value (0-1023)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [alertView setTag:1];
        [alertView show];
    } else if(icon.tag >= (ICON_VALUE * 100) && icon.tag < ((ICON_VALUE * 100) + 100) && self.buildStage == VALUE_SELECT){
        [self.valueIcon changeIconType:icon.iconType];
        [self processStage];
    } else if(icon.tag >= (ICON_GESTURE * 100) && icon.tag < ((ICON_GESTURE * 100) + 100) && self.buildStage == ACTION_SELECT){
        [self.gestureIcon changeIconType:icon.iconType];
        [self processStage];
    } else if(icon.tag >= (ICON_REGION * 100) && icon.tag < ((ICON_REGION * 100) + 100) && self.buildStage == REGION_SELECT){
        [self.regionIcon changeIconType:icon.iconType];
        [self processStage];
    } else if(icon.tag >= 1000 && icon.tag <2000){
        int tagAdjust = icon.tag - 1000;
        
        switch (tagAdjust) {
            case ICON_SENSOR:
                [self gotoStage:SENSOR_SELECT];
                break;
                
            case ICON_COMPARATOR:
                [self gotoStage:COMPARATOR_SELECT];
                break;
            
            case ICON_VALUE:
                [self gotoStage:VALUE_SELECT];
                break;
            
            case ICON_GESTURE:
                [self gotoStage:ACTION_SELECT];
                break;
            
            case ICON_REGION:
                [self gotoStage:REGION_SELECT];
                break;
                
            default:
                break;
        }
        
        /*
        if(tagAdjust == ICON_SENSOR){
            [self gotoStage:SENSOR_SELECT];
        } else if(tagAdjust == ICON_COMPARATOR){
            [self gotoStage:COMPARATOR_SELECT];
        } else if(tagAdjust == )
        */
        
        //[self.topSection selectCategoryByType:tagAdjust];
    }

}

-(void)highlightBuildStageIcon:(Icon *)icon{
    
    [icon.layer setBorderColor:self.abc.primaryColor2.CGColor];
    [icon.layer setBorderWidth:1.0f];
    
    if(self.buildStageIcon != nil){
        [self.buildStageIcon.layer setBorderWidth:0.0f];
        [self.buildStageIcon.layer setBorderColor:[UIColor clearColor].CGColor];
    }
    
    self.buildStageIcon = icon;
}

-(void)gotoStage:(BUILD_LISTENER_STATUS)stage{
    switch (stage) {
        case PRE_SELECT:
            self.buildStage = PRE_SELECT;
            if(self.nextStage == self.buildStage){
                [self.bigAddIcon setFrame:CGRectMake(self.view.center.x - self.abc.bigAddButtonHeight/2, self.view.center.y + self.abc.topBoxHeight - self.abc.bigAddButtonHeight/2, self.abc.bigAddButtonHeight, self.abc.bigAddButtonHeight)];
                [self.bigAddIcon changeIconType:ICON_ADD];
                [self.bigAddIcon.layer setCornerRadius:self.abc.bigAddButtonHeight/2];
                //[self.mainView addSubview:self.bigAddIcon];
                [self.mainView insertSubview:self.bigAddIcon belowSubview:self.topSection];
                self.frontierStage = PRE_SELECT;
                self.nextStage = SENSOR_SELECT;
            }
            
            break;
        
        case SENSOR_SELECT:{
            self.buildStage = SENSOR_SELECT;
            if(self.nextStage == self.buildStage){
                
                [UIView animateWithDuration:0.5f animations:^{
                    [self.bigAddIcon setFrame:CGRectMake(self.abc.builderBuffer + self.ifSize.width + self.abc.builderBuffer, 90.0f + self.abc.topBoxHeight, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                    [self.bigAddIcon.layer setCornerRadius:self.abc.builderIconHeight/2];
                    [self.bigAddIcon changeIconType:ICON_CUSTOM];
                } completion:^(BOOL finished){
                    [self.sensorIcon setFrame:CGRectMake(self.bigAddIcon.frame.origin.x, self.bigAddIcon.frame.origin.y, self.bigAddIcon.frame.size.width, self.bigAddIcon.frame.size.height)];
                    [self.mainView insertSubview:self.sensorIcon belowSubview:self.topSection];
                    //[self.mainView addSubview:self.sensorIcon];
                    
                    [self.bigAddIcon removeFromSuperview];
                    NSLog(@"DVC ifLabel width: %f, height: %f", self.ifSize.width, self.ifSize.height);
                    self.buildStage = SENSOR_SELECT;
                    
                    CGFloat heightAdjust = (self.bigAddIcon.frame.size.height - self.ifSize.height)/2;
                    [self.ifLabel setFrame:CGRectMake(self.abc.builderBuffer, 90.0f + self.abc.topBoxHeight + heightAdjust, self.ifSize.width, self.ifSize.height)];
                    
                    [self.mainView insertSubview:self.ifLabel belowSubview:self.topSection];
                    //[self.mainView addSubview:self.ifLabel];
                    
                    
                    
                    self.frontierStage = SENSOR_SELECT;
                    self.nextStage = COMPARATOR_SELECT;
                }];
            }
            
            [self.topSection selectCategoryByType:ICON_SENSOR];
            [self highlightBuildStageIcon:self.sensorIcon];
            break;
        }
        
        case COMPARATOR_SELECT:
            self.buildStage = COMPARATOR_SELECT;
            if(self.nextStage == self.buildStage){
                [self.isLabel setFrame:CGRectMake(self.bigAddIcon.frame.size.width + self.bigAddIcon.frame.origin.x + self.abc.builderBuffer, self.bigAddIcon.frame.origin.y + (self.bigAddIcon.frame.size.height - self.isSize.height)/2, self.isSize.width, self.isSize.height)];
                [self.mainView insertSubview:self.isLabel belowSubview:self.topSection];
                //[self.mainView addSubview:self.isLabel];
                [self.comparatorIcon setFrame:CGRectMake(self.isLabel.frame.origin.x + self.isLabel.frame.size.width + self.abc.builderBuffer, self.bigAddIcon.frame.origin.y, self.comparatorIcon.frame.size.width, self.comparatorIcon.frame.size.height)];
                [self.mainView insertSubview:self.comparatorIcon belowSubview:self.topSection];
                //[self.mainView addSubview:self.comparatorIcon];
                
                
                self.frontierStage = COMPARATOR_SELECT;
                self.nextStage = VALUE_SELECT;
            }
            
            [self.topSection selectCategoryByType:ICON_COMPARATOR];
            [self highlightBuildStageIcon:self.comparatorIcon];
            break;
        
        case VALUE_SELECT:
            self.buildStage = VALUE_SELECT;
            if(self.nextStage == self.buildStage){
                [self.valueIcon setFrame:CGRectMake(self.comparatorIcon.frame.origin.x + self.comparatorIcon.frame.size.width + self.abc.builderBuffer, self.comparatorIcon.frame.origin.y, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                [self.mainView insertSubview:self.valueIcon belowSubview:self.topSection];
                //[self.mainView addSubview:self.valueIcon];
                
                
                self.frontierStage = VALUE_SELECT;
                self.nextStage = ACTION_SELECT;
            }
            
            [self.topSection selectCategoryByType:ICON_VALUE];
            [self highlightBuildStageIcon:self.valueIcon];
            break;
        
        case ACTION_SELECT:
            self.buildStage = ACTION_SELECT;
            
            if(self.nextStage == self.buildStage){
                [self.applyLabel setFrame:CGRectMake(self.abc.builderBuffer, self.comparatorIcon.frame.origin.y + self.comparatorIcon.frame.size.height + self.abc.builderBuffer + (self.comparatorIcon.frame.size.height - self.applySize.height)/2, self.applySize.width, self.applySize.height)];
                
                [self.mainView insertSubview:self.applyLabel belowSubview:self.topSection];
                //[self.mainView addSubview:self.applyLabel];
                
                [self.gestureIcon setFrame:CGRectMake(self.applyLabel.frame.origin.x + self.applyLabel.frame.size.width + self.abc.builderBuffer, self.comparatorIcon.frame.size.height + self.comparatorIcon.frame.origin.y + self.abc.builderBuffer, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                
                [self.mainView insertSubview:self.gestureIcon belowSubview:self.topSection];
                //[self.mainView addSubview:self.gestureIcon];
                
                
                self.frontierStage = ACTION_SELECT;
                self.nextStage = REGION_SELECT;
            }
            
            [self.topSection selectCategoryByType:ICON_GESTURE];
            [self highlightBuildStageIcon:self.gestureIcon];
            break;
        
        case REGION_SELECT:
            self.buildStage = REGION_SELECT;
            
            if(self.nextStage == self.buildStage){
                [self.ontoLabel setFrame:CGRectMake(self.gestureIcon.frame.origin.x + self.gestureIcon.frame.size.width + self.abc.builderBuffer, self.gestureIcon.frame.origin.y + (self.gestureIcon.frame.size.height - self.ontoSize.height)/2, self.ontoSize.width, self.ontoSize.height)];
                
                [self.mainView insertSubview:self.ontoLabel belowSubview:self.topSection];
                
                [self.regionIcon setFrame:CGRectMake(self.ontoLabel.frame.origin.x + self.ontoLabel.frame.size.width + self.abc.builderBuffer, self.gestureIcon.frame.origin.y, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                
                [self.mainView insertSubview:self.regionIcon belowSubview:self.topSection];
                
                self.frontierStage = REGION_SELECT;
                self.nextStage = CONFIRM_LISTENER;
            }
            
            [self.topSection selectCategoryByType:ICON_REGION];
            [self highlightBuildStageIcon:self.regionIcon];
            break;
        
        case CONFIRM_LISTENER:
            self.buildStage = CONFIRM_LISTENER;
            if(self.nextStage == self.buildStage){
                [self.confirmListenerIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.confirmListenerButtonHeight/2, self.gestureIcon.frame.origin.y + self.gestureIcon.frame.size.height + self.abc.builderBuffer, self.abc.confirmListenerButtonHeight, self.abc.confirmListenerButtonHeight)];
                
                [self.mainView insertSubview:self.confirmListenerIcon belowSubview:self.topSection];
                
                self.frontierStage = CONFIRM_LISTENER;
                self.nextStage = BUILD_LISTENER;
            }
            
            [self highlightBuildStageIcon:self.confirmListenerIcon];
            break;
        
        case BUILD_LISTENER:{
            self.buildStage = BUILD_LISTENER;
            [self.confirmListenerIcon removeFromSuperview];
            [self.topSection selectCategoryByType:ICON_LISTENER];
            
            [UIView animateWithDuration:0.4f animations:^{
            
                [self.sensorIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.builderIconHeight/2, self.mainView.center.y - self.abc.builderIconHeight/2, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                [self.comparatorIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.builderIconHeight/2, self.mainView.center.y - self.abc.builderIconHeight/2, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                [self.valueIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.builderIconHeight/2, self.mainView.center.y - self.abc.builderIconHeight/2, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                [self.gestureIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.builderIconHeight/2, self.mainView.center.y - self.abc.builderIconHeight/2, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                [self.regionIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.builderIconHeight/2, self.mainView.center.y - self.abc.builderIconHeight/2, self.abc.builderIconHeight, self.abc.builderIconHeight)];

                [self.ifLabel setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.isLabel setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.applyLabel setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
                [self.ontoLabel setFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 0, 0)];
            } completion:^(BOOL finished){
                [self.createdListenerIcon setFrame:CGRectMake(self.mainView.center.x - self.abc.builderIconHeight/2, self.mainView.center.y - self.abc.builderIconHeight/2, self.abc.builderIconHeight, self.abc.builderIconHeight)];
                [self.mainView addSubview:self.createdListenerIcon];
                
                [self.sensorIcon changeIconType:ICON_CUSTOM];
                [self.sensorIcon removeFromSuperview];
                
                [self.comparatorIcon changeIconType:ICON_CUSTOM];
                [self.comparatorIcon removeFromSuperview];
                
                [self.valueIcon changeIconType:ICON_CUSTOM];
                [self.valueIcon removeFromSuperview];
                
                [self.gestureIcon changeIconType:ICON_CUSTOM];
                [self.gestureIcon removeFromSuperview];
                
                [self.regionIcon changeIconType:ICON_CUSTOM];
                [self.regionIcon removeFromSuperview];
                
                [self.ifLabel removeFromSuperview];
                [self.isLabel removeFromSuperview];
                [self.applyLabel removeFromSuperview];
                [self.ontoLabel removeFromSuperview];
                
                
                CGFloat createdListenerX = self.topSection.iconBox.addIconBox.frame.size.width + (self.topSection.listenersArray.count * self.abc.iconHeight) + (self.topSection.iconBox.iconBuffer * (self.topSection.listenersArray.count + 1));
                
                /*
                 if(self.boxItems.count > 0){
                 Icon *lastIcon = [self.boxItems objectAtIndex:self.boxItems.count-1];
                 
                 newIcon = [[Icon alloc] initWithFrame:CGRectMake(lastIcon.frame.size.width + lastIcon.frame.origin.x + (2 * self.iconBuffer), lastIcon.frame.origin.y, self.abc.iconHeight, self.abc.iconHeight)];
                 
                 } else {
                 newIcon = [[Icon alloc] initWithFrame:CGRectMake(self.iconBuffer, self.iconBuffer, self.abc.iconHeight, self.abc.iconHeight)];
                 }
                */
                
                [UIView animateWithDuration:0.3f animations:^{
                    [self.createdListenerIcon setFrame:CGRectMake(createdListenerX, self.abc.topBoxHeight + (self.abc.topBoxHeight - self.abc.iconHeight)/2, self.abc.iconHeight, self.abc.iconHeight)];
                    [self.createdListenerIcon.layer setCornerRadius:self.abc.iconHeight/2];
                } completion:^(BOOL finished){
                    //[self.topSection.iconBox addIcon:ICON_CUSTOM andIconImage:nil andDelegate:nil andTag:100];
                    [self.topSection addNewIconInCategory:ICON_LISTENER iconType:ICON_CUSTOM andIconImage:nil andDelegate:self andTag:0 subtitle:nil];
                    [self.createdListenerIcon changeIconType:ICON_CUSTOM];
                    [self.createdListenerIcon removeFromSuperview];
                    
                    self.nextStage = PRE_SELECT;
                    [self gotoStage:PRE_SELECT];
                }];
            }];
            
            }
            
            break;
            
        default:
            break;
    }
}

-(void)showDropDown:(DropDownMenu *)dropDown{
    NSLog(@"DVC showDropDown");
    [dropDown setFrame:CGRectMake(0, self.topSection.frame.origin.y + self.topSection.frame.size.height - dropDown.frame.size.height, dropDown.frame.size.width, dropDown.frame.size.height)];
    [self.mainView insertSubview:dropDown belowSubview:self.topSection];
    //[self.mainView addSubview:dropDown];
    
    [UIView animateWithDuration:0.4f animations:^{
        [dropDown setFrame:CGRectMake(0, self.topSection.frame.origin.y + self.topSection.frame.size.height, dropDown.frame.size.width, dropDown.frame.size.height)];
    }];
    /*
    for(int i=0; i<self.mainView.subviews.count; i++){
        if([[self.mainView.subviews objectAtIndex:i] isKindOfClass:[CompoundTopSection class]]){
            self.mainView inser
            break;
        }
    }
    */
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"DVC alertView clickedbutton: %i, tag: %i", buttonIndex, alertView.tag);
    if(alertView.tag == 1){
        NSLog(@"DVC value input alertview");
        
        if(buttonIndex == 1){
            int textVal = [[[alertView textFieldAtIndex:0] text] intValue];
            if(textVal < 1024){
                [self.valueIcon changeCustomValue:[[[alertView textFieldAtIndex:0] text] intValue] setAsIconType:YES];
                [self gotoStage:ACTION_SELECT];
            }
        }
    }
}

@end
