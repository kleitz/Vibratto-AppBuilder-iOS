//
//  Device.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject

@property(strong, nonatomic) NSMutableArray *sensors;
@property(strong, nonatomic) NSMutableArray *actuators;
@property(strong, nonatomic) NSMutableArray *listeners;
@property(strong, nonatomic) NSMutableArray *regions;

@end
