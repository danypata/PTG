//
//  PTGInfoViewController.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/21/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGInfoViewController.h"

@interface PTGInfoViewController ()

@end

@implementation PTGInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:appDevLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:emailLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:webAddressLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:secondLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:firstLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
