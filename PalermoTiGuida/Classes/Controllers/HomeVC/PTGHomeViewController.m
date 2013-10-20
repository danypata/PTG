//
//  PTGHomeViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGHomeViewController.h"
#import "PTGCategory.h"
#import "PTGSubcategoryViewController.h"
#import "ICFontUtils.h"

@interface PTGHomeViewController ()

@end

@implementation PTGHomeViewController

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
    [self setupFonts];
    backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    [self.tabBarController.view addSubview:backgroundImage];
    [PTGCategory loadCategoriesFromServerWithSuccess:^(NSArray *array) {
        categories = [NSArray arrayWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeImageView:backgroundImage];
        });
        
    } failureBlock:^(NSString *requestUrl, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeImageView:backgroundImage];
        });
    }];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    backgroundImage.frame = CGRectMake(0, 0, self.tabBarController.view.frame.size.width,
                                       self.tabBarController.view.frame.size.height);
}
-(void)setupFonts {
    [ICFontUtils applyFont:QLASSIK_TB forView:mapButton];
    [ICFontUtils applyFont:QLASSIK_TB forView:notesButton];
    [ICFontUtils applyFont:QLASSIK_TB forView:greenHouseButton];
    [ICFontUtils applyFont:QLASSIK_TB forView:freeTimeButton];
    [ICFontUtils applyFont:QLASSIK_TB forView:restaurantButton];
    [ICFontUtils applyFont:QLASSIK_TB forView:sleepingButton];
}
-(void)removeImageView:(UIImageView *)imageView {
    [UIView animateWithDuration:0.5 animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    mapButton = nil;
    notesButton = nil;
    greenHouseButton = nil;
    freeTimeButton = nil;
    restaurantButton = nil;
    sleepingButton = nil;
    [super viewDidUnload];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"SubcategorySegue"]) {
        ((PTGSubcategoryViewController *)segue.destinationViewController).parentCategory = sender;
        ((PTGSubcategoryViewController *)segue.destinationViewController).breadcrumbs = @[((PTGCategory *)sender).name];
    }
}
-(void)buttonTapped:(id)sender {
    NSString *title = ((UIButton *)sender).titleLabel.text;
    PTGCategory *selectedCategory = nil;
    for(PTGCategory *category in categories){
        if([category.name compare:title options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            selectedCategory = category;
            break;
        }
    }
    if(VALID(selectedCategory, PTGCategory) && [selectedCategory.type integerValue] == 0) {
        [self performSegueWithIdentifier:@"SubcategorySegue" sender:selectedCategory];
    }
    else {
        [self performSegueWithIdentifier:@"Diary" sender:nil];
    }
    
}
@end
