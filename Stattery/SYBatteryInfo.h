//
//  SYBatteryInfo.h
//  Stattery
//
//  Created by Mario Schreiner on 5/10/13.
//  Copyright (c) 2013 Mario Schreiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYBatteryInfo : NSObject <NSCoding> {
    NSDate *time;
    int currentPower;
    int maxPower;
    int amperage;
    int voltage;
    int cycleCount;
}

@property (readonly) NSDate *time;
@property (readonly) int currentPower;
@property (readonly) int maxPower;
@property (readonly) int amperage;
@property (readonly) int voltage;
@property (readonly) int cycleCount;

-(double)powerPercentage;
-(double)watt;

@end
