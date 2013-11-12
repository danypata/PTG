//
//  PTGExtraHeaderViewController.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 09/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGCategory.h"
@interface PTGExtraHeaderViewController : PTGBaseViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *extraTableView;
    CGFloat sectionHeight;
    
    NSInteger selectedSection;
    NSMutableArray *sectionInfo;
    NSArray *dataSource;
    NSMutableDictionary *cells;
}
@property(nonatomic, strong) PTGCategory *parentCategory;
@property(nonatomic, strong) NSArray *breadcrumbs;
@end
