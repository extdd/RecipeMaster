//
//  DetailViewController.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.detailViewModel = [[DetailViewModel alloc] init];
    }
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = self.detailViewModel.activeRecipe.title;
    self.barUserStatus.title = self.facebookManager.fullUserStatus;
    
}

@end
