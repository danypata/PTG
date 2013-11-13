//
//  PTGExtraHeaderViewController.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 09/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGExtraHeaderViewController.h"
#import "PTGExtraHeaderView.h"
#import "PTGBreadcrumbView.h"
#import "PTGCustomExtraCell.h"
#import "PTGExtraHeaderViewType5.h"

@interface PTGExtraHeaderViewController ()

@end

@implementation PTGExtraHeaderViewController

@synthesize breadcrumbs;
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
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        sectionHeight = 77.f;
    }
    else {
        sectionHeight = 152.f;
    }
    selectedSection = NSNotFound;
    sectionInfo = [NSMutableArray new];
    cells = [NSMutableDictionary new];
    extraTableView.sectionHeaderHeight = sectionHeight;
    [self addActivityIndicator];
    [self.parentCategory loadAllPlacesProperties:^(NSArray *products) {
        for(PTGCategory *cat in products) {
            [sectionInfo addObject:[NSNull null]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            dataSource = [NSMutableArray arrayWithArray:products];
            [extraTableView reloadData];
            [self removeActivityIndicator];
        });
    } failure:^(NSString *requestUrl, NSError *error) {
        [self removeActivityIndicator];
        [self showAllertMessageForErro:error];
    }];
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataSource count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PTGExtraHeaderView *sectionView = [sectionInfo objectAtIndex:section];
    if(VALID(sectionView, PTGExtraHeaderView) && sectionView.isOpen == YES) {
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTGCustomExtraCell *cell = [cells objectForKey:[NSNumber numberWithInt:indexPath.section]];
    if(!cell) {
        cell = [PTGCustomExtraCell initializeViews];
        if(indexPath.section == [tableView numberOfSections] - 1) {
            [cell setupWithPlace:[dataSource objectAtIndex:indexPath.section] isLastSection:YES];
        }
        else {
            [cell setupWithPlace:[dataSource objectAtIndex:indexPath.section] isLastSection:NO];
        }
        [cells setObject:cell forKey:[NSNumber numberWithInt:indexPath.section]];
    }
    return cell.frame.size.height;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PTGExtraHeaderView *sectionView = [sectionInfo objectAtIndex:section];
    if([self.parentCategory.type integerValue] == 5) {
        if(!VALID(sectionView, PTGExtraHeaderViewType5)) {
            sectionView = [PTGExtraHeaderViewType5 initializeViews];
            [sectionInfo replaceObjectAtIndex:section withObject:sectionView];
        }
    }
    else if(!VALID(sectionView, PTGExtraHeaderView)) {
        sectionView = [PTGExtraHeaderView initializeViews];
        [sectionInfo replaceObjectAtIndex:section withObject:sectionView];
    }
    
    PTGPlace *place = [dataSource objectAtIndex:section];
    [sectionView setupWithPlace:place];
    [sectionView setTapBlock:^(BOOL isOpen) {
        if(isOpen) {
            [self openSectionAtIndex:section];
        }
        else {
            [self closeSectionAtIndex:section];
        }
    }];
    if(section == 0){
        [sectionView setBackgroundImageForIndex:0];
    }
    else if(section == [dataSource count] -1) {
        [sectionView setBackgroundImageForIndex:3];
    }
    else {
        [sectionView setBackgroundImageForIndex:1];
    }
    return sectionView;
}

-(UITableViewCell *)tableView:(UITableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [cells objectForKey:[NSNumber numberWithInt:indexPath.section]];
}

-(void)openSectionAtIndex:(NSInteger)index {
    PTGExtraHeaderView *indexSection = [sectionInfo objectAtIndex:index];
    indexSection.isOpen = YES;
    [sectionInfo replaceObjectAtIndex:index withObject:indexSection];
    NSMutableArray *indexPathsToInsert = [NSMutableArray new];
    [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:0 inSection:index]];
    
    NSMutableArray *indexPathsToDelete = [NSMutableArray new];
    NSInteger previousSection = selectedSection;
    if(previousSection != NSNotFound) {
        PTGExtraHeaderView *tappedSection = [sectionInfo objectAtIndex:previousSection];
        tappedSection.isOpen = NO;
        [sectionInfo replaceObjectAtIndex:previousSection withObject:tappedSection];
        [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:0 inSection:previousSection]];
    }
    
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousSection == NSNotFound || index < previousSection) {
        insertAnimation = UITableViewRowAnimationFade;
        deleteAnimation = UITableViewRowAnimationFade;
    }
    else {
        insertAnimation = UITableViewRowAnimationFade;
        deleteAnimation = UITableViewRowAnimationFade;
    }
    
    // Apply the updates.
    [extraTableView beginUpdates];
    [extraTableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [extraTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [extraTableView endUpdates];
    selectedSection = index;
}

-(void)closeSectionAtIndex:(NSInteger)index {
    PTGExtraHeaderView *tappedSection = [sectionInfo objectAtIndex:index];
    tappedSection.isOpen = NO;
    [sectionInfo replaceObjectAtIndex:index withObject:tappedSection];
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:0 inSection:index]];
    [extraTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationFade];
    selectedSection = NSNotFound;
}


@end
