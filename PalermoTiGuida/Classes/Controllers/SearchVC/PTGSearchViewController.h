//
//  PTGSearchViewController.h
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGCategory.h"
@interface PTGSearchViewController : PTGBaseViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{

    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *firstSearchLabel;
    
    IBOutlet UILabel *secondSearchLabel;
    IBOutlet UITextField *searchTextField;
   
    IBOutlet UIButton *secondSearchButton;
    IBOutlet UIButton *searchByTypeButton;
    IBOutlet UIButton *searchByCategoryButton;
    IBOutlet UIButton *firstSearchButton;
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIButton *pickerDoneButton;
    
    IBOutlet UIView *pickerContainer;
    IBOutlet UIButton *pickerCancelbutton;
    IBOutlet UIPickerView *pickerView;
    
    PTGCategory *selectedCategory;
    PTGCategory *selectedSubcategory;
    NSArray *datasource;
}
- (IBAction)pickerDoneButtonPressed:(id)sender;
- (IBAction)pickerCancelButtonPressed:(id)sender;

- (IBAction)searchByKeywordTapped:(id)sender;
- (IBAction)showCategoryPicker:(id)sender;
- (IBAction)showTypesPicker:(id)sender;
- (IBAction)searchByCategoryPressed:(id)sender;

@end
