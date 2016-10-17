//
//  ThumbCell.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 14.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "GalleryImageCell.h"

@implementation GalleryImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initImageView];
        
    }
    return self;
    
}

- (void)initImageView {
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.imageView];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0]];

}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    self.imageView.image = nil;
    
}

@end
