//
//  PTGExtraHeaderViewType5.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGExtraHeaderViewType5.h"

@implementation PTGExtraHeaderViewType5

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

+(PTGExtraHeaderViewType5 *)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:Nil options:Nil];
    return [views firstObject];
}

-(void)setupWithPlace:(PTGPlace *)place {
    [super setupWithPlace:place];
    NSArray *phones = [NSKeyedUnarchiver unarchiveObjectWithData:place.phones];
    NSString *phone = [phones firstObject];
    addressLabel.text = phone;
}


-(void)localizeButtonTapped:(id)sender {
    if(VALID_NOTEMPTY(addressLabel.text, NSString)) {
        NSString *text =[addressLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",text]];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"This device doesn't support phone calls!", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end
