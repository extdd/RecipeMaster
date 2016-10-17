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

- (void)setTextContentWithStyle:(NSString *)style textContent:(id)content {

    if ([style isEqualToString:TextContentStylePlain]) {
  
        self.textView.text = (NSString *)content;
        
    } else  {
        
        NSArray *items = (NSArray *)content;
        NSString *contentString = [[NSMutableString alloc] init];
        int i = 1;
        
        for (NSString *item in items) {
            
            if ([style isEqualToString:TextContentStyleNumbered]) {
                
                contentString = [contentString stringByAppendingString:[NSString stringWithFormat:@"%i. %@", i, item]];
                if (i < items.count - 1) {
                    //extra new line between every items only for a numbered list
                    contentString = [contentString stringByAppendingString:@"\n\n"];
                }
                
            } else {
                
                contentString = [contentString stringByAppendingString:[NSString stringWithFormat:@"- %@", item]];
                if (i < items.count - 1) {
                    contentString = [contentString stringByAppendingString:@"\n"];
                }
            }
        
            i++;
            
        }
        
        self.textView.text = contentString;
        
    }
    
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
