//
//  PTGDescriptionContactView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/16/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGDescriptionContactView.h"
#import "PTGPlace.h"
#import "PTGIconLabelView.h"
#import "BMXSwitch.h"
#import "PTGDiaryItem.h"

@implementation PTGDescriptionContactView
@synthesize delegate;

+(PTGDescriptionContactView *)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views objectAtIndex:0];
}

-(void)setupPlace:(PTGPlace *)place {
    yOffset = headerTitleLabel.frame.origin.y + headerTitleLabel.frame.size.height + DEFAULT_MARGIN;
    for(UIView *view in self.subviews) {
        if([view isKindOfClass:[PTGIconLabelView class]]){
            [view removeFromSuperview];
        }
    }
    currentPlace = place;
    CGRect labelFrame = CGRectZero;
    if(VALID_NOTEMPTY([self addressStringForPlace:place], NSString)) {
        [self addLabelsFromArray:@[[self addressStringForPlace:place]] withStartingString:@"" iconType:kIconTypeAddress];
    }
    [self addLabelsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:place.phones]
          withStartingString:NSLocalizedString(@"Telefono: ", @"")
                    iconType:kIconTypeMobilePhone];
    
    [self addLabelsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:place.faxes]
          withStartingString:NSLocalizedString(@"Fax: ", @"")
                    iconType:kIconTypePhone];
    
    if(VALID_NOTEMPTY([self getOppeningScheduleForPlace:place], NSString)) {
        [self addLabelsFromArray:@[[self getOppeningScheduleForPlace:place]] withStartingString:@"" iconType:kIconTypeSchedule];
    }
    [self addLabelsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:place.webAddresses]
          withStartingString:NSLocalizedString(@"", @"")
                    iconType:kIconTypeWebAddress];
    labelFrame = self.frame;
    labelFrame.size.height = yOffset;
    bgImage.frame = CGRectMake(bgImage.frame.origin.x,
                               bgImage.frame.origin.y,
                               bgImage.frame.size.width,
                               labelFrame.size.height);
    buttonsView.frame = CGRectMake(buttonsView.frame.origin.x,
                                   bgImage.frame.origin.y + bgImage.frame.size.height + DEFAULT_MARGIN,
                                   buttonsView.frame.size.width,
                                   buttonsView.frame.size.height);
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            buttonsView.frame.size.height + buttonsView.frame.origin.y);
    [self addSwitch];
    [self setupFonts];
    
}

- (void)addRemoveToDiary:(BOOL)add {
    if(add) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:NSLocalizedString(@"Hai già visitato questo punto d'interesse?", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"SI", @"")
                                              otherButtonTitles:NSLocalizedString(@"NO", @""), nil];
        [alert show];
    }
    else {
        [PTGDiaryItem removeDiaryForPlace:currentPlace];
    }
}

-(void)setupFonts {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:facebookButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:twitterButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:switchLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:headerTitleLabel];
    headerTitleLabel.text = NSLocalizedString(headerTitleLabel.text, @"");
    switchLabel.text = NSLocalizedString(switchLabel.text, @"");
    [facebookButton setTitle:NSLocalizedString(facebookButton.titleLabel.text, @"") forState:UIControlStateNormal];
    [twitterButton setTitle:NSLocalizedString(twitterButton.titleLabel.text, @"") forState:UIControlStateNormal];
}
- (IBAction)facebookButtonTapped:(id)sender {
    if([self.delegate respondsToSelector:@selector(shouldShareOnFacebook)]) {
        [self.delegate shouldShareOnFacebook];
    }
}

- (IBAction)twitterButtonTapped:(id)sender {
    if([self.delegate respondsToSelector:@selector(shouldShareOnTwitter)]) {
        [self.delegate shouldShareOnTwitter];
    }
}

-(void)addLabelsFromArray:(NSArray *)array withStartingString:(NSString *)string iconType:(IconLabelIconType)type {
    if(VALID_NOTEMPTY(array, NSArray)) {
        CGRect lastFrame = CGRectMake(bgImage.frame.origin.x + DEFAULT_MARGIN, yOffset, 0, 0);
        BOOL showIcon = YES;
        if(VALID_NOTEMPTY(string, NSString)) {
            PTGIconLabelView *label = [PTGIconLabelView initializeViews];
            [label setText:string forIconType:type];
            lastFrame.size.width = label.frame.size.width;
            lastFrame.size.height = label.frame.size.height;
            label.frame = lastFrame;
            [self addSubview:label];
            lastFrame.origin.x += lastFrame.size.width;
            showIcon = NO;
        }
        PTGIconLabelView *firstLabel = [PTGIconLabelView initializeViews];
        [firstLabel setText:[array firstObject] forIconType:((showIcon == YES) ? type : kIconTypeDisabled)];
        [firstLabel addGestureForType:type];
        lastFrame.size.width = firstLabel.frame.size.width;
        lastFrame.size.height = firstLabel.frame.size.height;
        firstLabel.frame = lastFrame;
        lastFrame.origin.y +=lastFrame.size.height;
        [self addSubview:firstLabel];
        lastFrame.origin.x += [firstLabel labelFrame].origin.x;
        for(int i= 1; i<[array count]; i++) {
            firstLabel = [PTGIconLabelView initializeViews];
            [firstLabel setText:[array objectAtIndex:i] forIconType:kIconTypeDisabled];
            lastFrame.size.width = firstLabel.frame.size.width;
            lastFrame.size.height = firstLabel.frame.size.height;
            firstLabel.frame = lastFrame;
            lastFrame.origin.y +=lastFrame.size.height;
            [self addSubview:firstLabel];
            [firstLabel addGestureForType:type];
        }
        yOffset = lastFrame.origin.y + lastFrame.size.height;
    }
    
    
    
}

-(void)addSwitch {
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        fadeLabelSwitchLabel = [[TTFadeSwitch alloc] initWithFrame:CGRectMake(switchImageView.frame.origin.x
                                                                              + switchImageView.frame.size.width
                                                                              - 75,
                                                                              (switchImageView.frame.origin.y
                                                                               + switchImageView.frame.size.height - 30) / 2,
                                                                              115.f,
                                                                              50.f)];
        fadeLabelSwitchLabel.onLabel.font = [UIFont systemFontOfSize:16.f];
        fadeLabelSwitchLabel.offLabel.font = [UIFont systemFontOfSize:16.f];
        fadeLabelSwitchLabel.labelsEdgeInsets = UIEdgeInsetsMake(5.0, 20, 1.0, 20);
        fadeLabelSwitchLabel.thumbInsetX = 0.0;
        fadeLabelSwitchLabel.thumbOffsetY = 1.0;
        
    }
    else {
        
        fadeLabelSwitchLabel = [[TTFadeSwitch alloc] initWithFrame:CGRectMake(switchImageView.frame.origin.x
                                                                              + switchImageView.frame.size.width
                                                                              - 135,
                                                                              (switchImageView.frame.origin.y
                                                                               + switchImageView.frame.size.height - 55) / 2,
                                                                              126.f,
                                                                              55.f)];
        fadeLabelSwitchLabel.onLabel.font = [UIFont systemFontOfSize:33.f];
        fadeLabelSwitchLabel.offLabel.font = [UIFont systemFontOfSize:33.f];
        fadeLabelSwitchLabel.labelsEdgeInsets = UIEdgeInsetsMake(12.0, 20, 1.0, 22);
        fadeLabelSwitchLabel.thumbInsetX = 5.0;
        fadeLabelSwitchLabel.thumbOffsetY = 2.0;
        
    }
    fadeLabelSwitchLabel.thumbImage = [UIImage imageNamed:@"switchToggle"];
    fadeLabelSwitchLabel.trackMaskImage = [UIImage imageNamed:@"switchMask"];
    fadeLabelSwitchLabel.thumbHighlightImage = [UIImage imageNamed:@"switchToggle"];
    fadeLabelSwitchLabel.trackImageOn = [UIImage imageNamed:@"switchGreen"];
    fadeLabelSwitchLabel.trackImageOff = [UIImage imageNamed:@"switchRed"];
    fadeLabelSwitchLabel.onString = @"ON";
    fadeLabelSwitchLabel.offString = @"OFF";
    [buttonsView addSubview:fadeLabelSwitchLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:fadeLabelSwitchLabel.onLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:fadeLabelSwitchLabel.offLabel];
    fadeLabelSwitchLabel.onLabel.textColor = [UIColor whiteColor];
    fadeLabelSwitchLabel.offLabel.textColor = [UIColor colorWithRed:53.f/255.f green:103.f/255.f blue:132.f/255.f alpha:1];
    
    if([PTGDiaryItem isDiaryForPlace:currentPlace]) {
        [fadeLabelSwitchLabel setOn:YES animated:NO];
    }
    __weak PTGDescriptionContactView *weakSelf = self;
    [fadeLabelSwitchLabel setChangeHandler:^(BOOL on) {
        [weakSelf addRemoveToDiary:on];
    }];
}

-(NSString *)addressStringForPlace:(PTGPlace *)place {
    NSMutableString *result = [[NSMutableString alloc] init];
    if(VALID_NOTEMPTY(place.street, NSString)) {
        [result appendString:place.street];
        [result appendString:@", "];
    }
    if(VALID_NOTEMPTY(place.streetNo, NSString)) {
        [result appendString:place.streetNo];
    }
    if(VALID_NOTEMPTY(place.zipCode, NSString)) {
        [result appendString:@" - "];
        [result appendString:place.zipCode];
        [result appendString:@" - "];
    }
    if(VALID_NOTEMPTY(place.city, NSString)) {
        [result appendString:place.city];
        [result appendString:@" "];
    }
    if(VALID_NOTEMPTY(place.province, NSString)) {
        [result appendString:place.province];
    }
    return result;
}

-(NSString *)getOppeningScheduleForPlace:(PTGPlace *)place {
    NSMutableString *result = [[NSMutableString alloc] initWithString:NSLocalizedString(@"Orari di apertura: ", @"")];
    if(VALID_NOTEMPTY(place.openTimeAMFrom, NSString)) {
        [result appendString:NSLocalizedString(@"Dalle ", @"")];
        [result appendString:place.openTimeAMFrom];
    }
    if(VALID_NOTEMPTY(place.openTimeAMTo, NSString)) {
        [result appendString:NSLocalizedString(@" alle ", @"")];
        [result appendString:place.openTimeAMTo];
    }
    if([result isEqualToString:NSLocalizedString(@"Orari di apertura: ", @"")]) {
        if(VALID_NOTEMPTY(place.openTimePMFrom, NSString)) {
            [result appendString:NSLocalizedString(@"Dalle ", @"")];
            [result appendString:place.openTimePMFrom];
        }
        if(VALID_NOTEMPTY(place.openTimePMFrom, NSString)) {
            [result appendString:NSLocalizedString(@" alle ", @"")];
            [result appendString:place.openTimePMFrom];
        }
    }
    else {
        if(VALID_NOTEMPTY(place.openTimePMFrom, NSString)) {
            [result appendString:NSLocalizedString(@" e dalle", @"")];
            [result appendString:place.openTimePMFrom];
        }
        if(VALID_NOTEMPTY(place.openTimePMFrom, NSString)) {
            [result appendString:NSLocalizedString(@" alle", @"")];
            [result appendString:place.openTimePMFrom];
        }
    }
    return result;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        [PTGDiaryItem diaryItemWithPlace:currentPlace visited:YES];
    }
    else {
        [PTGDiaryItem diaryItemWithPlace:currentPlace visited:NO];
    }
}


@end
