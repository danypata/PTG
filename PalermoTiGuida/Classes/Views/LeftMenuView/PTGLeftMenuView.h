//
//  PTGLeftMenuView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/18/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGLeftMenuSection.h"
@interface PTGLeftMenuView : UIView <UITableViewDataSource, UITableViewDelegate, PTGLeftMenuSectionDelegate>{
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UITableView *tableView;
    NSArray *parrentCategories;
    NSInteger selectedSection;
    NSMutableArray *sectionInfo;
    NSMutableArray *selectedFilters;

}
@property(nonatomic) BOOL isShown;
+(PTGLeftMenuView *)initializeViews;
-(void)shouldShow:(BOOL)show;
-(void)setupDataSource;
@end
