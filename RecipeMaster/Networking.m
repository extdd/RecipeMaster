//
//  Networking.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 13.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "Networking.h"
#import "AFNetworking.h"

@implementation Networking

+ (void)loadDataByURL:(NSString *)url complete:(void (^)(id data))complete {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseData, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            complete(nil);
        } else {
            //NSLog(@"%@ %@", response, responseData);
            complete(responseData);
        }
    }];
    
    [dataTask resume];
    
}

+ (void)loadImageByURL:(NSString *)url complete:(void (^)(UIImage *image))complete {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseImage, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            complete(nil);
        } else {
            //NSLog(@"%@ %@", response, responseImage);
            complete(responseImage);
            
        }
    }];
    
    [dataTask resume];
    
}

@end
