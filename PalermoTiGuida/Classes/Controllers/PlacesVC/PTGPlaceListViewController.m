//
//  PTGPlaceListViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGPlaceListViewController.h"
#import "PTGPlaceCell.h"
#import "PTGPlaceDetailsViewController.h"
@interface PTGPlaceListViewController ()

@end

@implementation PTGPlaceListViewController
@synthesize downloadedProducts;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addActivityIndicator];
    if(VALID_NOTEMPTY(self.downloadedProducts, NSArray)) {
        dataSource = [NSArray arrayWithArray:self.downloadedProducts];
        self.downloadedProducts = nil;
        [subcategoryTableView reloadData];
        [self shouldHideAllViews:NO];
        [self removeActivityIndicator];
    }
    else {
        [self.parentCategory loadPlacesWithSuccess:^(NSArray *products) {
            dispatch_async(dispatch_get_main_queue(), ^{
                dataSource = [NSArray arrayWithArray:products];
                [subcategoryTableView reloadData];
                [self shouldHideAllViews:NO];
                [self removeActivityIndicator];
            });
        } failure:^(NSString *requestUrl, NSError *error) {
            [self removeActivityIndicator];
            [self showAllertMessageForErro:error];
        }];
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    subcategoryTableView.rowHeight = 64.f;
    [subcategoryTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"reuseIdentifeier";
    PTGPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if(!cell) {
        cell = [PTGPlaceCell setupViews];
    }
    if(indexPath.row == 0) {
        [cell isFirstCell];
    }
    else if(indexPath.row == [dataSource count] - 1 ) {
        [cell isLastCell];
    }
    else {
        [cell isMiddleCell];
    }
    [cell setupWithPlace:[dataSource objectAtIndex:indexPath.row]];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((PTGPlaceDetailsViewController*)segue.destinationViewController).place = sender;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailsSegue" sender:[dataSource objectAtIndex:indexPath.row]];
}

@end
