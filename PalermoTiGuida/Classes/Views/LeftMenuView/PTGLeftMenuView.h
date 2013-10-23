//
//  PTGLeftMenuView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/18/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGLeftMenuSection.h"

@protocol PTGLeftMenuViewDelegate <NSObject>

-(void)filterResultsUsingCategories:(NSArray *)categories;

@end

@interface PTGLeftMenuView : UIView <UITableViewDataSource, UITableViewDelegate, PTGLeftMenuSectionDelegate>{
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UITableView *tableView;
    NSArray *parrentCategories;
    NSInteger selectedSection;
    NSMutableArray *sectionInfo;
}
@property(nonatomic, strong)    NSMutableArray *selectedFilters;
@property(nonatomic, assign) id<PTGLeftMenuViewDelegate>delegate;
@property(nonatomic) BOOL isShown;
+(PTGLeftMenuView *)initializeViews;
-(void)shouldShow:(BOOL)show;
-(void)setupDataSource;
@end
