//
//  LoggingConstants.h
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "DDLog.h"

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif
