//
//  PTGLeftMenuView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/18/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGLeftMenuView.h"
#import "PTGCategory.h"
@implementation PTGLeftMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


+(PTGLeftMenuView*)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views objectAtIndex:0];
}

-(void)shouldShow:(BOOL)show {
    if(show) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    else {
        self.frame = CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    }
}

-(void)setupDataSource {
    parrentCategories = [NSArray arrayWithArray:[PTGCategory firstLevelCategories]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [parrentCategories count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PTGCategory *category = [parrentCategories objectAtIndex:section];
    return [category.children count];
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indetifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];

}


@end
