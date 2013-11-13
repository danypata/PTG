//
//  PTGNewsListViewController.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 27/10/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGNewsListViewController.h"
#import "PTGBreadcrumbView.h"
#import "PTGNewsListCell.h"
#import "PTGCategoryCell.h"
#import "PTGNewsDetailsViewController.h"
#import "PTGBaseTabBarViewController.h"

@interface PTGNewsListViewController ()

@end

@implementation PTGNewsListViewController
@synthesize parentCategory;
@synthesize breadCrumbs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PTGBreadcrumbView *br = [PTGBreadcrumbView setupViews];
    [br setXOffset:ARROW_MARGINS];
    [br setFontSize:kFontSizeSmall];
    [br setItems:self.breadCrumbs];
    [self.view addSubview:br];
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        newsCellHeight = 62.f;
        childCellHeight = 50.f;
    }
    else {
        newsCellHeight = 123.f;
        childCellHeight = 92.f;
    }
    if(VALID(self.parentCategory, PTGNewsCategory)) {
        [self.parentCategory loadNewsWithSuccess:^(BOOL done) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [newsTableView reloadData];
            });
        } failure:^(NSError *error) {
            
        }];
    }
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    ZLog(@"Gone");
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [newsTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.parentCategory.children count] == 0){
        return 1;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.parentCategory.children count] == 0) {
        return [self.parentCategory.news count];
    }
    else {
        if(section == 0) {
            return [self.parentCategory.children count];
        }
        else {
            return [self.parentCategory.news count];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.parentCategory.children count] == 0) {
        return newsCellHeight;
    }
    else {
        if(indexPath.section == 0) {
            return childCellHeight;
        }
        else {
            return newsCellHeight;
        }
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, newsTableView.sectionHeaderHeight)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *newsCellIdentifier = @"newsCell";
    static NSString *childCell = @"childCell";
    if([self.parentCategory.children count] == 0) {
        PTGNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
        if(!cell) {
            cell = [PTGNewsListCell setupViews];
            [cell setupFonts];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
        }
        [cell setupWithNews:[[self.parentCategory.news allObjects] objectAtIndex:indexPath.row]];
        [self checkNewsCell:cell forIndexPath:indexPath];
        return cell;
    }
    else {
        if(indexPath.section == 0) {
            PTGCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:childCell];
            if(!cell) {
                cell = [PTGCategoryCell setupViews];
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];

            }
            PTGNewsCategory *category = [[self.parentCategory.children allObjects] objectAtIndex:indexPath.row];
            NSInteger items = [category.newNews integerValue];
            
            if(items != 0) {
                cell.countButton.hidden = NO;
                [cell.countButton setTitle: [NSString stringWithFormat:@"%d", items] forState:UIControlStateNormal];
            }
            else {
                cell.countButton.hidden = YES;
            }
            if([category.newNews integerValue] == 0) {
                cell.countButton.hidden = YES;
            }
            else {
                cell.countButton.hidden = NO;
                cell.countButton.selected = NO;
                cell.countButton.enabled = NO;
            }
            cell.categoryNameLabel.text = category.name;
            [self checkCategoryCell:cell forIndexPath:indexPath];
            return cell;
        }
        else {
            PTGNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
            if(!cell) {
                cell = [PTGNewsListCell setupViews];
                [cell setupFonts];
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];
            }
            [cell setupWithNews:[[self.parentCategory.news allObjects] objectAtIndex:indexPath.row]];
            [self checkNewsCell:cell forIndexPath:indexPath];
            return cell;
        }
    }
}


-(void)checkCategoryCell:(PTGCategoryCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        [cell isFirstCell];
    }
    else if(indexPath.row == [newsTableView numberOfRowsInSection:indexPath.section] - 1) {
        [cell isLastCell];
    }
    else {
        [cell isMiddleCell];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.parentCategory.children count] == 0) {
        self.parentCategory.newNews = [NSNumber numberWithInt:0];
        [self.parentCategory.managedObjectContext saveToPersistentStoreAndWait];
        PTGNews *news = [[self.parentCategory.news allObjects] objectAtIndex:indexPath.row];
        PTGNewsDetailsViewController *newsDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PTGNewsDetailsViewController"];
        newsDetailsVC.news = news;
        NSMutableArray *aray = [NSMutableArray arrayWithArray:self.breadCrumbs];
        [aray addObject:self.parentCategory.name];
        newsDetailsVC.breadcrums = aray;
        [self.navigationController pushViewController:newsDetailsVC animated:YES];
    }
    else {
        if(indexPath.section == 0) {
            PTGNewsCategory *category = [[self.parentCategory.children allObjects] objectAtIndex:indexPath.row];
            category.newNews = [NSNumber numberWithInt:0];
            [category.managedObjectContext saveToPersistentStoreAndWait];
            
            PTGNewsListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
            vc.parentCategory = category;
            category.newNews = [NSNumber numberWithInteger:0];
            [category.managedObjectContext saveToPersistentStoreAndWait];
            [((PTGBaseTabBarViewController *)self.tabBarController) updateNewsBadge];
            NSMutableArray *aray = [NSMutableArray arrayWithArray:self.breadCrumbs];
            [aray addObject:self.parentCategory.name];
            vc.breadCrumbs = aray;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else {
            PTGNews *news = [[self.parentCategory.news allObjects] objectAtIndex:indexPath.row];
            PTGNewsDetailsViewController *newsDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PTGNewsDetailsViewController"];
            newsDetailsVC.news = news;
            NSMutableArray *aray = [NSMutableArray arrayWithArray:self.breadCrumbs];
            [aray addObject:self.parentCategory.name];
            newsDetailsVC.breadcrums = aray;
            [self.navigationController pushViewController:newsDetailsVC animated:YES];
        }
    }
}

-(void)checkNewsCell:(PTGNewsListCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        [cell isFirstCell];
    }
    else if(indexPath.row == [newsTableView numberOfRowsInSection:indexPath.section] - 1) {
        [cell isLastCell];
    }
    else {
        [cell isMiddleCell];
    }

}




@end
