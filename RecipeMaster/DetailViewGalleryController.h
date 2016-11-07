//
//  DetailViewGalleryController.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 07.11.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//
//  Extra class to separate GalleryCollectionView data source & delegate methods
//  from DetailViewController implementation file (with TableView data source & delegate).
//  GalleryCollectionView is embeded in a TableView cell.
//

#import <Foundation/Foundation.h>
#import "DetailViewModel.h"
#import "GalleryCell.h"

@interface DetailViewGalleryController : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) GalleryCollectionView *gallery;
@property (weak, nonatomic) DetailViewModel *detailViewModel;

@end
