//
//  Sensor.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/29/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeData.h"

@interface Sensor : TypeData

@property(assign, nonatomic) int pinNumber;
@property(strong, nonatomic) NSString *name;
@property(assign, nonatomic) int sensitivity;

@end
