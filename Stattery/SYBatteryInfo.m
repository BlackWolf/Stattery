//
//  SYBatteryInfo.m
//  Stattery
//
//  Created by Mario Schreiner on 5/10/13.
//  Copyright (c) 2013 Mario Schreiner. All rights reserved.
//
//  Most of the code in this class is based on "Battery Time Remaining" by codler / Han Lin Yap. Thanks a lot!
//  Credits for battery info fetching code: https://github.com/codler/Battery-Time-Remaining
//

#import "SYBatteryInfo.h"

@interface SYBatteryInfo()

@property (copy, readwrite) NSDate *time;
@property (assign, readwrite) int currentPower;
@property (assign, readwrite) int maxPower;
@property (assign, readwrite) int amperage;
@property (assign, readwrite) int voltage;
@property (assign, readwrite) int cycleCount;

@end

@implementation SYBatteryInfo
@synthesize time, currentPower, maxPower, amperage, voltage, cycleCount;

-(id)init {
    self = [super init];
    if (self) {
        self.time = [NSDate date];
        
        //Fetch and save current battery info
        NSDictionary *advancedBatteryInfo = [self getAdvancedBatteryInfo];
        self.currentPower = [[advancedBatteryInfo objectForKey:@"Current"] intValue];   //unit: mAh
        self.maxPower = [[advancedBatteryInfo objectForKey:@"Capacity"] intValue];      //unit: mAh
        self.amperage = [[advancedBatteryInfo objectForKey:@"Amperage"] intValue];      //unit: mAh
        self.voltage = [[advancedBatteryInfo objectForKey:@"Voltage"] intValue];        //unit: mV
        self.cycleCount = [[advancedBatteryInfo objectForKey:@"Cycle Count"] intValue]; //unit: cycles
        
        //TODO add isCharging boolean
    }
    return self;
}

/**
 * Calculates the percentage of power left in the battery
 **/
-(double)powerPercentage {
    return (double)self.currentPower/(double)self.maxPower*100.0;                             //unit: percent
}

/**
 * Calculates the current power consumption in Watts
 **/
-(double)watt {
    return (double)self.amperage/1000.0 * (double)self.voltage/1000.0;                  //unit: Wh
}

//From https://github.com/codler/Battery-Time-Remaining
- (NSDictionary *)getAdvancedBatteryInfo
{
    mach_port_t masterPort;
    CFArrayRef batteryInfo;
    
    if (kIOReturnSuccess == IOMasterPort(MACH_PORT_NULL, &masterPort) &&
        kIOReturnSuccess == IOPMCopyBatteryInfo(masterPort, &batteryInfo))
    {
        return [(__bridge NSArray*)batteryInfo objectAtIndex:0];
    }
    return nil;
}

//From https://github.com/codler/Battery-Time-Remaining
- (NSDictionary *)getMoreAdvancedBatteryInfo
{
    CFMutableDictionaryRef matching, properties = NULL;
    io_registry_entry_t entry = 0;
    // same as matching = IOServiceMatching("IOPMPowerSource");
    matching = IOServiceNameMatching("AppleSmartBattery");
    entry = IOServiceGetMatchingService(kIOMasterPortDefault, matching);
    IORegistryEntryCreateCFProperties(entry, &properties, NULL, 0);
    return (__bridge NSDictionary *)properties;
    //IOObjectRelease(entry);
}

#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
    self = [super init];
    if (self) {
        self.time = [decoder decodeObjectForKey:@"time"];

        self.currentPower = [decoder decodeIntForKey:@"currentPower"];
        self.maxPower = [decoder decodeIntForKey:@"maxPower"];
        self.amperage = [decoder decodeIntForKey:@"amperage"];
        self.voltage = [decoder decodeIntForKey:@"voltage"];
        self.cycleCount = [decoder decodeIntForKey:@"cycleCount"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.time forKey:@"time"];
    
    [encoder encodeInt:self.currentPower forKey:@"currentPower"];
    [encoder encodeInt:self.currentPower forKey:@"maxPower"];
    [encoder encodeInt:self.currentPower forKey:@"amperage"];
    [encoder encodeInt:self.currentPower forKey:@"voltage"];
    [encoder encodeInt:self.currentPower forKey:@"cycleCount"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Battery at %d/%d (%f%%) ; %dmAh and %dmV ; %d cycles", self.currentPower, self.maxPower, [self powerPercentage], self.amperage, self.voltage, self.cycleCount];
}


@end
