//
//  DetailViewModel.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "DetailViewModel.h"
#import "Shared.h"

@implementation DetailViewModel

- (void)initData {
    
    self.tableData = [[NSMutableArray alloc] init];
    
    [self.tableData addObject:@{@"id": self.activeRecipe.title.lowercaseString,
                           @"content": self.activeRecipe.descriptionText,
                           @"style": TextContentStylePlain}];
    
    [self.tableData addObject:@{@"id": @"ingredients",
                           @"content": self.activeRecipe.ingredients,
                           @"style": TextContentStyleDashed}];
    
    [self.tableData addObject:@{@"id": @"preparing",
                           @"content": self.activeRecipe.preparing,
                           @"style": TextContentStyleNumbered}];
    
    [self.tableData addObject:@{@"id": @"images",
                           @"content": self.activeRecipe.images}];
    
}

@end
