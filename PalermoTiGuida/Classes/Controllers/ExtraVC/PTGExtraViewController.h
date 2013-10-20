//
//  PTGExtraViewController.h
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGCategory.h"
@interface PTGExtraViewController : PTGBaseViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *dataSource;
    IBOutlet UITableView *extraTableView;
}
@property (nonatomic, strong) PTGCategory *parentCategory;
@property (nonatomic, strong) NSMutableArray *breadcrumbsItems;

@end
