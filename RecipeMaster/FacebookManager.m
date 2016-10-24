//
//  Facebook.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "FacebookManager.h"
#import "Shared.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKCoreKit/FBSDKGraphRequest.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation FacebookManager {
    
    NSString *userStatusLoginText;
    NSString *userStatusLogoutText;
    
}

#pragma mark - SINGLETON

+ (FacebookManager *)sharedManager {
   
    static FacebookManager *sharedManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (!sharedManager) {
            sharedManager = [[FacebookManager alloc] init];
        }
  
    });
    
    return sharedManager;
    
}

#pragma mark - INIT

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        userStatusLoginText = NSLocalizedString(@"LoggedAs", nil);
        userStatusLogoutText = NSLocalizedString(@"NotLoggedUser", nil);
        self.fullUserStatus = userStatusLogoutText;
        
    }
    return self;
    
}

#pragma mark - LOGIN

- (void)loginFromViewController:(UIViewController *)viewController {
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"public_profile"]
                        fromViewController:viewController
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       if (error) {
                                           NSLog(@"Error %@", error);
                                       }
                                       
                                       [[NSNotificationCenter defaultCenter] postNotificationName:FacebookLoginNotification object:nil];
                                       
                                   }];
    
}

- (BOOL)checkToken {
    
    return ([FBSDKAccessToken currentAccessToken] != nil);
    
}

#pragma mark - LOGOUT

- (void)logout {
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    self.userName = nil;
    self.fullUserStatus = userStatusLogoutText;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FacebookLogoutNotification object:nil];
    
}

#pragma mark - USER DATA

- (void)getUserData {
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (error) {
             
             NSLog(@"Error %@", error);
             self.userName = nil;
             
         } else {
             
             NSDictionary *userData = (NSDictionary *)result;
             self.userName = [userData valueForKey:@"name"];
             self.fullUserStatus = [NSString stringWithFormat:@"%@ %@", userStatusLoginText, self.userName];
             
         }
         
         [[NSNotificationCenter defaultCenter] postNotificationName:FacebookUserDataLoadCompleteNotification object:result];
         
     }];
    
}

@end
