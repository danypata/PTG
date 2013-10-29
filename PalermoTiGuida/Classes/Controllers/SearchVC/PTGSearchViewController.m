//
//  PTGSearchViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGSearchViewController.h"
#import "PTGPlace.h"
#import "PTGURLUtils.h"
#import "PTGPlaceListViewController.h"
#import "PTGLocationUtils.h"
#import <QuartzCore/QuartzCore.h>

@interface PTGSearchViewController ()

@end

@implementation PTGSearchViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *lastView = [self.view viewWithTag:111];
    scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, lastView.frame.origin.y + lastView.frame.size.height + 10);
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        searchTextField.layer.cornerRadius = 15;
        searchTextField.layer.borderWidth = 2;
        searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, searchTextField.frame.size.height)];
        searchTextField.leftView = view;
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
    }
}

-(void)setupFonts {
    [ICFontUtils applyFont:QLASSIK_TB forView:headerLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:firstSearchLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:secondSearchLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:secondSearchButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:searchByTypeButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:searchByCategoryButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:firstSearchButton];
    
    headerLabel.text = NSLocalizedString(headerLabel.text, @"");
    firstSearchLabel.text = NSLocalizedString(firstSearchLabel.text, @"");
    secondSearchLabel.text = NSLocalizedString(secondSearchLabel.text, @"");
    searchTextField.placeholder = NSLocalizedString(searchTextField.placeholder, @"");
    
    [firstSearchButton setTitle:NSLocalizedString(firstSearchButton.titleLabel.text, @"")
                       forState:UIControlStateNormal];
    [secondSearchButton setTitle:NSLocalizedString(secondSearchButton.titleLabel.text, @"")
                        forState:UIControlStateNormal];
    [searchByCategoryButton setTitle:NSLocalizedString(searchByCategoryButton.titleLabel.text, @"")
                            forState:UIControlStateNormal];
    [searchByTypeButton setTitle:NSLocalizedString(searchByTypeButton.titleLabel.text, @"")
                        forState:UIControlStateNormal];
    [pickerCancelbutton setTitle:NSLocalizedString(@"Annulla", @"") forState:UIControlStateNormal];
    [pickerDoneButton setTitle:NSLocalizedString(@"Conferma", @"") forState:UIControlStateNormal];
    
}

- (IBAction)pickerDoneButtonPressed:(id)sender {
    if(!selectedCategory) {
        selectedCategory = [datasource objectAtIndex:[pickerView selectedRowInComponent:0]];
        [searchByCategoryButton setTitle:selectedCategory.name forState:UIControlStateNormal];
    }
    else {
        selectedSubcategory = [datasource objectAtIndex:[pickerView selectedRowInComponent:0]];
        [searchByTypeButton setTitle:selectedSubcategory.name forState:UIControlStateNormal];
    }
    
    [self togglePicker:YES];
}

- (IBAction)pickerCancelButtonPressed:(id)sender {
    [self togglePicker:YES];
}

- (IBAction)searchByKeywordTapped:(id)sender {
    if([searchTextField.text length] <= 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Keyword to short!", @"")
                                                        message:NSLocalizedString(@"Please enter a longer keyword. The keyword must have at least 4 characters.",  @"")
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"Got it",@"")
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        [searchTextField resignFirstResponder];
        [self fireRequest];
    }
}

-(void)fireRequest {
    [[PTGLocationUtils sharedInstance] getLocationWithCompletionBlock:^(CLLocation *location) {
        NSString *searchUrl = [[PTGURLUtils placesSearchUrl] stringByAppendingString:searchTextField.text];
        searchUrl = [searchUrl stringByAppendingFormat:@"/%f/%f", location.coordinate.latitude, location.coordinate.longitude];
        [PTGPlace placesForUrl:searchUrl succes:^(NSString *requestUrl, NSArray *products) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if([products count] == 0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No search results!", @"")
                                                                    message:[NSLocalizedString(@"We didn't found any place matching ", @"") stringByAppendingString:searchTextField.text]
                                                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                else {
                    PTGPlaceListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PTGPlaceListViewController"];
                    vc.breadcrumbs = @[NSLocalizedString(@"Cerca", @""), searchTextField.text];
                    vc.downloadedProducts = products;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            });
            
        } failure:^(NSString *requestUrl, NSError *error) {
            
        }];
    }];

}
-(void)togglePicker:(BOOL)shouldHide {
        [UIView animateWithDuration:0.5 animations:^{
            if(shouldHide) {
            pickerContainer.frame = CGRectMake(pickerContainer.frame.origin.x,
                                               self.view.frame.size.height,
                                               pickerContainer.frame.size.width,
                                               pickerContainer.frame.size.height);
            }
            else {
                pickerContainer.frame = CGRectMake(pickerContainer.frame.origin.x,
                                                   self.view.frame.size.height - pickerContainer.frame.size.height,
                                                   pickerContainer.frame.size.width,
                                                   pickerContainer.frame.size.height);
                
            }
        }];
}


- (IBAction)showCategoryPicker:(id)sender {
    [searchTextField resignFirstResponder];
    datasource = [PTGCategory firstLevelCategories];
    selectedCategory = nil;
    [pickerView reloadAllComponents];
    [self togglePicker:NO];
}

- (IBAction)showTypesPicker:(id)sender {
    [searchTextField resignFirstResponder];
    if(VALID(selectedCategory, PTGCategory)) {
        datasource = [selectedCategory allSubcategories];
        [pickerView reloadAllComponents];
        [self togglePicker:NO];
    }
    else {
        
    }
}

- (IBAction)searchByCategoryPressed:(id)sender {
    if(VALID(selectedCategory, PTGCategory)) {
        PTGPlaceListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PTGPlaceListViewController"];
        vc.parentCategory = selectedSubcategory;
        vc.breadcrumbs = @[NSLocalizedString(@"Cerca", @""), selectedSubcategory.name];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma makr - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - UIPikerViewDlegate & Datasource

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [datasource count]  == 0 ? 1 : [datasource count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    PTGCategory *category = [datasource objectAtIndex:row];
    return category.name;
}

@end
