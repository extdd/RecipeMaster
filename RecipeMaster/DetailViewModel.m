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

- (NSString *)getTextForRowData:(id)data withStyle:(NSString *)style {
    
    if ([style isEqualToString:TextContentStylePlain]) {
        
        return (NSString *)data;
        
    } else  {
        
        NSArray *items = (NSArray *)data;
        NSString *text = [[NSMutableString alloc] init];
        int i = 1;
        
        for (NSString *item in items) {
            
            if ([style isEqualToString:TextContentStyleNumbered]) {
                
                text = [text stringByAppendingString:[NSString stringWithFormat:@"%i. %@", i, item]];
                if (i < items.count - 1) {
                    //extra new line between every items only for a numbered list
                    text = [text stringByAppendingString:@"\n\n"];
                }
                
            } else {
                
                text = [text stringByAppendingString:[NSString stringWithFormat:@"- %@", item]];
                if (i < items.count - 1) {
                    text = [text stringByAppendingString:@"\n"];
                }
            }
            
            i++;
            
        }
        
        return text;
        
    }
    
}

@end
