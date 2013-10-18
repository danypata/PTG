//
//  PTGLeftMenuSection.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTGLeftMenuSection <NSObject>

-(void)didSelectSectionAtIndex:(NSInteger)index sectionOpen:(BOOL)isOpened;

@end
@interface PTGLeftMenuSection : UIView {
    
    IBOutlet UIImageView *arrowImage;
    IBOutlet UILabel *sectionTitle;
}
@property(nonatomic)BOOL isOpened;
@property(nonatomic)NSInteger section;
@property(nonatomic, assign) id<PTGLeftMenuSection>delegate;
+(PTGLeftMenuSection *)initializeViews;

@end
