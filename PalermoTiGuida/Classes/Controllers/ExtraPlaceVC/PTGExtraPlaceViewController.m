//
//  PTGExtraPlaceViewController.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGExtraPlaceViewController.h"
#import "PTGBreadcrumbView.h"
#import "PTGMapViewController.h"
@interface PTGExtraPlaceViewController ()

@end

@implementation PTGExtraPlaceViewController
@synthesize parentCategory;
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
    [self.parentCategory loadPlacesWithSuccess:^(NSArray *products) {
        dispatch_async(dispatch_get_main_queue(), ^{
            dataSource = [NSMutableArray arrayWithArray:products];
            [extraPlaceTableView reloadData];
            [self removeActivityIndicator];
        });
    } failure:^(NSString *requestUrl, NSError *error) {
        [self removeActivityIndicator];
        [self showAllertMessageForErro:error];
    }];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    PTGBreadcrumbView *brView = [PTGBreadcrumbView setupViews];
    [brView setXOffset:ARROW_MARGINS];
    if([self.breadcrumbs count] > 1)  {
        [brView setFontSize:kFontSizeSmall];
    }
    else {
        [brView setFontSize:kFontSizeLarge];
    }
    [brView setItems:self.breadcrumbs];
    [self.view addSubview:brView];
    extraPlaceTableView.rowHeight = 64.f;
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
    PTGExtraCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if(!cell) {
        cell = [PTGExtraCell setupViews];
        cell.delegate = self;
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
    cell.index = indexPath.row;
    [cell setupWithPlace:[dataSource objectAtIndex:indexPath.row]];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(void)shouldShowOnMapPlaceAtIndex:(NSInteger)index {
    PTGMapViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PTGMapViewController class])];
    controller.places = @[[dataSource objectAtIndex:index]];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
