//
//  TypeData.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/30/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MAP,
    SENSOR_TO_VALUE,
    SENSOR_TO_SENSOR,
} TRIGGER_TYPE;

typedef enum {
    ACTION_GESTURE,
    ACTION_DIRECT,
    ACTION_RELATIVE
} ACTION_TYPE;

@interface TypeData : NSObject

@property(assign, nonatomic) BOOL isCustom;

@end


@interface Actuator : TypeData

@property(assign, nonatomic) int pinNumber;

-(id)initWithPinNumber:(int)pinNumber andIsCustom:(BOOL)isCustom;

@end


@interface Sensor : TypeData

@property(strong, nonatomic) NSString *name;
@property(assign, nonatomic) int pinNumber;
@property(assign, nonatomic) int sensitivity;
@property(assign, nonatomic) BOOL hasName;

-(id)initWithPinNumber:(int)pinNumber hasName:(BOOL)hasName andName:(NSString *)name andSensitivity:(int)sensitivity andIsCustom:(BOOL)isCustom;

@end


@interface Listener : TypeData

@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *sensor;
@property(strong, nonatomic) NSString *sensorA;
@property(strong, nonatomic) NSString *sensorB;
@property(strong, nonatomic) NSString *gesture;
@property(strong, nonatomic) NSString *action;
@property(strong, nonatomic) NSString *region;
@property(strong, nonatomic) NSString *valueName;
@property(strong, nonatomic) NSString *onRegion;
@property(strong, nonatomic) NSString *toRegion;

@property(assign, nonatomic) TRIGGER_TYPE triggerType;
@property(assign, nonatomic) ACTION_TYPE actionType;
@property(assign, nonatomic) int sensorPin;
@property(assign, nonatomic) int sensorAPin;
@property(assign, nonatomic) int sensorBPin;
@property(assign, nonatomic) int triggerValue;
@property(assign, nonatomic) int maximumFires;

@property(assign, nonatomic) BOOL needsToReset;

@end


@interface Region : TypeData

@property(strong, nonatomic) NSString *name;

-(id)initWithName:(NSString *)name isCustom:(BOOL)isCustom;

@end


@interface Action : TypeData

@property(strong, nonatomic) NSString *name;

-(id)initWithName:(NSString *)name isCustom:(BOOL)isCustom;

@end


@interface Comparator : TypeData

@property(assign, nonatomic) int type;

-(id)initWithType:(int)type;

@end


@interface TriggerValue : TypeData

@property(assign, nonatomic) int triggerValue;

-(id)initWithTriggerValue:(int)triggerValue;

@end


