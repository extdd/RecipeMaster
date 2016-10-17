//
//  TextTableCell.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 15.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shared.h"

@interface TextCell : UITableViewCell

- (void)setTextContentWithStyle:(NSString *)style textContent:(id)content;

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) id textContent;
@property (strong, nonatomic) NSString *textContentStyle;

@end
