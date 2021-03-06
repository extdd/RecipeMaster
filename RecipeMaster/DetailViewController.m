//
//  DetailViewController.m
//  RecipeMaster
//
//  Created by Krzysztof Ignac on 12.10.2016.
//  Copyright © 2016 EXTENDED. All rights reserved.
//

#import "DetailViewController.h"
#import "FacebookManager.h"
#import "TextCell.h"
#import "GalleryCell.h"

@implementation DetailViewController {
    
    CGFloat headerHeight;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        headerHeight = 50;
        
        self.detailViewModel = [[DetailViewModel alloc] init];
        self.galleryController = [[DetailViewGalleryController alloc] init];
        self.galleryController.detailViewModel = self.detailViewModel;
        self.galleryController.tableView = self.tableView;
        [self initObservers];
        
    }
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = self.detailViewModel.activeRecipe.title;
    self.barUserStatus.title = [FacebookManager sharedManager].fullUserStatus;
    
    [self.tableView registerClass:[TextCell class] forCellReuseIdentifier:@"TextCell"];
    [self.tableView registerClass:[GalleryCell class] forCellReuseIdentifier:@"GalleryCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 160.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.detailViewModel initData];
    
}

#pragma mark - TABLE VIEW DATA SOURCE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.detailViewModel.tableData.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    NSString *cellId = [self.detailViewModel.tableData[indexPath.section] valueForKey:@"id"];
    
    if ([cellId isEqualToString:@"images"]) {
        
        // GALLERY CELL
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryCell" forIndexPath:indexPath];
        
        GalleryCell *galleryCell = (GalleryCell *)cell;
        self.galleryController.gallery = galleryCell.collectionView;

    } else {

        // TEXT CELL
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
        
        TextCell *textCell = (TextCell *)cell;
        textCell.textView.text = [self.detailViewModel getTextForRowData:[self.detailViewModel.tableData[indexPath.section] valueForKey:@"content"]
                                                               withStyle:[self.detailViewModel.tableData[indexPath.section] valueForKey:@"style"]];
        
    }

    [cell updateConstraintsIfNeeded];

    return cell;
    
}

#pragma mark - TABLE VIEW DELEGATE

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = [self.detailViewModel.tableData[indexPath.section] valueForKey:@"id"];
    
    if ([cellId isEqualToString:@"images"] && self.galleryController.gallery) {
        
        [self.galleryController.gallery setCollectionViewDataSourceDelegate:self.galleryController];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = [self.detailViewModel.tableData[indexPath.section] valueForKey:@"id"];
    
    if ([cellId isEqualToString:@"images"] && self.galleryController.gallery) {
        
        [self.galleryController.gallery updateByContainerSize:self.tableView.frame.size];
        return self.galleryController.gallery.size.height;
        
    } else {
        
        return UITableViewAutomaticDimension;
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
    label.textColor = [UIColor darkGrayColor];
    
    NSString *title = NSLocalizedString([[self.detailViewModel.tableData[section] valueForKey:@"id"] capitalizedString], nil);
    label.text = [NSString stringWithFormat:@"%@:", title];
    [label sizeToFit];
    label.frame = CGRectMake(10.0f, ceil(headerHeight/2 - label.frame.size.height/2), label.frame.size.width, label.frame.size.height);
    [view addSubview:label];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return headerHeight;
    
}

#pragma mark - OBSERVERS

- (void)initObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willSaveImageToCameraRoll:)
                                                 name:ImageWillSaveToCameraRollNotification
                                               object:nil];
    
}

#pragma mark - SAVING IMAGE TO CAMERA ROLL

- (void)willSaveImageToCameraRoll:(NSNotification *)notification {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:NSLocalizedString(@"SaveImage", nil)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *itemSave = [UIAlertAction actionWithTitle:NSLocalizedString(@"Yes", nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         [self saveImageToCameraRoll:notification.object];
                                                     }];
    
    UIAlertAction *itemCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
    
    [alert addAction:itemSave];
    [alert addAction:itemCancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)saveImageToCameraRoll:(UIImage *)image {
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(didSaveImageToCameraRollComplete:didFinishSavingWithError:contextInfo:), nil);

}

- (void)didSaveImageToCameraRollComplete:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    NSString *message;
    
    if (error) {
        message = NSLocalizedString(@"SaveImageFail", nil);
    } else {
        message = NSLocalizedString(@"SaveImageSuccess", nil);
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *itemCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Close", nil)
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
    
    [alert addAction:itemCancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
