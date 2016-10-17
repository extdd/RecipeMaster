//
//  ImagesTableCell.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 15.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "GalleryCell.h"
#import "GalleryImageCell.h"
#import "Networking.h"
#import "Shared.h"

@implementation GalleryCell {
    
    int colsNum; //number of visible columns in collection view
    CGFloat horizontalSpacing;
    CGFloat verticalSpacing;
    CGFloat cellWidth; //calculated by screen size, colsNum & horizontalSpacing
    CGFloat cellHeight; //calculated by cellWidth
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initCollectionView];
        
    }
    return self;

}

- (void)initCollectionView {
    
    horizontalSpacing = 20;
    verticalSpacing = 10;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, horizontalSpacing, 0, horizontalSpacing);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = horizontalSpacing;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[GalleryImageCell class] forCellWithReuseIdentifier:@"GalleryImageCell"];

    [self.contentView addSubview:self.collectionView];

}

#pragma mark - COLLECTION VIEW LAYOUT

- (CGSize)updateSizeByWidth:(CGFloat)width {
    
    CGFloat height;
    BOOL isPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
    
    if (isPortrait) {
        colsNum = 2;
    } else {
        colsNum = 4;
    }
    
    cellWidth = ceil((width - horizontalSpacing*(colsNum+1))/colsNum);
    cellHeight = floor(cellWidth/1.5);
    height = cellHeight + verticalSpacing*2;

    self.collectionView.frame = CGRectMake(self.contentView.bounds.origin.x,
                                           self.contentView.bounds.origin.y,
                                           width,
                                           height);
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    CGFloat extraBottomSpacing = horizontalSpacing - verticalSpacing;
    return CGSizeMake(width, height + extraBottomSpacing);

}

#pragma mark - COLLECTION VIEW DELEGATE

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GalleryImageCell *cell = (GalleryImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.imageView.image) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageWillSaveToCameraRollNotification object:cell.imageView.image];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GalleryImageCell *cell = (GalleryImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.alpha = 0.5f;
    cell.backgroundColor = [UIColor blackColor];
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GalleryImageCell *cell = (GalleryImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.alpha = 1.0f;
    cell.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - COLLECTION VIEW DATA SOURCE

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.images.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GalleryImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GalleryImageCell" forIndexPath:indexPath];
    
    NSString *imageURL = [self.images[indexPath.item] valueForKey:@"url"];
    NSData *imageData = [self.images[indexPath.item] valueForKey:@"data"];

    if (imageData.length > 0) {

        cell.imageView.alpha = 1.0f;
        cell.imageView.image = [[UIImage alloc] initWithData:imageData];

    } else {

        [Networking loadDataByURL:imageURL complete:^(id data) {

            if (data) {
                
                [self.images[indexPath.item] setValue:data forKey:@"data"];

                cell.imageView.image = [[UIImage alloc] initWithData:data];
                cell.imageView.alpha = 0;

                [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.imageView.alpha = 1.0f;
                } completion:nil];
        
            }}];
         
    }

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(cellWidth, cellHeight);
    
}

@end
