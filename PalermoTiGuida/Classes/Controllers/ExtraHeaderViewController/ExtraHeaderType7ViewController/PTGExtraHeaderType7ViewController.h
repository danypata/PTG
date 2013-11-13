//
//  PTGExtraHeaderType7ViewController.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 12/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGCategory.h"

@interface PTGExtraHeaderType7ViewController : PTGBaseViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *extraTableView;
    NSMutableArray *dataSource;
    BOOL isType8;
}
@property (nonatomic, strong) NSArray *breadcrumbs;
@property (nonatomic, strong) PTGCategory *parentCategory;

@end
