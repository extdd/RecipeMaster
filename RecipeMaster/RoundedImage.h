//
//  RecipeThumb.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 13.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundedImage : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;

- (void)initUI;
- (void)setImageURL:(NSString *)url withTitle:(NSString *)title;
- (void)updateMask;
- (void)hide;
- (void)show;

@end
