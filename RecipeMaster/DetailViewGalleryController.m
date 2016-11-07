//
//  DetailViewGalleryController.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 07.11.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//
//  Extra class to separate GalleryCollectionView data source & delegate methods
//  from DetailViewController implementation file (with TableView data source & delegate).
//  GalleryCollectionView is embeded in a TableView cell.
//

#import "DetailViewGalleryController.h"
#import "GalleryCollectionViewCell.h"
#import "Networking.h"
#import "Shared.h"

@implementation DetailViewGalleryController

#pragma mark - COLLECTION VIEW DATA SOURCE

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.detailViewModel.activeRecipe.images.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GalleryCollectionViewCell" forIndexPath:indexPath];
    
    NSString *imageURL = [self.detailViewModel.activeRecipe.images[indexPath.item] valueForKey:@"url"];
    NSData *imageData = [self.detailViewModel.activeRecipe.images[indexPath.item] valueForKey:@"data"];
    
    if (imageData.length > 0) {
        
        cell.imageView.alpha = 1.0f;
        cell.imageView.image = [[UIImage alloc] initWithData:imageData];
        
    } else {
        
        [Networking loadDataByURL:imageURL complete:^(id data) {
            
            if (data) {
                
                [self.detailViewModel.activeRecipe.images[indexPath.item] setValue:data forKey:@"data"];
                
                cell.imageView.image = [[UIImage alloc] initWithData:data];
                cell.imageView.alpha = 0;
                
                [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.imageView.alpha = 1.0f;
                } completion:nil];
                
            }}];
        
    }
    
    return cell;
    
}

#pragma mark - COLLECTION VIEW DELEGATE

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GalleryCollectionViewCell *cell = (GalleryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.imageView.image) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageWillSaveToCameraRollNotification object:cell.imageView.image];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GalleryCollectionViewCell *cell = (GalleryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.alpha = 0.5f;
    cell.backgroundColor = [UIColor blackColor];
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GalleryCollectionViewCell *cell = (GalleryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.alpha = 1.0f;
    cell.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - COLLECTION VIEW FLOW LAYOUT DELEGATE

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return self.gallery.cellSize;
    
}

@end

