//
//  PTGBaseViewController.h
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NAV_BAR_BG_IMAGE            @"nav_bar_bg"
#define NAV_BAR_TITLE_VIEW_IMAGE    @"app_logo"
#define NAV_BAR_INFO_IMAGE_DEFAULT  @"info_button_default"
#define NAV_BAR_INFO_IMAGE_SELECTED @"info_button_selected"
@interface PTGBaseViewController : UIViewController {
    UIActivityIndicatorView *indicator;
}

//Called when the nav bar info button is tapped
-(void)infoButtonTapped;
-(void)addActivityIndicator;
-(void)removeActivityIndicator;
-(void)showAllertMessageForErro:(NSError *)error;
@end
