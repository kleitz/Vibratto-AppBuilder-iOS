//
//  TypeData.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/30/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "TypeData.h"


@implementation TypeData

@end



@implementation Actuator

-(id)initWithPinNumber:(int)pinNumber andIsCustom:(BOOL)isCustom{
    self = [super init];
    if(self){
        self.pinNumber = pinNumber;
        self.isCustom = isCustom;
    }
    
    return self;
}

@end



@implementation Sensor

-(id)init{
    self = [super init];
    if(self){
        self.pinNumber = -1;
        self.name = nil;
        self.sensitivity = -1;
        self.isCustom = NO;
    }
    
    return self;
}

-(id)initWithPinNumber:(int)pinNumber hasName:(BOOL)hasName andName:(NSString *)name andSensitivity:(int)sensitivity andIsCustom:(BOOL)isCustom{
    self = [super init];
    if(self){
        self.pinNumber = pinNumber;
        self.hasName = hasName;
        self.name = name;
        self.sensitivity = sensitivity;
        self.isCustom = isCustom;
    }
    
    return self;
}

@end



@implementation Region

-(id)initWithName:(NSString *)name andActuators:(NSArray *)actuators isCustom:(BOOL)isCustom{
    self = [super init];
    if(self){
        self.name = name;
        self.isCustom = isCustom;
        
        self.actuators = [[NSMutableArray alloc] init];
        
        for(int i=0; i<actuators.count; i++){
            [self.actuators addObject:[actuators objectAtIndex:i]];
        }
        
    }
    
    return self;
}

@end



@implementation Listener

-(id)init{
    self = [super init];
    if(self){
        self.sensorPin = -1;
        self.sensorAPin = -1;
        self.sensorBPin = -1;
        self.triggerValue = -1;
        self.maximumFires = -1;
        
        self.type = nil;
        self.sensor = nil;
        self.sensorA = nil;
        self.sensorB = nil;
        self.gesture = nil;
        self.action = nil;
        self.region = nil;
        self.onRegion = nil;
        self.toRegion = nil;
    }
    
    return self;
}

@end


@implementation TriggerValue

-(id)initWithTriggerValue:(int)triggerValue{
    self = [super init];
    
    if(self){
        self.triggerValue = triggerValue;
    }
    
    return self;
}

@end


@implementation Comparator

-(id)initWithType:(int)type{
    self = [super init];
    if(self){
        NSLog(@"TD comparator initWithType: %i", type);
        self.type = type;
    }
    
    return self;
}

@end

@implementation Action

-(id)initWithName:(NSString *)name isCustom:(BOOL)isCustom{
    self = [super init];
    if(self){
        self.name = name;
        self.isCustom = isCustom;
    }
    
    return self;
}

@end