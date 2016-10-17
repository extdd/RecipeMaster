//
//  ImagesTableCell.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 15.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCell.h"

@interface GalleryCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *images;

- (CGSize)updateSizeByWidth:(CGFloat)width;

@end
