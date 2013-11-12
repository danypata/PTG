//
//  PTGIconLabelView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/16/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGIconLabelView.h"

@implementation PTGIconLabelView
@synthesize useGrayIcons;
@synthesize fontSize;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(PTGIconLabelView*)initializeViews {
    NSArray *views =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views objectAtIndex:0];
}

-(void)setText:(NSString *)text forIconType:(IconLabelIconType)type {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:label];
    if(self.fontColor) {
        label.textColor = self.fontColor;
    }
    if(self.fontSize == 0) {
        self.fontSize = label.font.pointSize;
    }
    label.font = [UIFont fontWithName:label.font.fontName size:self.fontSize];
    label.text = text;
    [label sizeToFit];
   label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height + 4);
    NSString *iconName = [self imageNameForType:type];
    int lines = label.frame.size.height/label.font.leading;
    if(lines == 1) {
        iconImageView.center = CGPointMake(iconImageView.center.x, label.center.y);
    }
    if(VALID_NOTEMPTY(iconName, NSString)) {
        iconImageView.image = [UIImage imageNamed:iconName];
    }
    else {
        CGRect labelFrame = label.frame;
        labelFrame.origin.x = 0;
        label.frame = labelFrame;
        iconImageView.hidden =YES;
    }
    self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                label.frame.size.width + label.frame.origin.x,
                                label.frame.origin.y + label.frame.size.height - 2);
}

-(void)addGestureForType:(IconLabelIconType)type {
    if(type == kIconTypeWebAddress) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openBrowserOrMail)];
        [self addGestureRecognizer:tap];
        tap.cancelsTouchesInView = NO;
    }
}

-(NSString *)imageNameForType:(IconLabelIconType)type {
    NSString *imageName = @"";
    switch (type) {
        case kIconTypeAddress:
            imageName= @"home_logo";
            break;
        case kIconTypeMobilePhone:
            imageName = @"mobile_phone_logo";
            break;
        case kIconTypePhone:
            imageName =  @"phone_logo";
            break;
        case kIconTypeSchedule:
            imageName = @"clock_logo";
            break;
        case kIconTypeWebAddress:
            imageName =@"web_logo";
            break;
        default:
            imageName = @"";
            break;
    }
    if(self.useGrayIcons && VALID_NOTEMPTY(imageName, NSString)) {
        imageName = [@"gray_" stringByAppendingString:imageName];
    }
    return imageName;
}

-(CGRect)labelFrame {
    return label.frame;
}

-(void)openBrowserOrMail {
    NSString *url = @"";
    if([label.text hasPrefix:@"www"]) {
        url = [NSString stringWithFormat:@"http://%@",label.text];
    }
    else {
        url = [NSString stringWithFormat:@"mailto:%@",label.text];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

@end
