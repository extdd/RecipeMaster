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

- (void)addRecipeByDictionary:(NSDictionary *)data {
    
    Recipe *recipe = [[Recipe alloc] init];
    recipe.title = (NSString *)[data valueForKey:@"title"];
    recipe.descriptionText = (NSString *)[data valueForKey:@"description"];
    recipe.ingredients = (NSArray *)[data valueForKey:@"ingredients"];
    recipe.preparing = (NSArray *)[data valueForKey:@"preparing"];
    recipe.images = [[NSMutableArray alloc] init];
    
    NSArray *imgs = (NSArray *)[data valueForKey:@"imgs"];
    
    for (NSString *url in imgs) {
        [recipe.images addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:url, @"url", [[NSData alloc] init], @"data", nil]];
    }
    
    self.activeRecipe = recipe;
}

# pragma mark - REMOTE DATA

- (void)loadRemoteData {
    
    [Networking loadDataByURL:requestURL complete:^(id data) {
        if (data) {
            
            [self addRecipeByDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
            
            if (self.delegate) {
                [self.delegate didLoadData];
            }
              
        }
    }];
    
}

@end
