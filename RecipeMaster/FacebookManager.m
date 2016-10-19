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

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        userStatusLoginText = NSLocalizedString(@"LoggedAs", nil);
        userStatusLogoutText = NSLocalizedString(@"NotLoggedUser", nil);
        self.fullUserStatus = userStatusLogoutText;
        
    }
    return self;
    
}

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

- (void)logout {
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    self.userName = nil;
    self.fullUserStatus = userStatusLogoutText;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FacebookLogoutNotification object:nil];
    
}

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

- (BOOL)checkToken {
    
    return ([FBSDKAccessToken currentAccessToken] != nil);
    
}

@end
