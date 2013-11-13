//
//  PTGExtraHeaderType7ViewController.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 12/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGExtraHeaderType7ViewController.h"
#import "PTGExtraCellType7Cell.h"
#import "PTGBreadcrumbView.h"
#import "PTExtraCellType8GCell.h"

@interface PTGExtraHeaderType7ViewController ()

@end

@implementation PTGExtraHeaderType7ViewController
@synthesize breadcrumbs;
@synthesize parentCategory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(VALID_NOTEMPTY(self.parentCategory, PTGCategory)) {
        [self.parentCategory loadAllPlacesProperties:^(NSArray *products) {
            dispatch_async(dispatch_get_main_queue(), ^{
                dataSource = [NSMutableArray arrayWithArray:products];
                [extraTableView reloadData];
            });
        } failure:^(NSString *requestUrl, NSError *error) {
            
        }];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    PTGBreadcrumbView *brView = [PTGBreadcrumbView setupViews];
    if([self.parentCategory.type integerValue] == 8) {
        isType8 = YES;
        extraTableView.rowHeight = 75.f;
    }
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
    static NSString *identifier = @"identifier";
    static NSString *type8Identifier = @"type8";
    if(!isType8) {
        PTGExtraCellType7Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell) {
            cell = [PTGExtraCellType7Cell initializeViews];
            [cell setupLabels];
        }
        [cell setupWithPlace:[dataSource objectAtIndex:indexPath.row]];
        return cell;
    }
    else {
        PTExtraCellType8GCell *cell = [tableView dequeueReusableCellWithIdentifier:type8Identifier];
        if(!cell) {
            cell = [PTExtraCellType8GCell initializeViews];
        }
        if(indexPath.row == 0) {
            [cell setBackgroundImageForIndex:0];
        }
        else if(indexPath.row == [dataSource count] - 1) {
            [cell setBackgroundImageForIndex:3];
        }
        else {
            [cell setBackgroundImageForIndex:1];
        }
        [cell setupWithPlace:[dataSource objectAtIndex:indexPath.row]];
        return cell;
    }
    
}

@end
