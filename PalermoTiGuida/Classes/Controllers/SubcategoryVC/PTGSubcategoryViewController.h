//
//  PTGSubcategoryViewController.h
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGCategory.h"

@interface PTGSubcategoryViewController : PTGBaseViewController<UITableViewDataSource, UITableViewDelegate> {
    
    __weak IBOutlet UIImageView *headerImageView;
    __weak IBOutlet UIView *containerView;
     __weak IBOutlet UITableView *subcategoryTableView;
    __block NSArray *dataSource;
}
@property (nonatomic, strong) NSArray *breadcrumbs;
@property (nonatomic, strong) PTGCategory *parentCategory;

-(void)shouldHideAllViews:(BOOL)hide;

@end
