//
//  PTGDiaryHeaderView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTGDiaryHeaderView : UIView {
    

}


@property (strong, nonatomic) IBOutlet UILabel *bigLabel;
@property (strong, nonatomic) IBOutlet UILabel *smallLabel;

+(PTGDiaryHeaderView *)initializeViews;
-(void)setupFonts;

@end
