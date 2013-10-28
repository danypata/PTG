//
//  PTGLeftMenuView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/18/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGLeftMenuView.h"
#import "PTGCategory.h"
#import "PTGLeftMenuSection.h"
#import "PTGLeftMenuCell.h"

@implementation PTGLeftMenuView
@synthesize selectedFilters;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


+(PTGLeftMenuView*)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views objectAtIndex:0];
}

-(void)shouldShow:(BOOL)show {
    if(show) {
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    else {
        self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    self.isShown = show;
}

-(void)setupDataSource {
    titleLabel.text = NSLocalizedString(titleLabel.text, @"");
    [ICFontUtils applyFont:QLASSIK_TB forView:titleLabel];
    parrentCategories = [NSArray arrayWithArray:[PTGCategory firstLevelCategories]];
    selectedSection = NSNotFound;
    sectionInfo = [NSMutableArray new];
    for(PTGCategory *cat in parrentCategories) {
        [sectionInfo addObject:[NSNull null]];
    }
    self.selectedFilters = [NSMutableArray new];
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        sectionHeight = 40.f;
    }
    else {
        sectionHeight = 82.f;
    }
    [tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [parrentCategories count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PTGLeftMenuSection *sectionView = [sectionInfo objectAtIndex:section];
    if(VALID(sectionView, PTGLeftMenuSection) && sectionView.isOpened == YES) {
        PTGCategory *category = [parrentCategories objectAtIndex:section];
        return [category.children count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return sectionHeight;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PTGLeftMenuSection *sectionView = [sectionInfo objectAtIndex:section];
    if(!VALID(sectionView, PTGLeftMenuSection)) {
        sectionView = [PTGLeftMenuSection initializeViews];
        [sectionInfo replaceObjectAtIndex:section withObject:sectionView];
    }
    PTGCategory *category = [parrentCategories objectAtIndex:section];
    [sectionView setTitle:category.name];
    sectionView.delegate = self;
    sectionView.section = section;
    return sectionView;
}

-(UITableViewCell *)tableView:(UITableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indetifier = @"identifier";
    PTGLeftMenuCell *cell = [mTableView dequeueReusableCellWithIdentifier:indetifier];
    if(!cell) {
        cell = [PTGLeftMenuCell initializeViews];
    }
    PTGCategory *category = [parrentCategories objectAtIndex:indexPath.section];
    PTGCategory *subCategory = [[category.children allObjects] objectAtIndex:indexPath.row];
    if([self.selectedFilters containsObject:subCategory]) {
        [mTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    [cell setTitle:subCategory.name];
    return cell;
}

-(void)tableView:(UITableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PTGCategory *category = [parrentCategories objectAtIndex:indexPath.section];
    PTGCategory *subCategory = [[category.children allObjects] objectAtIndex:indexPath.row];
    if([self.selectedFilters containsObject:subCategory]) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self.selectedFilters removeObject:subCategory];
    }
    else {
        [self.selectedFilters addObject:subCategory];
    }
    if([self.delegate respondsToSelector:@selector(filterResultsUsingCategories:)]) {
        [self.delegate filterResultsUsingCategories:self.selectedFilters];
    }
    
}

-(void)openSectionAtIndex:(NSInteger)index {
    PTGLeftMenuSection *indexSection = [sectionInfo objectAtIndex:index];
    indexSection.isOpened = YES;
    [sectionInfo replaceObjectAtIndex:index withObject:indexSection];
    NSMutableArray *indexPathsToInsert = [NSMutableArray new];
    PTGCategory *parrent = [parrentCategories objectAtIndex:index];
    for(int row = 0; row < [parrent.children count]; row++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:row inSection:index]];
    }
    
    NSMutableArray *indexPathsToDelete = [NSMutableArray new];
    NSInteger previousSection = selectedSection;
    if(previousSection != NSNotFound) {
        PTGLeftMenuSection *tappedSection = [sectionInfo objectAtIndex:previousSection];
        tappedSection.isOpened = NO;
        [sectionInfo replaceObjectAtIndex:previousSection withObject:tappedSection];
        PTGCategory *oldCategory = [parrentCategories objectAtIndex:previousSection];
        for(int row = 0; row < [oldCategory.children count]; row++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:row inSection:previousSection]];
        }
    }
    
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousSection == NSNotFound || index < previousSection) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [tableView beginUpdates];
    [tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [tableView endUpdates];
    selectedSection = index;
}

-(void)closeSectionAtIndex:(NSInteger)index {
    PTGLeftMenuSection *tappedSection = [sectionInfo objectAtIndex:index];
    tappedSection.isOpened = NO;
    [sectionInfo replaceObjectAtIndex:index withObject:tappedSection];
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    PTGCategory *category = [parrentCategories objectAtIndex:index];
    for (NSInteger i = 0; i < [category.children count]; i++) {
        [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:index]];
    }
    [tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    selectedSection = NSNotFound;
}
@end
