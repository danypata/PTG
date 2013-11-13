//
//  PTGBaseViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGInfoViewController.h"

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
    
    if([[self.navigationController viewControllers] count] > 1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        UIImage *backImage = [[UIImage imageNamed:@"back_button_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
        UIImage *backSelected = [[UIImage imageNamed:@"back_button_bg_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
        [backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
        if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            backButton.frame = CGRectMake(0, 0, 50.0f, 33.0f);
            backButton.titleLabel.font = [UIFont fontWithName:QLASSIK_BOLD_TB size:16];
            backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        }
        else {
            backButton.frame = CGRectMake(0, 0, 90.0f, 33.0f);
            backButton.titleLabel.font = [UIFont fontWithName:QLASSIK_BOLD_TB size:16];
            backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        }
        [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
        [backButton setBackgroundImage:backSelected forState:UIControlStateHighlighted];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

-(void)popViewController {
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)infoButtonTapped {
    if(![self  isKindOfClass:[PTGInfoViewController class]]) {
        PTGInfoViewController *info = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PTGInfoViewController class])];
        [self.navigationController pushViewController:info animated:YES];
    }
    
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
