//
//  GalleryCollectionView.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 07.11.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryCollectionView : UICollectionView

@property CGFloat cellHorizontalSpacing;
@property CGFloat cellVerticalSpacing;
@property CGFloat paddingBottom;
@property CGSize size;

- (void)updateByContainerSize:(CGSize)containerSize;
- (void)setCollectionViewDataSourceDelegate:(id)dataSourceDelegate;
- (CGSize)cellSize;

@end
