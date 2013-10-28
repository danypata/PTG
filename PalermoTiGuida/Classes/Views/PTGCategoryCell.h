//
//  PTGCategoryCell.h
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTGCategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellBgImage;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *countButton;


+(PTGCategoryCell *)setupViews;
-(void)isFirstCell;
-(void)isMiddleCell;
-(void)isLastCell;

@end
