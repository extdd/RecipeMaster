//
//  MainViewModel.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "MainViewModel.h"
#import "Networking.h"
#import "Shared.h"

@implementation MainViewModel {
    
    NSString *requestURL;

}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        requestURL = @"http://mooduplabs.com/test/info.php";
        [self loadRemoteData];
        
    }
    return self;
    
}

- (void)setActiveRecipeByData:(NSDictionary *)data {
    
    self.activeRecipe = [[Recipe alloc] init];
    self.activeRecipe.title = (NSString *)[data valueForKey:@"title"];
    self.activeRecipe.descriptionText = (NSString *)[data valueForKey:@"description"];
    self.activeRecipe.ingredients = (NSArray *)[data valueForKey:@"ingredients"];
    self.activeRecipe.preparing = (NSArray *)[data valueForKey:@"preparing"];
    self.activeRecipe.images = (NSArray *)[data valueForKey:@"imgs"];

}

# pragma mark - REMOTE DATA

- (void)loadRemoteData {
    
    [Networking loadDataByURL:requestURL complete:^(id data) {
        if (data) {
            
            self.recipesData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self setActiveRecipeByData:self.recipesData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:DataLoadCompleteNotification object:nil];
        }
    }];
    
}

@end
