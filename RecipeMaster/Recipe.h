//
//  Recipe.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descriptionText;
@property (strong, nonatomic) NSArray *ingredients;
@property (strong, nonatomic) NSArray *preparing;
@property (strong, nonatomic) NSMutableArray *images;

@end
