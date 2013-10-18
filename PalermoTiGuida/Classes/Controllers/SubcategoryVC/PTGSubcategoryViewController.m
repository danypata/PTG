//
//  PTGSubcategoryViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGSubcategoryViewController.h"
#import "PTGCategoryCell.h"
#import "PTGBreadcrumbView.h"
#import "UIImageView+AFNetworking.h"
#import "PTGPlaceListViewController.h"

@interface PTGSubcategoryViewController ()

@end

@implementation PTGSubcategoryViewController
@synthesize parentCategory;
@synthesize breadcrumbs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self shouldHideAllViews:YES];
    [self addActivityIndicator];
    
    if(![self isKindOfClass:[PTGPlaceListViewController class]]) {
        [self.parentCategory loadSubcategoriesFromServerWithSucces:^(NSArray *subcategories) {
            dataSource = [NSArray arrayWithArray:subcategories];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeActivityIndicator];
                [self shouldHideAllViews:NO];
                [subcategoryTableView reloadData];
            });
            
        } failureBlock:^(NSString *requestUrl, NSError *error) {
            [self showAllertMessageForErro:error];
            ZLog(@"%@", error);
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    subcategoryTableView.rowHeight = 45;
    if([self.parentCategory.imageType integerValue] == 1) {
        containerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    else {
        [headerImageView removeFromSuperview];
        containerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    PTGBreadcrumbView *brView = [PTGBreadcrumbView setupViews];
    [brView setXOffset:ARROW_MARGINS];
    [containerView addSubview:brView];
    CGRect frame =containerView.frame;
    frame.origin.y = brView.frame.size.height + 5;
    frame.size.height = self.view.frame.size.height - brView.frame.size.height - brView.frame.origin.y - 2*5;
    subcategoryTableView.frame = frame;
    if([self.breadcrumbs count] > 1)  {
        [brView setFontSize:kFontSizeSmall];
    }
    else {
        [brView setFontSize:kFontSizeLarge];
    }
    [brView setItems:self.breadcrumbs];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    headerImageView = nil;
    containerView = nil;
    subcategoryTableView = nil;
    [super viewDidUnload];
}

-(void)shouldHideAllViews:(BOOL)hide {
    headerImageView.hidden = hide;
    containerView.hidden = hide;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    PTGCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell =[ PTGCategoryCell setupViews];
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
    PTGCategory *currentCategory = [dataSource objectAtIndex:indexPath.row];
    if([currentCategory.subcategoryCount integerValue] != 0) {
        cell.countLabel.text = [currentCategory.subcategoryCount stringValue];
    }
    else {
        cell.countLabel.text = [currentCategory.placesCount stringValue];
    }
    cell.categoryNameLabel.text = currentCategory.name;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PTGCategory *currentCategory = [dataSource objectAtIndex:indexPath.row];
    if([currentCategory.type integerValue] == 0) {
        PTGSubcategoryViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
        vc.parentCategory = currentCategory;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        [self performSegueWithIdentifier:@"placesSegue" sender:currentCategory];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSMutableArray *newBr = [NSMutableArray arrayWithArray:self.breadcrumbs];
    if([segue.identifier isEqualToString:@"placesSegue"]) {
        PTGPlaceListViewController *vc = segue.destinationViewController;
        [newBr addObject:((PTGCategory *)sender).name];
        vc.parentCategory = sender;
        vc.breadcrumbs = newBr;
    }
}
@end
