//
//  PTGNewsDetailsViewController.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 27/10/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGNewsDetailsViewController.h"
#import "PTGPlace.h"
#import "PTGNewsCategory.h"
#import "PTGURLUtils.h"
#import "UIImageView+AFNetworking.h"
#import "PTGBreadcrumbView.h"
#import "PTGPlaceDetailsViewController.h"

@interface PTGNewsDetailsViewController ()

@end

@implementation PTGNewsDetailsViewController
@synthesize news;
@synthesize breadcrums;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFont];
    [self setupStrings];
    UIImage *bgImage = [UIImage imageNamed:@"table_bottom_cell"];
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    detailsImageView.image = bgImage;
    PTGBreadcrumbView *brView =[PTGBreadcrumbView setupViews];
    [brView setFontSize:kFontSizeSmall];
    [brView setXOffset:ARROW_MARGINS];
    [brView setItems:self.breadcrums];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectPlace)];
    [productContainer addGestureRecognizer:tapGesture];
    [self.view addSubview:brView];
    [self addDescriptionView];
}

-(void)setupFont {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:streetLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:streetStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:placeName];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:newsTypeStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:newsMonth];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:newsDay];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:newsValidityLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:newsValidityStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:newsTypeLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:newsDateStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:newsDateLAbel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:detailsStaticLabel];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)setupStrings {
    streetLabel.text = news.place.name;
    distanceStaticLabel.text = NSLocalizedString(distanceStaticLabel.text, @"");
    streetStaticLabel.text = NSLocalizedString(streetStaticLabel.text, @"");
    distanceLabel.text = news.place.distance;
    placeName.text = news.place.name;
    newsTypeStaticLabel.text = NSLocalizedString(newsTypeStaticLabel.text, @"");
    newsValidityStaticLabel.text = NSLocalizedString(newsValidityStaticLabel.text, @"");
    newsTypeLabel.text = news.category.name;
    newsDateStaticLabel.text = NSLocalizedString(newsDateStaticLabel.text, @"");
    newsDateLAbel.text = news.date;
    detailsStaticLabel.text = NSLocalizedString(detailsStaticLabel.text, @"");
    [self setDayAndMont];
    [self setValidity];
    [self positionLabels];
    [self setImage];
}

-(void)setImage {
    if(VALID_NOTEMPTY(news.place.mainImage, NSString) && VALID(productImageVIew, UIImageView)) {
        [productImageVIew setImageWithURLString:[PTGURLUtils mainPlaceImageUrlForId:news.place.mainImage]
                            urlRebuildOptions:kFromOther
                                  withSuccess:nil failure:nil];
        productImageVIew.layer.cornerRadius = 5;
        productImageVIew.layer.masksToBounds = YES;
        
    }

}
-(void)positionLabels {
    [streetStaticLabel sizeToFit];
    [streetLabel sizeToFit];
    [self repositionLabel:streetLabel
              anchorLabel:streetStaticLabel];
    
    [distanceLabel sizeToFit];
    [distanceStaticLabel sizeToFit];
    [self repositionLabel:distanceLabel
              anchorLabel:distanceStaticLabel];
    
    [newsDateStaticLabel sizeToFit];
    [newsDateLAbel sizeToFit];
    
    [self repositionLabel:newsDateLAbel
              anchorLabel:newsDateStaticLabel];

    [newsTypeStaticLabel sizeToFit];
    [newsTypeLabel sizeToFit];
    [self repositionLabel:newsTypeLabel
              anchorLabel:newsTypeStaticLabel];
    [newsValidityStaticLabel sizeToFit];
    [newsValidityLabel sizeToFit];
    [self repositionLabel:newsValidityLabel
              anchorLabel:newsValidityStaticLabel];
}

-(void)repositionLabel:(UILabel *)label anchorLabel:(UILabel *)anchorLabel {
    CGRect rect = anchorLabel.frame;
    label.frame = CGRectMake(rect.origin.x + rect.size.width + 5,
                             label.frame.origin.y,
                             label.frame.size.width,
                             label.frame.size.height);
}

-(void)setDayAndMont {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:news.date];
    NSDateFormatter *shortFormat = [[NSDateFormatter alloc] init];
    [shortFormat setDateFormat:@"dd/MMM"];
    NSString *shortSting = [shortFormat stringFromDate:date];
    newsDay.text = [[shortSting componentsSeparatedByString:@"/"] firstObject];
    newsMonth.text = [[[shortSting componentsSeparatedByString:@"/"] lastObject] uppercaseString];
}

-(void)setValidity {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *fromDate = [formatter dateFromString:news.validFrom];
    NSDate *toDate = [formatter dateFromString:news.validTo];
    
    NSDateFormatter *shortFormat = [[NSDateFormatter alloc] init];
    [shortFormat setDateFormat:@"dd/MM/YYYY"];
    
    NSString *shortFrom = [shortFormat stringFromDate:fromDate];
    NSString *shortTo = [shortFormat stringFromDate:toDate];
    
    NSString *fromYear = [[shortFrom componentsSeparatedByString:@"/"] lastObject];
    NSString *toYear = [[shortTo componentsSeparatedByString:@"/"] lastObject];
    
    NSString *fromDayAndMonth = [NSString stringWithFormat:@"%@/%@" ,
                                [[shortFrom componentsSeparatedByString:@"/"] firstObject],
                                [[shortFrom componentsSeparatedByString:@"/"] objectAtIndex:1]];
    NSString *toDayAndMonth = [NSString stringWithFormat:@"%@/%@" ,
                               [[shortTo componentsSeparatedByString:@"/"] firstObject],
                               [[shortTo componentsSeparatedByString:@"/"] objectAtIndex:1]];
    
    NSString *finalString = @"";
    if([fromYear isEqualToString:toYear]) {
        finalString = [NSString stringWithFormat:@"%@ %@ %@ %@ - %@",
                       NSLocalizedString(@"Dal", @""),
                       fromDayAndMonth,
                       NSLocalizedString(@"al", @""),
                       toDayAndMonth,
                       fromYear];
    }
    else {
        finalString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ - %@",
                       NSLocalizedString(@"Dal", @""),
                       fromDayAndMonth,
                       fromYear,
                       NSLocalizedString(@"al", @""),
                       toDayAndMonth,
                       toYear];
    }
    newsValidityLabel.text = finalString;

}

-(void)addDescriptionView {
    details = [[PTGCoreTextView alloc] initWithFrame:CGRectZero];
//    details.text = news.descriptionText;
    
    details.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        details.textFont = [UIFont fontWithName:QLASSIK_BOLD_TB size:12.f];
    }
    else {
        details.textFont = [UIFont fontWithName:QLASSIK_BOLD_TB size:25.f];
    }
    details.fontColor = [UIColor whiteColor];
    NSInteger lines = [details linesForFrame:CGRectMake(detailsStaticLabel.frame.origin.x,
                                                        detailsStaticLabel.frame.origin.y + detailsStaticLabel.frame.size.height + 5,
                                                        self.view.frame.size.width - 2*detailsStaticLabel.frame.origin.x,
                                                        self.view.frame.size.height)];
    CGFloat finalHieght = [details heightForText] * lines;
    details.frame = CGRectMake(detailsStaticLabel.frame.origin.x,
                               detailsStaticLabel.frame.origin.y + detailsStaticLabel.frame.size.height + 5,
                               self.view.frame.size.width - 2 * detailsStaticLabel.frame.origin.x,
                               finalHieght);
    [detailsContainer addSubview:details];
    detailsImageView.frame = CGRectMake(detailsImageView.frame.origin.x,
                                        detailsImageView.frame.origin.y,
                                        detailsImageView.frame.size.width,
                                        finalHieght + 15 + detailsStaticLabel.frame.origin.y + detailsStaticLabel.frame.size.height + 5);
    
    detailsContainer.frame = CGRectMake(detailsContainer.frame.origin.x,
                                        detailsContainer.frame.origin.y,
                                        detailsContainer.frame.size.width,
                                        detailsImageView.frame.size.height + 15);
    
    contentScrollView.contentSize = CGSizeMake(contentScrollView.contentSize.width, detailsContainer.frame.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)didSelectPlace {
    PTGPlaceDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PTGPlaceDetailsViewController"];
    vc.place = news.place;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
