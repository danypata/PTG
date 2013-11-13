//
//  PTGExtraViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGExtraViewController.h"
#import "PTGCategory.h"
#import "PTGCategoryCell.h"
#import "PTGBreadcrumbView.h"
#import "PTGExtraPlaceViewController.h"
#import "PTGPlaceListViewController.h"
#import "PTGExtraHeaderViewController.h"
#import "PTGExtraHeaderType7ViewController.h"

@interface PTGExtraViewController ()

@end

@implementation PTGExtraViewController
@synthesize parentCategory;
@synthesize breadcrumbsItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!VALID(self.parentCategory, PTGCategory)) {
        PTGCategory *extra = [PTGCategory firstLevelCategoryWithName:NSLocalizedString(@"Extra",@"")];
        dataSource = [NSArray arrayWithArray:[extra.children allObjects]];
    }
    else {
        dataSource = [NSArray arrayWithArray:[self.parentCategory.children allObjects]];
    }
    PTGBreadcrumbView *view = [PTGBreadcrumbView setupViews];
    [view setXOffset:10];
    if(!VALID(self.breadcrumbsItems, NSArray)) {
        self.breadcrumbsItems = [NSMutableArray new];
        [view setFontSize:kFontSizeLarge];
        [self.breadcrumbsItems addObject:NSLocalizedString(@"Extra",@"")];
        [view setItems:self.breadcrumbsItems];
    }
    else {
        [view setFontSize:kFontSizeSmall];
        [view setItems:self.breadcrumbsItems];
    }
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"categoryCell";
    PTGCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell =[ PTGCategoryCell setupViews];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
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
        [cell.countButton setTitle:[currentCategory.subcategoryCount stringValue] forState:UIControlStateNormal];
    }
    else {
        [cell.countButton setTitle:[currentCategory.placesCount stringValue] forState:UIControlStateNormal];
    }
    cell.categoryNameLabel.text = currentCategory.name;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PTGCategory *category = [dataSource objectAtIndex:indexPath.row];
    if([category.children count] > 0) {
        PTGExtraViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
        vc.parentCategory = category;
        NSMutableArray *arr = [self.breadcrumbsItems mutableCopy];
        [arr addObject:category.name];
        vc.breadcrumbsItems = arr;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        switch ([category.type integerValue]) {
            case 1:
            case 2:
            case 3:
            case 4: {
                PTGPlaceListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PTGPlaceListViewController class])];
                vc.parentCategory = category;
                NSMutableArray *arr = [NSMutableArray arrayWithArray:self.breadcrumbsItems];
                [arr addObject:category.name];
                vc.breadcrumbs = arr;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 5:
            case 6:
            case 9:
            case 10:
                [self performSegueWithIdentifier:@"headerSegue" sender:category];
                break;
            case 7:
            case 8:
                [self performSegueWithIdentifier:@"type7" sender:category];
                break;
            case 11:
                [self performSegueWithIdentifier:@"ExtraSegue" sender:category];
                break;
                
            default:
                break;
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ExtraSegue"]) {
        PTGExtraPlaceViewController *list = segue.destinationViewController;
        list.parentCategory= sender;
        NSMutableArray *arr = [self.breadcrumbsItems mutableCopy];
        [arr addObject:((PTGCategory*)sender).name];
        list.breadcrumbs =arr;
    }
    else if([segue.identifier isEqualToString:@"headerSegue"]) {
        PTGExtraHeaderViewController *list = segue.destinationViewController;
        list.parentCategory = sender;
        NSMutableArray *arr = [self.breadcrumbsItems mutableCopy];
        [arr addObject:((PTGCategory*)sender).name];
        list.breadcrumbs =arr;
    }
    else if([segue.identifier isEqualToString:@"type7"]) {
        PTGExtraHeaderType7ViewController *list = segue.destinationViewController;
        list.parentCategory = sender;
        NSMutableArray *arr = [self.breadcrumbsItems mutableCopy];
        [arr addObject:((PTGCategory*)sender).name];
        list.breadcrumbs  = arr;
    }
}

@end
