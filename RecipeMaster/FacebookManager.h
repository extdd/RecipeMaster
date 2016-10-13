//
//  Facebook.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FacebookManager : NSObject

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *fullUserStatus;

- (void)loginFromViewController:(UIViewController *)viewController;
- (void)logout;
- (void)getUserData;
- (BOOL)checkToken;

@end
