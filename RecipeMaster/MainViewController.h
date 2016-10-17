//
//  ViewController.h
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedImage.h"

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barUserStatus;
@property (weak, nonatomic) IBOutlet RoundedImage *recipeImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barAddButton;

- (IBAction)showAlertMenu:(id)sender;

@end
