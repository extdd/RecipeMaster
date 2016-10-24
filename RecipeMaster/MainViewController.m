//
//  ViewController.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "FacebookManager.h"
#import "Shared.h"

@implementation MainViewController {
    
    MainViewModel *mainViewModel;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    mainViewModel = [[MainViewModel alloc] init];
    mainViewModel.delegate = self;
    
    self.navigationItem.title = @"RecipeMaster";
    self.barUserStatus.title = @"";
    self.barUserStatus.enabled = NO;
    self.barAddButton.enabled = NO;
    
    [self updateUserStatus];
    [self initObservers];
    [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.83 green:0.18 blue:0.18 alpha:1.0]];
    
    //for testing only
    [self.recipeImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapRecipeImage)]];
    
}

- (void)didTapRecipeImage {
    
    //for testing only
    [self showDetails];
    
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    [self.recipeImage updateMask];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.recipeImage updateMask];
    
}

# pragma mark - UI

- (void)updateUI {
    
    NSString *imgURL;
    if (mainViewModel.activeRecipe.images.count > 0) {
        imgURL = [mainViewModel.activeRecipe.images[0] valueForKey:@"url"];
    }
    
    [self.recipeImage setImageURL:imgURL withTitle:mainViewModel.activeRecipe.title];
     
}

- (void)updateUserStatus {
    
    FacebookManager* manager = [FacebookManager sharedManager];

    if ([manager checkToken] && !manager.userName){
        [manager getUserData];
    } else {
        self.barUserStatus.title = manager.fullUserStatus;
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
        detailViewController.detailViewModel.activeRecipe = mainViewModel.activeRecipe;
    
    }
    
}

- (void)showDetails {
 
    [self performSegueWithIdentifier:@"showDetails" sender:self];
    
}

#pragma mark - ACTIONS

- (IBAction)showAlertMenu:(id)sender {
    
    FacebookManager* manager = [FacebookManager sharedManager];
    
    UIAlertController* alert;
    UIAlertAction *itemFacebook;
    UIAlertAction *itemRecipe;
    UIAlertAction *itemCancel;
    
    alert = [UIAlertController alertControllerWithTitle:nil
                                                message:nil
                                         preferredStyle:UIAlertControllerStyleActionSheet];
    
    itemRecipe = [UIAlertAction actionWithTitle:NSLocalizedString(@"GetTheRecipe", nil)
                                          style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action) {
                                            [self showDetails];
                                        }];
    
    if (![manager checkToken]) {
        itemFacebook = [UIAlertAction actionWithTitle:NSLocalizedString(@"LoginToFacebook", nil)
                                                style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction *action) {
                                                  [manager loginFromViewController:self];
                                              }];
    } else {
        itemFacebook = [UIAlertAction actionWithTitle:NSLocalizedString(@"LogoutOfFacebook", nil)
                                                style:UIAlertActionStyleDestructive
                                              handler:^(UIAlertAction *action) {
                                                  [manager logout];
                                              }];
    }
    
    itemCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                          style:UIAlertActionStyleCancel
                                        handler:nil];
    
    [alert addAction:itemRecipe];
    [alert addAction:itemFacebook];
    [alert addAction:itemCancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

# pragma mark - NOTIFICATIONS

- (void)didLoadFacebookUserData:(NSNotification *)notification {
    
    [self updateUserStatus];
    
}

- (void)didLoginFacebook:(NSNotification *)notification {
    
    [self updateUserStatus];
    
}


- (void)didLogoutFacebook:(NSNotification *)notification {

    [self updateUserStatus];
    
}

#pragma mark - DELEGATE

- (void)didLoadData {
    
    self.barAddButton.enabled = YES;
    [self updateUI];
    
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
    
}

@end
