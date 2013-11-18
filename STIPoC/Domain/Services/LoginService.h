//
//  LoginService.h
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"

@interface LoginService : GenericService

- (BOOL)validateCredentialsWithUserID:(NSString *)userID domain:(NSString *)domain andPassword:(NSString *)password;

@end
