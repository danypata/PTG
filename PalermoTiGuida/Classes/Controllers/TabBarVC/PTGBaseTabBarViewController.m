//
//  PTGBaseTabBarViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseTabBarViewController.h"
#import "PTGNewsCategory.h"

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
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        [self setImagesFromiOS7];
    } else {
        [self setImagesPrioriOS7];
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor colorWithRed:74.f/255.f green:87.f/255 blue:91.f/255.f alpha:1]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor colorWithRed:74.f/255.f green:87.f/255 blue:91.f/255.f alpha:1]} forState:UIControlStateSelected];
    [self setTitles];
    [PTGNewsCategory newsCategoriesWithSuccess:^(NSInteger newNews) {
        if(newNews != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                ((UITabBarItem *)[self.tabBar.items objectAtIndex:4]).badgeValue = [NSString stringWithFormat:@"%d",newNews];
            });
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)setTitles {
    ((UITabBarItem*)[self.tabBar.items objectAtIndex:0]).title = NSLocalizedString(@"Guida", @"");
    ((UITabBarItem*)[self.tabBar.items objectAtIndex:1]).title = NSLocalizedString(@"Around Me", @"");
    ((UITabBarItem*)[self.tabBar.items objectAtIndex:2]).title = NSLocalizedString(@"Cerca", @"");
    ((UITabBarItem*)[self.tabBar.items objectAtIndex:3]).title = NSLocalizedString(@"Extra", @"");
    ((UITabBarItem*)[self.tabBar.items objectAtIndex:4]).title = NSLocalizedString(@"News", @"");
}

-(void)setImagesPrioriOS7 {
    [[self.tabBar.items objectAtIndex:0] setFinishedSelectedImage:[UIImage imageNamed:@"tab_bar_home_selected_icon"]
                                      withFinishedUnselectedImage:[UIImage imageNamed:@"tab_bar_home_default_icon"]];
    
    [[self.tabBar.items objectAtIndex:1] setFinishedSelectedImage:[UIImage imageNamed:@"tab_bar_location_icon"]
                                      withFinishedUnselectedImage:[UIImage imageNamed:@"tab_bar_location_button_default"]];
    
    [[self.tabBar.items objectAtIndex:2] setFinishedSelectedImage:[UIImage imageNamed:@"tab_bar_search_button_selected"]
                                      withFinishedUnselectedImage:[UIImage imageNamed:@"tab_bar_search_button_default"]];
    
    [[self.tabBar.items objectAtIndex:3] setFinishedSelectedImage:[UIImage imageNamed:@"tab_bar_extra_selected_icon"]
                                      withFinishedUnselectedImage:[UIImage imageNamed:@"tab_bar_extra_button_default"]];
    
    [[self.tabBar.items objectAtIndex:4] setFinishedSelectedImage:[UIImage imageNamed:@"tab_bar_news_selected_icon"]
                                      withFinishedUnselectedImage:[UIImage imageNamed:@"tab_bar_news_button_default"]];
    
}

-(void)setImagesFromiOS7 {
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:0]).selectedImage = [[UIImage imageNamed:@"tab_bar_home_selected_icon"]
                                                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:0]).image = [[UIImage imageNamed:@"tab_bar_home_default_icon"]
                                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:1]).image = [[UIImage imageNamed:@"tab_bar_location_button_default"]
                                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:1]).selectedImage = [[UIImage imageNamed:@"tab_bar_location_icon"]
                                                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:2]).image = [[UIImage imageNamed:@"tab_bar_search_button_default"]
                                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:2]).selectedImage = [[UIImage imageNamed:@"tab_bar_search_button_selected"]
                                                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:3]).image = [[UIImage imageNamed:@"tab_bar_extra_button_default"]
                                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:3]).selectedImage = [[UIImage imageNamed:@"tab_bar_extra_selected_icon"]
                                                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:4]).image = [[UIImage imageNamed:@"tab_bar_news_button_default"]
                                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ((UITabBarItem *)[self.tabBar.items objectAtIndex:4]).selectedImage = [[UIImage imageNamed:@"tab_bar_news_selected_icon"]
                                                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
