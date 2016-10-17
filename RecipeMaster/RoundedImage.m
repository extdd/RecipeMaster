//
//  RecipeThumb.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 13.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "RoundedImage.h"
#import "Networking.h"

@implementation RoundedImage {
    
    NSString *imageTitle;
    CGFloat imageAlpha;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        imageAlpha = 0.5f;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
    }
    return self;
    
}

# pragma mark - LOADING IMAGE

- (void)setImageURL:(NSString *)url withTitle:(NSString *)title {
    
    imageTitle = title;
    [self initUI];
    
    [Networking loadImageByURL:url complete:^(UIImage *image) {
        
        if (image) {
            self.imageView.alpha = 0;
            self.imageView.image = image;
            [self show];
            
        }
        
    }];
    
}

# pragma mark - SHOW / HIDE

- (void)show {
    
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.imageView.alpha = imageAlpha;
    } completion:nil];
    
}

- (void)hide {
    
    self.imageView.alpha = 0;
    
}

# pragma mark - UI

- (void)initUI {
    
    [self initImageView];
    [self initTitleLabel];
    
    self.hidden = NO;
    
}

- (void)initTitleLabel {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = imageTitle;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:40.0f weight:UIFontWeightBold];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.minimumScaleFactor = 0.6f;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.9f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.25f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0]];
    
}

- (void)initImageView {
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.alpha = imageAlpha;
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

- (void)updateMask {
    
    //NSLog(@"CIRCLE updateLayoutSubviews: %fx%f", self.frame.size.width, self.frame.size.height);
    
    CGFloat circleSize;
    (self.frame.size.width > self.frame.size.height) ? (circleSize = self.frame.size.width) : (circleSize = self.frame.size.height);
    self.layer.mask = [self getCircleMaskWithSize:circleSize];
    
}

- (CAShapeLayer *)getCircleMaskWithSize:(CGFloat)size {
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *circularPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size/2, size/2)
                                                                radius:size/2
                                                            startAngle:0
                                                              endAngle:2.0f*M_PI
                                                             clockwise:YES];
    
    circle.path = circularPath.CGPath;
    circle.fillColor = [UIColor blackColor].CGColor;
    circle.strokeColor = [UIColor blackColor].CGColor;
    circle.lineWidth = 0;
    
    return circle;
    
}

@end
