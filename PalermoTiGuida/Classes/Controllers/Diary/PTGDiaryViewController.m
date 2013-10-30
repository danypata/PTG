//
//  PTGDiaryViewController.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGDiaryViewController.h"
#import "PTGDiaryItem.h"
#import "PTGPlaceCell.h"
#import "PTGNoDataCell.h"
#import "PTGDiaryHeaderView.h"


@interface PTGDiaryViewController ()

@end

@implementation PTGDiaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        defaultCellHeight = 64.f;
        sectionHeight = 60.f;
        noCellHeight = 150.f;
    }
    else {
        defaultCellHeight = 125.f;
        sectionHeight = 104.f;
        noCellHeight = 291.f;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    visitedPlaces = [[[PTGDiaryItem allDiaryItems] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(PTGDiaryItem *evaluatedObject, NSDictionary *bindings) {
        return  [evaluatedObject.isVisited boolValue];
    }]] mutableCopy];
    toBeVisited = [[[PTGDiaryItem allDiaryItems] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(PTGDiaryItem *evaluatedObject, NSDictionary *bindings) {
        return  ![evaluatedObject.isVisited boolValue];
    }]] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        if([toBeVisited count] == 0) {
            return 1;
        }
        return [toBeVisited count];
    }
    else {
        if([visitedPlaces count] == 0) {
            return 1;
        }
        return [visitedPlaces count];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PTGDiaryHeaderView *header = [PTGDiaryHeaderView initializeViews];
    NSString *string = @"";
    if(section == 0) {
        string = [NSString stringWithFormat:@"%d %@",[toBeVisited count], NSLocalizedString(@"elementi registrati", @"")];
        header.bigLabel.text = NSLocalizedString(@"De visitare", @"");
    }
    else {
        header.bigLabel.text = NSLocalizedString(@"Visitati", @"");
        string = [NSString stringWithFormat:@"%d %@",[visitedPlaces count], NSLocalizedString(@"elementi registrati",@"")];
    }
    header.smallLabel.text = string;
    [header setupFonts];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if([toBeVisited count] == 0) {
            return  noCellHeight;
        }
        return defaultCellHeight;
    }
    else {
        if([visitedPlaces count] == 0) {
            return noCellHeight;
        }
        return defaultCellHeight;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    static NSString *noResultsIdentifier = @"noresults";
    if(indexPath.section == 0) {
        if([toBeVisited count ]== 0) {
            PTGNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:noResultsIdentifier];
            if(!cell) {
                cell = [PTGNoDataCell initializeVies];
                [cell setupFonts];
                cell.backgroundColor = [UIColor clearColor];
            }
            cell.textView.text = NSLocalizedString(@"In quest’area del diario potrai tenere come promemoria tutti quei punti d’interesse che  ancora non hai visitato, ma che conti di vedere. Ti basterà attivare il “Metti in diario” nella schermata del monumento. PALERMOtiGUIDA ti chiederà se hai già visitato o meno il punto d’interesse", @"");
            return cell;
        }
        else {
            PTGPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(!cell) {
                cell = [PTGPlaceCell setupViews];
                PTGCustomDeleteButton *button = [PTGCustomDeleteButton initializeVies];
                [button setupGestures];
                button.delegate = self;
                cell.backgroundColor = [UIColor clearColor];
                button.cellIndex = indexPath;
                button.frame = CGRectMake(-button.frame.size.width +15,
                                          (cell.frame.size.height - button.frame.size.height) / 2,
                                          button.frame.size.width,
                                          button.frame.size.height);
                [cell addSubview:button];
            }
            PTGDiaryItem *item = [toBeVisited objectAtIndex:indexPath.row];
            [cell setupWithPlace:item.place];
            [self checkCellImage:cell forIndexPath:indexPath];
            return cell;

        }
    }
    else {
        if([visitedPlaces count] == 0) {
            PTGNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:noResultsIdentifier];
            if(!cell) {
                cell = [PTGNoDataCell initializeVies];
                [cell setupFonts];
                cell.backgroundColor = [UIColor clearColor];
            }
            cell.textView.text = NSLocalizedString(@"In quest’area del diario potrai tenere come promemoria tutti quei punti d’interesse che hai già visitato. Ti basterà attivare il “Metti in diario” nella schermata del monumento. PALERMOtiGUIDA ti chiederà se hai già visitato o meno il punto d’interesse", @"");
            return cell;

        }
        else {
            static NSString *identifier = @"identifier";
            PTGPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(!cell) {
                cell = [PTGPlaceCell setupViews];
                PTGCustomDeleteButton *button = [PTGCustomDeleteButton initializeVies];
                [button setupGestures];
                button.cellIndex = indexPath;
                cell.backgroundColor = [UIColor clearColor];
                button.delegate = self;
                button.frame = CGRectMake(-button.frame.size.width +10,
                                          (cell.frame.size.height - button.frame.size.height) / 2,
                                          button.frame.size.width,
                                          button.frame.size.height);
                [cell addSubview:button];
            }
            PTGDiaryItem *item = [visitedPlaces objectAtIndex:indexPath.row];
            [cell setupWithPlace:item.place];
            [self checkCellImage:cell forIndexPath:indexPath];
            return cell;
        }
    }
}

-(void)checkCellImage:(PTGPlaceCell *)cell forIndexPath:(NSIndexPath *)path {
    if(path.row == 0) {
        [cell isFirstCell];
    }
    else if(path.section == 0) {
        if([toBeVisited count] == path.row -1) {
            [cell isLastCell];
        }
        else {
            [cell isMiddleCell];
        }
    }
    else {
        if([visitedPlaces count] == path.row -1) {
            [cell isLastCell];
        }
        else {
            [cell isMiddleCell];
        }
    }
}

-(void)shouldDeleteCellAtIndex:(NSIndexPath *)indexPath {
    PTGDiaryItem *item = nil;
    if(indexPath.section == 0) {
        item = [toBeVisited objectAtIndex:indexPath.row];
        [toBeVisited removeObject:item];
    }
    else {
        item = [visitedPlaces objectAtIndex:indexPath.row];
        [visitedPlaces removeObject:item];
    }
    
    [diaryTableView reloadData];
    [item deleteEntity];
    [item.managedObjectContext saveToPersistentStoreAndWait];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
