//
//  PTGDiaryViewController.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGCustomDeleteButton.h"
@interface PTGDiaryViewController : PTGBaseViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UITableView *diaryTableView;
    NSArray *visitedPlaces;
    NSArray *toBeVisited;
    
}

@end
