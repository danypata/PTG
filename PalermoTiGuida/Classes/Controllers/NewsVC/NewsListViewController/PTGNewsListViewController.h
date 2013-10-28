//
//  PTGNewsListViewController.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 27/10/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGNewsCategory.h"
#import "PTGBaseViewController.h"
@interface PTGNewsListViewController : PTGBaseViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UITableView *newsTableView;
    NSInteger newsCellHeight;
    NSInteger childCellHeight;
    
}

@property(nonatomic, strong) NSArray *breadCrumbs;
@property(nonatomic, strong) PTGNewsCategory *parentCategory;

@end
