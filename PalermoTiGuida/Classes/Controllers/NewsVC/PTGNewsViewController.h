//
//  PTGNewsViewController.h
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGBaseViewController.h"
@interface PTGNewsViewController : PTGBaseViewController <UITableViewDataSource, UITableViewDelegate>{
     IBOutlet UITableView *newsTableView;
    
    NSMutableArray *normalCategories;
    NSMutableArray *specialCategories;
}

@end
