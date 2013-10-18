//
//  PTGBaseViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"

@interface PTGBaseViewController ()

@end

@implementation PTGBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NAV_BAR_TITLE_VIEW_IMAGE]];
    self.navigationItem.titleView = titleImageView;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(infoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 22.f, 22.f);
    [rightButton setImage:[UIImage imageNamed:NAV_BAR_INFO_IMAGE_DEFAULT] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:NAV_BAR_INFO_IMAGE_SELECTED] forState:UIControlStateHighlighted];
                             
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

-(void)infoButtonTapped {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)addActivityIndicator {
    if(!indicator) {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.frame = CGRectMake((self.view.frame.size.width - indicator.frame.size.width)/ 2,
                                     (self.view.frame.size.height - indicator.frame.size.height)/ 2,
                                     indicator.frame.size.width,
                                     indicator.frame.size.height);
    }
    [self.view addSubview:indicator];
    [indicator startAnimating];
}

-(void)removeActivityIndicator {
    [indicator stopAnimating];
    [indicator removeFromSuperview];
}


-(void)showAllertMessageForErro:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeActivityIndicator];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Something went wrong!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    });
}


@end
