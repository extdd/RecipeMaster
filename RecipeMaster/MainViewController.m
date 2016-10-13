//
//  ViewController.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"
#import "DetailViewController.h"
#import "FacebookManager.h"
#import "Shared.h"

@implementation MainViewController {
    
    MainViewModel *mainViewModel;
    FacebookManager *facebookManager;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    mainViewModel = [[MainViewModel alloc] init];
    facebookManager = [[FacebookManager alloc] init];

    self.barUserStatus.title = @"";
    self.barUserStatus.enabled = NO;
    
    [self updateUserStatus];
    [self initObservers];
    [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.83 green:0.18 blue:0.18 alpha:1.0]];
    
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    [self.recipeImage updateLayoutSubviews];

}

# pragma mark - UI

- (void)updateUI {
    
    NSString *imgURL;
    if (mainViewModel.activeRecipe.images.count > 0) {
        imgURL = mainViewModel.activeRecipe.images[0];
    }
    
    [self.recipeImage setImageURL:imgURL withTitle:mainViewModel.activeRecipe.title];
    
}

- (void)updateUserStatus {
    
    if ([facebookManager checkToken] && !facebookManager.userName) {
        [facebookManager getUserData];
    } else {
        self.barUserStatus.title = facebookManager.fullUserStatus;
    }
    
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
    
}

#pragma mark - SEGUE

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetails"]){
        
        DetailViewController *detailViewController = (DetailViewController *)[segue destinationViewController];
        detailViewController.facebookManager = facebookManager;
        detailViewController.detailViewModel.activeRecipe = mainViewModel.activeRecipe;
    
    }
    
}

- (void)showDetails {
 
    [self performSegueWithIdentifier:@"showDetails" sender:self];
    
}

#pragma mark - ACTIONS

- (IBAction)showAlertMenu:(id)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *itemRecipe = [UIAlertAction actionWithTitle:@"Get the recipe" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self showDetails];
                                                          }];
    
    UIAlertAction *itemFacebook;
    if (![facebookManager checkToken]) {
        itemFacebook = [UIAlertAction actionWithTitle:@"Log in to Facebook" style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action) {
                                              [facebookManager loginFromViewController:self];
                                          }];
    } else {
        itemFacebook = [UIAlertAction actionWithTitle:@"Log out of Facebook" style:UIAlertActionStyleDestructive
                                          handler:^(UIAlertAction * action) {
                                              [facebookManager logout];
                                              [self updateUserStatus];
                                          }];
    }
    
    UIAlertAction *itemCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:itemRecipe];
    [alert addAction:itemFacebook];
    [alert addAction:itemCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

# pragma mark - NOTIFICATIONS

- (void)didLoadData:(NSNotification *)notification {
    
    //NSLog(@"didLoadData %@:", mainViewModel.recipesData);
    [self updateUI];
    
}


- (void)didLoadFacebookUserData:(NSNotification *)notification {
    
    //NSLog(@"didLoadFacebookUserData %@", notification.object);
    [self updateUserStatus];
    
}

- (void)didLoginFacebook:(NSNotification *)notification {
    
    //NSLog(@"didLoginFacebook");
    [self updateUserStatus];
    
}


- (void)didLogoutFacebook:(NSNotification *)notification {
    
    //NSLog(@"didLogoutFacebook");
    [self updateUserStatus];
    
}

#pragma mark - OBSERVERS

- (void)initObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didLoadFacebookUserData:)
                                                 name:FacebookUserDataLoadCompleteNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didLoginFacebook:)
                                                 name:FacebookLoginNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didLogoutFacebook:)
                                                 name:FacebookLogoutNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didLoadData:)
                                                 name:DataLoadCompleteNotification
                                               object:nil];
    
}

@end
