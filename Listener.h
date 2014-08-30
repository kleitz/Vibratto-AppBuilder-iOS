//
//  Listener.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/29/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeData.h"

@interface Listener : TypeData
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *sensor;
@property(strong, nonatomic) NSString *sensorA;
@property(strong, nonatomic) NSString *sensorB;
@property(strong, nonatomic) NSString *gesture;
@property(strong, nonatomic) NSString *region;
@property(assign, nonatomic) int value;
@property(assign, nonatomic) int maximumFires;
@property(assign, nonatomic) BOOL needsToReset;

@end
