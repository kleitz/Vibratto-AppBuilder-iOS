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
#include <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController<IconDelegate, CBCentralManagerDelegate, CBPeripheralManagerDelegate>

@property(strong, nonatomic) AppBuilderConstants *constants;
@property(strong, nonatomic) Icon *addDeviceButton;

@property(strong, nonatomic) CBPeripheralManager *btPeripheralManager;
@property(strong, nonatomic) CBMutableService *btService;
@property(strong, nonatomic) CBMutableCharacteristic *btCharacteristic;

@property(strong, nonatomic) CBCentralManager *btCentralManager;

@property(strong, nonatomic) CBPeripheral *btPeripheral;

@end
