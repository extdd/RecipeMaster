//
//  GalleryCell.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 15.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "GalleryCell.h"

@implementation GalleryCell {
    
    CGFloat horizontalSpacing;
    CGFloat verticalSpacing;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        horizontalSpacing = 20.0f;
        verticalSpacing = 10.0f;

        self.backgroundColor = [UIColor whiteColor];
        [self initCollectionView];
        
    }
    
    return self;
    
}

- (void)initCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, horizontalSpacing, 0, horizontalSpacing);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = horizontalSpacing;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(10, 10);
    
    self.collectionView = [[GalleryCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.cellHorizontalSpacing = horizontalSpacing;
    self.collectionView.cellVerticalSpacing = verticalSpacing;
    self.collectionView.paddingBottom = horizontalSpacing - verticalSpacing;
    
    [self.contentView addSubview:self.collectionView];
    
}

@end

