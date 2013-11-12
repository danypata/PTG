//
//  PTGCustomExtraCell.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 09/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGCustomExtraCell.h"
#import "PTGDescriptionContactView.h"
#import "PTGCategory.h"

@implementation PTGCustomExtraCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
+(PTGCustomExtraCell *)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:Nil options:nil];;
    return [views firstObject];
    
}
-(void)setupWithPlace:(PTGPlace *)place isLastSection:(BOOL)isLastSection{
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        yOffset = 10;
    }
    else {
        yOffset = 20;
    }
    for(UIView *view in self.subviews) {
        if([view isKindOfClass:[PTGIconLabelView class]]){
            [view removeFromSuperview];
        }
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    currentPlace = place;
    imageBg.image = [imageBg.image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 40, 10)];
    CGRect labelFrame = CGRectZero;
    if([currentPlace.category.type integerValue] != 5) {
        if(VALID_NOTEMPTY([self addressStringForPlace:place], NSString)) {
            [self addLabelsFromArray:@[[self addressStringForPlace:place]] withStartingString:@"" iconType:kIconTypeAddress];
        }
        [self addLabelsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:place.phones]
              withStartingString:NSLocalizedString(@"Telefono: ", @"")
                        iconType:kIconTypeMobilePhone];
        if([place.category.type integerValue] != 9) {
            [self addLabelsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:place.webAddresses]
                  withStartingString:NSLocalizedString(@"", @"")
                            iconType:kIconTypeWebAddress];
        }
    }
    
    labelFrame = self.frame;
    labelFrame.size.height = yOffset;
    if([place.category.type integerValue] == 6 || [place.category.type integerValue] == 5) {
        UILabel *blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(containerView.frame.origin.x + DEFAULT_MARGIN, yOffset, containerView.frame.size.width, 44)];
        blueLabel.textColor = [UIColor colorWithRed:76.f/255.f green:152.f/255.f blue:230.f/255.f alpha:1];
        blueLabel.font = [UIFont fontWithName:QLASSIK_TB size:10.f];
        blueLabel.text = NSLocalizedString(@"• Altre informazioni", nil);
        [blueLabel sizeToFit];
        blueLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:blueLabel];
        
        PTGCoreTextView *textView = [[PTGCoreTextView alloc] initWithFrame:CGRectMake(blueLabel.frame.origin.x,
                                                                                      blueLabel.frame.size.height + blueLabel.frame.origin.y,
                                                                                      containerView.frame.size.width - 2 * blueLabel.frame.origin.x,
                                                                                      10000)];
        [textView setText:place.descriptionText];
        [textView setFontColor:[UIColor whiteColor]];
        textView.textFont = [UIFont fontWithName:QLASSIK_TB size:10.f];
        CGFloat actualHeight = [textView heightForText];
        textView.frame = CGRectMake(textView.frame.origin.x,
                                    textView.frame.origin.y,
                                    textView.frame.size.width,
                                    actualHeight + DEFAULT_MARGIN);
        yOffset = textView.frame.origin.y + textView.frame.size.height;
        [self addSubview:textView];
    }
    if(isLastSection) {
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                self.frame.size.width,
                                yOffset + 20);
    }
    else {
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                self.frame.size.width,
                                yOffset);
    }
    
    containerView.frame = CGRectMake(containerView.frame.origin.x,
                                     containerView.frame.origin.y,
                                     containerView.frame.size.width,
                                     yOffset);
    imageBg.frame = CGRectMake(imageBg.frame.origin.x,
                               imageBg.frame.origin.y,
                               imageBg.frame.size.width,
                               self.frame.size.height);
    
}


-(void)addLabelsFromArray:(NSArray *)array withStartingString:(NSString *)string iconType:(IconLabelIconType)type {
    if(VALID_NOTEMPTY(array, NSArray)) {
        CGRect lastFrame = CGRectMake(containerView.frame.origin.x + DEFAULT_MARGIN, yOffset, 0, 0);
        BOOL showIcon = YES;
        if(VALID_NOTEMPTY(string, NSString)) {
            PTGIconLabelView *label = [PTGIconLabelView initializeViews];
            label.useGrayIcons = YES;
            label.fontColor = [UIColor whiteColor];
            label.fontSize = 10.f;
            [label setText:string forIconType:type];
            lastFrame.size.width = label.frame.size.width;
            lastFrame.size.height = label.frame.size.height;
            label.frame = lastFrame;
            [self addSubview:label];
            lastFrame.origin.x += lastFrame.size.width;
            
            showIcon = NO;
        }
        PTGIconLabelView *firstLabel = [PTGIconLabelView initializeViews];
        firstLabel.useGrayIcons = YES;
        firstLabel.fontColor = [UIColor whiteColor];
        firstLabel.fontSize = 10.f;
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
            firstLabel.useGrayIcons = YES;
            firstLabel.fontColor = [UIColor whiteColor];
            firstLabel.fontSize = 10.f;
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

@end
