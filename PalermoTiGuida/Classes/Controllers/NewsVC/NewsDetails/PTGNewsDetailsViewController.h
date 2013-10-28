//
//  PTGNewsDetailsViewController.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 27/10/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGNews.h"
#import "PTGCoreTextView.h"


@interface PTGNewsDetailsViewController : PTGBaseViewController {
    
    IBOutlet UIView *productContainer;
    IBOutlet UIImageView *productImageVIew;
    IBOutlet UILabel *streetLabel;
    IBOutlet UILabel *distanceStaticLabel;
    IBOutlet UILabel *streetStaticLabel;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UILabel *placeName;
    
    IBOutlet UIScrollView *contentScrollView;
    IBOutlet UILabel *newsTypeStaticLabel;
    
    IBOutlet UIView *detailsContainer;
    IBOutlet UILabel *newsMonth;
    IBOutlet UILabel *newsDay;
    IBOutlet UILabel *newsValidityLabel;
    IBOutlet UILabel *newsValidityStaticLabel;
    IBOutlet UILabel *newsTypeLabel;
    IBOutlet UIImageView *detailsImageView;
    
    IBOutlet UILabel *newsDateStaticLabel;
    IBOutlet UILabel *newsDateLAbel;
    IBOutlet UILabel *detailsStaticLabel;
    PTGCoreTextView *details;
}

@property(nonatomic, strong) PTGNews *news;
@property(nonatomic, strong) NSArray *breadcrums;

@end
