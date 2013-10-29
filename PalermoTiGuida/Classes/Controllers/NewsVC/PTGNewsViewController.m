//
//  PTGNewsViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGNewsViewController.h"
#import "PTGCategoryCell.h"
#import "PTGNewsCategory.h"
#import "PTGBreadcrumbView.h"
#import "PTGNewsListViewController.h"
#import "PTGBaseTabBarViewController.h"

@interface PTGNewsViewController ()

@end

@implementation PTGNewsViewController

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
    normalCategories = [NSMutableArray new];
    specialCategories = [NSMutableArray new];
    PTGBreadcrumbView *brView = [PTGBreadcrumbView setupViews];
    [brView setXOffset:ARROW_MARGINS];
    [brView setFontSize:kFontSizeLarge];
    [brView setItems:@[NSLocalizedString(@"News ed Eventi", @"")]];
    [self.view addSubview:brView];

    NSArray *allFirstLevel = [PTGNewsCategory firstLevel];
    for(PTGNewsCategory *category in allFirstLevel) {
        if([category.categoryType integerValue] == 1) {
            [normalCategories addObject:category];
        }
        else {
            [specialCategories addObject:category];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [newsTableView reloadData];
}


#pragma mark - TableView delegate & datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([specialCategories count] == 0) {
        return 1;
    }
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, tableView.sectionHeaderHeight)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([specialCategories count] == 0) {
        return [normalCategories count];
    }
    else {
        if(section == 0){
            return [normalCategories count];
        }
        return [specialCategories count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"categoryCell";
    PTGCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell =[ PTGCategoryCell setupViews];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.countButton setBackgroundImage:[UIImage imageNamed:@"news_badge"] forState:UIControlStateNormal];
    }
    if(indexPath.row == 0) {
        [cell isFirstCell];
    }
    else if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        [cell isLastCell];
    }
    else {
        [cell isMiddleCell];
    }
    PTGNewsCategory *category = nil;
    if(indexPath.section == 0) {
        category = [normalCategories objectAtIndex:indexPath.row];
    }
    else {
        category = [specialCategories objectAtIndex:indexPath.row];
    }
    NSInteger items = [category.newNews integerValue];
    
    if(items != 0) {
        cell.countButton.hidden = NO;
        [cell.countButton setTitle: [NSString stringWithFormat:@"%d", items] forState:UIControlStateNormal];
    }
    else {
        cell.countButton.hidden = YES;
    }
    
    cell.categoryNameLabel.text = category.name;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PTGNewsListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PTGNewsListViewController"];
    PTGNewsCategory *category = nil;
    if(indexPath.section == 0) {
        category = [normalCategories objectAtIndex:indexPath.row];
    }
    else {
        category = [specialCategories objectAtIndex:indexPath.row];
    }
    category.newNews = [NSNumber numberWithInteger:0];
    [category.managedObjectContext saveToPersistentStoreAndWait];
    [((PTGBaseTabBarViewController *)self.tabBarController) updateNewsBadge];
    vc.breadCrumbs = @[NSLocalizedString(@"News", @""), category.name];
    vc.parentCategory = category;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
