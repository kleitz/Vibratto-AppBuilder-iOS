//
//  ViewController.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/15/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "ViewController.h"
#import "AppBuilderConstants.h"
#import "DeviceViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(id)init{
    NSLog(@"ViewController init");
    self = [super init];
    if(self){
        self.constants = [AppBuilderConstants getAppBuilderConstants];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:self.constants.primaryColor1];
    
    self.addDeviceButton = [[Icon alloc] initWithFrame:CGRectMake(self.view.center.x - self.constants.primaryButtonDiameter/2, self.view.frame.size.height * 0.8f, self.constants.primaryButtonDiameter, self.constants.primaryButtonDiameter)];
    [self.addDeviceButton changeIconType:ICON_ADD];
    [self.addDeviceButton.layer setBorderWidth:1.0f];
    [self.addDeviceButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.addDeviceButton setMyDelegate:self];
    
    [self.view addSubview:self.addDeviceButton];
    
    NSLog(@"Done setting up!");
}

-(void)viewWillAppear:(BOOL)animated{
    [self setupBluetoothCentral];
    //[self setupBluetoothPeripheral];
}

-(void)newDeviceButtonClicked{
    NSLog(@"New device button clicked!");
    DeviceViewController *dvc = [[DeviceViewController alloc] init];
    
    [self presentViewController:dvc animated:YES completion:nil];
}

-(void)iconClicked:(Icon *)icon{
    [self newDeviceButtonClicked];
}


-(void)setupBluetoothPeripheral{
    NSLog(@"Hi from setupBluetooth");
    
    self.btPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    //self.btPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    NSLog(@"initialized peripheralManager");
    
    CBUUID *myCustomServiceUUID = [CBUUID UUIDWithString:@"7698BD06-62BA-46FA-A1ED-1EA14926E259"];
    CBUUID *myChustomCharacteristicUUID = [CBUUID UUIDWithString:@"E30EEF25-88B4-44CC-88CF-E434A81D570A"];
    NSLog(@"Generated UUIDs");
    
    self.btCharacteristic = [[CBMutableCharacteristic alloc] initWithType:myChustomCharacteristicUUID properties:CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];
    self.btService = [[CBMutableService alloc] initWithType:myCustomServiceUUID primary:YES];
    self.btService.characteristics = @[self.btCharacteristic];
}

-(void)setupBluetoothCentral{
    NSLog(@"Hi from setupBluetooth central");
    self.btCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"Hi from centralManager did update state: %li", (long)central.state);
    if(central.state == CBCentralManagerStatePoweredOn){
        NSLog(@"State is on!");
        [self.btCentralManager scanForPeripheralsWithServices:nil options:nil];
    } else {
        NSLog(@"State is something else");
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"Hi from centralManagerDidDiscoverPeripheral, name:%@ uuid:%@, id: %@", peripheral.name, peripheral.UUID, peripheral.identifier);
    NSLog(@"PeripheralData: %@", advertisementData);
    self.btPeripheral = peripheral;
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"CentralManager didConnectPeripheral: %@", peripheral.UUID);
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    NSLog(@"Hi from peripheralManagerDidUpdateState");
    if(peripheral.state == CBPeripheralManagerStatePoweredOn){
        NSLog(@"peripheral powered on!");
        [self.btPeripheralManager addService:self.btService];
    } else {
        NSLog(@"State was something else: %li", (long)peripheral.state);
    }
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    NSLog(@"Hi from peripheralManagerDidAddService");
    if(error){
        NSLog(@"Error publishing service: %@", [error localizedDescription]);
    } else {
        [self.btPeripheralManager startAdvertising:@{CBAdvertisementDataServiceUUIDsKey: @[self.btService.UUID]}];
    }
}

-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    NSLog(@"Hi from peripheralManagerDidStartAdvertising");
    if(error){
        NSLog(@"Error advertising service: %@", [error localizedDescription]);
    } else {
        NSLog(@"Advertised successfully!, %i", peripheral.isAdvertising);
    }
}


@end
