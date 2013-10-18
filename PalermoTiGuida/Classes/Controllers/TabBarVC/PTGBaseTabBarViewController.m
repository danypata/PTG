//
//  PTGBaseTabBarViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseTabBarViewController.h"

@interface PTGBaseTabBarViewController ()

@end

@implementation PTGBaseTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundImage = [UIImage imageNamed:TAB_BAR_BG];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
