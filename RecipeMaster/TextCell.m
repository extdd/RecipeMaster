//
//  TextTableCell.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 15.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell {

    CGFloat horizontalSpacing;
    CGFloat verticalSpacing;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        horizontalSpacing = 20.0f;
        verticalSpacing = 0;
        self.backgroundColor = [UIColor clearColor];
        [self initTextView];

    }
    
    return self;
    
}

- (void)initTextView {
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.textColor = [UIColor grayColor];
    self.textView.editable = NO;
    self.textView.text = @"";
    self.textView.font = [UIFont systemFontOfSize:16.0f];
    self.textView.scrollEnabled = NO;
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textView sizeToFit];
    
    [self addSubview:self.textView];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0f
                                                      constant:-horizontalSpacing*2.0f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0f
                                                      constant:-verticalSpacing*2.0f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0]];

}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    self.textView.text = @"";
    
}

@end
