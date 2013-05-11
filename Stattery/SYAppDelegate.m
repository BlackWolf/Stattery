//
//  SYAppDelegate.m
//  Stattery
//
//  Created by Mario Schreiner on 5/11/13.
//  Copyright (c) 2013 Mario Schreiner. All rights reserved.
//

#import "SYAppDelegate.h"
#import "SYBatteryInfo.h"
#import "DebugUtils.h"

@implementation SYAppDelegate
@synthesize batteryInfoHistory;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.batteryInfoHistory = [NSMutableArray array];
    
    [self fetchNextBatteryInfo];
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(fetchNextBatteryInfo) userInfo:nil repeats:YES];
}

/**
 * Fetches the current battery info and adds it at the first position of the batteryInfoHistory
 **/
-(void)fetchNextBatteryInfo {
    SYBatteryInfo *newInfo = [[SYBatteryInfo alloc] init];
    [self.batteryInfoHistory insertObject:newInfo atIndex:0];
    
    DEBUG_OUTPUT(@"%@", newInfo);
}

@end
