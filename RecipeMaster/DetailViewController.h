//
//  DetailViewController.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewModel.h"
#import "FacebookManager.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barUserStatus;

@property (strong, nonatomic) DetailViewModel *detailViewModel;
@property (weak, nonatomic) FacebookManager *facebookManager;

@end
