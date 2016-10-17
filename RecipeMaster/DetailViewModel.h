//
//  DetailViewModel.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"

@interface DetailViewModel : NSObject

@property (strong, nonatomic) Recipe *activeRecipe;
@property (strong, nonatomic) NSMutableArray *tableData;

- (void)initData;

@end
