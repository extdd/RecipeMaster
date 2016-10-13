//
//  Networking.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 13.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Networking : NSObject

+ (void)loadDataByURL:(NSString *)url complete:(void (^)(id data))complete;
+ (void)loadImageByURL:(NSString *)url complete:(void (^)(UIImage *image))complete;

@end
