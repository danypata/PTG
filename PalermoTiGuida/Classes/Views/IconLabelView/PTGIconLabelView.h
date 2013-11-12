//
//  PTGIconLabelView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/16/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kIconTypeAddress,
    kIconTypeMobilePhone,
    kIconTypePhone,
    kIconTypeWebAddress,
    kIconTypeSchedule,
    kIconTypeDisabled
}IconLabelIconType;

@interface PTGIconLabelView : UIView {
    
    IBOutlet UIImageView *iconImageView;
    IBOutlet UILabel *label;
}
@property(nonatomic) BOOL useGrayIcons;
@property(nonatomic, strong) UIColor *fontColor;
@property(nonatomic) CGFloat fontSize;
+(PTGIconLabelView*)initializeViews;
-(void)setText:(NSString *)text forIconType:(IconLabelIconType)type;
-(CGRect)labelFrame;
-(void)addGestureForType:(IconLabelIconType)type;
@end
