//
//  PTGExtraPlaceViewController.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGCategory.h"
#import "PTGExtraCell.h"

@interface PTGExtraPlaceViewController : PTGBaseViewController <UITableViewDataSource, UITableViewDelegate, PTGExtraCellDelegate> {
    IBOutlet UITableView *extraPlaceTableView;
    NSMutableArray *dataSource;
}
@property(nonatomic, strong) PTGCategory *parentCategory;
@property(nonatomic, strong) NSArray *breadcrumbs;
@end
