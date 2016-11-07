//
//  GalleryCollectionView.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 07.11.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "GalleryCollectionView.h"
#import "GalleryCollectionViewCell.h"
#import "Networking.h"
#import "Shared.h"

@implementation GalleryCollectionView {
    
    UICollectionViewFlowLayout *flowLayout;
    CGFloat cellWidth; //calculated by screen size, columns number & horizontal spacing
    CGFloat cellHeight; //calculated by cell width
    
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        [self registerClass:[GalleryCollectionViewCell class] forCellWithReuseIdentifier:@"GalleryCollectionViewCell"];
        
    }
    
    return self;
    
}

- (void)updateByContainerSize:(CGSize)containerSize {
    
    cellWidth = ceil((containerSize.width - self.cellHorizontalSpacing*(self.colsNum+1))/self.colsNum);
    cellHeight = floor(cellWidth/1.5);
    
    self.frame = CGRectMake(0, 0, containerSize.width, cellHeight + self.cellVerticalSpacing*2);
    self.size = CGSizeMake(self.frame.size.width, self.frame.size.height + self.paddingBottom);
    
    [self.collectionViewLayout invalidateLayout];
    
}

- (CGSize)cellSize {
    
    return CGSizeMake(cellWidth, cellHeight);
    
}

- (CGFloat)colsNum { //number of visible columns in collection view
    
    BOOL isPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
    
    if (isPortrait) {
        return 2;
    } else {
        return 4;
    }
    
}

- (void)setCollectionViewDataSourceDelegate:(id)dataSourceDelegate {
    
    self.dataSource = dataSourceDelegate;
    self.delegate = dataSourceDelegate;
    [self reloadData];
    
}

@end

