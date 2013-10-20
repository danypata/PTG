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
    
}

- (IBAction)addRemoveToDiaryTapped:(id)sender {
    UIButton *button = (UIButton *)sender;
    if(!button.selected) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedString(@"Hai già visitato questo punto d'interesse?", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"SI", @"")
                                          otherButtonTitles:NSLocalizedString(@"NO", @""), nil];
        [alert show];
        button.selected = YES;
    }
    else {
        [PTGDiaryItem removeDiaryForPlace:currentPlace];
    }
}

-(void)setupFonts {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:facebookButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:twitterButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:switchLabel];
}
- (IBAction)facebookButtonTapped:(id)sender {
}

- (IBAction)twitterButtonTapped:(id)sender {
}

-(void)addLabelsFromArray:(NSArray *)array withStartingString:(NSString *)string iconType:(IconLabelIconType)type {
    if(VALID_NOTEMPTY(array, NSArray)) {
        NSString *firstString = [string stringByAppendingString:[array objectAtIndex:0]];
        PTGIconLabelView *firstLabel = [PTGIconLabelView initializeViews];
        [firstLabel setText:firstString forIconType:type];
        CGRect labelFrame = firstLabel.frame;
        labelFrame.origin.y = yOffset;
        labelFrame.origin.x = bgImage.frame.origin.x + DEFAULT_MARGIN;
        firstLabel.frame = labelFrame;
        yOffset +=labelFrame.size.height;
        [self addSubview:firstLabel];
        CGRect lastValidFrame = firstLabel.frame;
        PTGIconLabelView *loopLabel =nil;
        for(int i=1; i< [array count]; ++i) {
            firstString = [array objectAtIndex:i];
            loopLabel = [PTGIconLabelView initializeViews];
            [loopLabel setText:firstString forIconType:kIconTypeDisabled];
            labelFrame = loopLabel.frame;
            labelFrame.origin.y = yOffset;
            labelFrame.origin.x += lastValidFrame.origin.x + lastValidFrame.size.width - loopLabel.frame.origin.x - loopLabel.frame.size.width;
            loopLabel.frame = labelFrame;
            yOffset +=labelFrame.size.height;
            [self addSubview:loopLabel];
        }
        yOffset+=DEFAULT_MARGIN;
        
    }
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
