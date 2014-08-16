//
//  Device.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "Device.h"

@implementation Device

-(id)init{
    self = [super init];
    if(self){
        self.sensors = [[NSMutableArray alloc] init];
        self.actuators = [[NSMutableArray alloc] init];
        self.regions = [[NSMutableArray alloc] init];
        self.listeners = [[NSMutableArray alloc] init];
    }
    
    return self;
}
@end
