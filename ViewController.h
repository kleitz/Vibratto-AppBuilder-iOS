//
//  ViewController.h
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppBuilderConstants.h"
#import "Icon.h"
#import "DeviceViewController.h"
#include <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController<IconDelegate, CBCentralManagerDelegate, CBPeripheralManagerDelegate, DeviceBuilderDelegate>

@property(strong, nonatomic) AppBuilderConstants *abc;
@property(strong, nonatomic) Icon *addDeviceButton;

@property(strong, nonatomic) CBPeripheralManager *btPeripheralManager;
@property(strong, nonatomic) CBMutableService *btService;
@property(strong, nonatomic) CBMutableCharacteristic *btCharacteristic;

@property(strong, nonatomic) CBCentralManager *btCentralManager;

@property(strong, nonatomic) CBPeripheral *btPeripheral;

@property(strong, nonatomic) NSMutableArray *sketches;

@property(assign, nonatomic) int iconsPerRow;
@end
