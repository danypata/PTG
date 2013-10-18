//
//  PTGHomeViewController.h
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTGHomeViewController : PTGBaseViewController {
    
    __weak IBOutlet UIButton *mapButton;
    __weak IBOutlet UIButton *notesButton;
    __weak IBOutlet UIButton *greenHouseButton;
    __weak IBOutlet UIButton *freeTimeButton;
    __weak IBOutlet UIButton *restaurantButton;
    __weak IBOutlet UIButton *sleepingButton;
    NSArray *categories;
    UIImageView *backgroundImage;
}
- (IBAction)buttonTapped:(id)sender;

@end
