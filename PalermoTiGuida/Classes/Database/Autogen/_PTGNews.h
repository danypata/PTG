// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGNews.h instead.

#import <CoreData/CoreData.h>


extern const struct PTGNewsAttributes {
	__unsafe_unretained NSString *alert;
	__unsafe_unretained NSString *categoryId;
	__unsafe_unretained NSString *categoryType;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *descriptionText;
	__unsafe_unretained NSString *mail;
	__unsafe_unretained NSString *newsId;
	__unsafe_unretained NSString *phone;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *validFrom;
	__unsafe_unretained NSString *validTo;
	__unsafe_unretained NSString *web;
} PTGNewsAttributes;

extern const struct PTGNewsRelationships {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *place;
} PTGNewsRelationships;

extern const struct PTGNewsFetchedProperties {
} PTGNewsFetchedProperties;

@class PTGNewsCategory;
@class PTGPlace;














@interface PTGNewsID : NSManagedObjectID {}
@end

@interface _PTGNews : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PTGNewsID*)objectID;





@property (nonatomic, strong) NSString* alert;



//- (BOOL)validateAlert:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* categoryId;



//- (BOOL)validateCategoryId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* categoryType;



//- (BOOL)validateCategoryType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* date;



//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* descriptionText;



//- (BOOL)validateDescriptionText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mail;



//- (BOOL)validateMail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* newsId;



//- (BOOL)validateNewsId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* phone;



//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* validFrom;



//- (BOOL)validateValidFrom:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* validTo;



//- (BOOL)validateValidTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* web;



//- (BOOL)validateWeb:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PTGNewsCategory *category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PTGPlace *place;

//- (BOOL)validatePlace:(id*)value_ error:(NSError**)error_;





#if TARGET_OS_IPHONE





#endif

@end

@interface _PTGNews (CoreDataGeneratedAccessors)

@end

@interface _PTGNews (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAlert;
- (void)setPrimitiveAlert:(NSString*)value;




- (NSString*)primitiveCategoryId;
- (void)setPrimitiveCategoryId:(NSString*)value;




- (NSString*)primitiveCategoryType;
- (void)setPrimitiveCategoryType:(NSString*)value;




- (NSString*)primitiveDate;
- (void)setPrimitiveDate:(NSString*)value;




- (NSString*)primitiveDescriptionText;
- (void)setPrimitiveDescriptionText:(NSString*)value;




- (NSString*)primitiveMail;
- (void)setPrimitiveMail:(NSString*)value;




- (NSString*)primitiveNewsId;
- (void)setPrimitiveNewsId:(NSString*)value;




- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSString*)primitiveValidFrom;
- (void)setPrimitiveValidFrom:(NSString*)value;




- (NSString*)primitiveValidTo;
- (void)setPrimitiveValidTo:(NSString*)value;




- (NSString*)primitiveWeb;
- (void)setPrimitiveWeb:(NSString*)value;





- (PTGNewsCategory*)primitiveCategory;
- (void)setPrimitiveCategory:(PTGNewsCategory*)value;



- (PTGPlace*)primitivePlace;
- (void)setPrimitivePlace:(PTGPlace*)value;


@end
