//
//  PTGCustomDeleteButton.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTGCustomDeleteButtonDelegate <NSObject>

-(void)shouldDeleteCellAtIndex:(NSInteger)index;

@end

@interface PTGCustomDeleteButton : UIView {
    IBOutlet UILabel *buttonLabel;
    BOOL isShown;
}
@property (nonatomic)NSInteger cellIndex;
@property (nonatomic, assign) id<PTGCustomDeleteButtonDelegate>delegate;

+(PTGCustomDeleteButton *)initializeVies;
-(void)setupGestures;
@end
