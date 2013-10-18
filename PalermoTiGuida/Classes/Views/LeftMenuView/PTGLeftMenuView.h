//
//  PTGLeftMenuView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/18/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTGLeftMenuView : UIView <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UITableView *tableView;
    BOOL isShown;
    NSArray *parrentCategories;
}

+(PTGLeftMenuView *)initializeViews;
-(void)shouldShow:(BOOL)show;
-(void)setupDataSource;
@end
