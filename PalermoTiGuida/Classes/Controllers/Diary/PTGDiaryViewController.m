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
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    visitedPlaces = [[PTGDiaryItem allDiaryItems] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(PTGDiaryItem *evaluatedObject, NSDictionary *bindings) {
        return  [evaluatedObject.isVisited boolValue];
    }]];
    toBeVisited = [[PTGDiaryItem allDiaryItems] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(PTGDiaryItem *evaluatedObject, NSDictionary *bindings) {
        return  ![evaluatedObject.isVisited boolValue];
    }]];
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
        string = [NSString stringWithFormat:@"%d elementi registrati", [toBeVisited count]];
        header.bigLabel.text = NSLocalizedString(@"De visitare", @"");
    }
    else {
        header.bigLabel.text = NSLocalizedString(@"Visitati", @"");
        string = [NSString stringWithFormat:@"%d elementi registrati", [visitedPlaces count]];
    }
    header.smallLabel.text = string;
    [header setupFonts];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if([toBeVisited count] == 0) {
            return  150;
        }
        return 64;
    }
    else {
        if([visitedPlaces count] == 0) {
            return 150;
        }
        return 64;
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
            }
            cell.textView.text = NSLocalizedString(@"In quest’area del diario potrai tenere come                                                    promemoria tutti quei punti d’interesse che ancora non hai visitato, ma che conti di vedere.\n Ti basterà attivare il “Metti in diario” nella schermata del monumento. APPalermo ti chiederà se hai già visitato o meno il punto d’interesse.", @"");
            return cell;
        }
        else {
            PTGPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(!cell) {
                cell = [PTGPlaceCell setupViews];
                PTGCustomDeleteButton *button = [PTGCustomDeleteButton initializeVies];
                [button setupGestures];
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
            }
            cell.textView.text = NSLocalizedString(@"In quest’area del diario potrai tenere come                                                    promemoria tutti quei punti d’interesse che ancora non hai visitato, ma che conti di vedere. \n Ti basterà attivare il “Metti in diario” nella schermata del monumento. APPalermo ti chiederà se hai già visitato o meno il punto d’interesse.", @"");
            return cell;

        }
        else {
            static NSString *identifier = @"identifier";
            PTGPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(!cell) {
                cell = [PTGPlaceCell setupViews];
                PTGCustomDeleteButton *button = [PTGCustomDeleteButton initializeVies];
                [button setupGestures];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
