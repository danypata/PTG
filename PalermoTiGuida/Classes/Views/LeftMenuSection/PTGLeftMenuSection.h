//
//  PTGLeftMenuSection.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTGLeftMenuSectionDelegate <NSObject>

-(void)closeSectionAtIndex:(NSInteger)index;
-(void)openSectionAtIndex:(NSInteger)index;

@end
@interface PTGLeftMenuSection : UIView {
    
    IBOutlet UIImageView *arrowImage;
    IBOutlet UILabel *sectionTitle;
}
@property(nonatomic)BOOL isOpened;
@property(nonatomic)NSInteger section;
@property(nonatomic, assign) id<PTGLeftMenuSectionDelegate>delegate;

+(PTGLeftMenuSection *)initializeViews;
-(void)setTitle:(NSString *)title;

@end
