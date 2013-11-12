//
//  PTGCustomDeleteButton.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTGCustomDeleteButtonDelegate <NSObject>

-(void)shouldDeleteCellAtIndex:(NSIndexPath *)indexPath;

@end

@interface PTGCustomDeleteButton : UIView {
    IBOutlet UILabel *buttonLabel;
    BOOL isShown;
    CGFloat offset;
}
@property (nonatomic, strong)NSIndexPath *cellIndex;
@property (nonatomic, assign) id<PTGCustomDeleteButtonDelegate>delegate;

+(PTGCustomDeleteButton *)initializeVies;
-(void)setupGestures;
@end
