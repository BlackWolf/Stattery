//
//  DebugUtils.h
//  Stattery
//
//  Created by Mario Schreiner on 5/10/13.
//  Copyright (c) 2013 Mario Schreiner. All rights reserved.
//

#ifndef Stattery_DebugUtils_h
#define Stattery_DebugUtils_h


#ifdef DEBUG
#    define DEBUG_OUTPUT(...) NSLog(__VA_ARGS__)
#else
#    define DEBUG_OUTPUT(...) /* */
#endif


#endif
