//
//  DetailViewController.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewModel.h"
#import "DetailViewGalleryController.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barUserStatus;

@property (strong, nonatomic) DetailViewModel *detailViewModel;
@property (strong, nonatomic) DetailViewGalleryController *galleryController;

@end
