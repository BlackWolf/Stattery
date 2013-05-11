//
//  SYAppDelegate.h
//  Stattery
//
//  Created by Mario Schreiner on 5/11/13.
//  Copyright (c) 2013 Mario Schreiner. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SYAppDelegate : NSObject <NSApplicationDelegate> {
    NSMutableArray *batteryInfoHistory;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) NSMutableArray *batteryInfoHistory;
@end

