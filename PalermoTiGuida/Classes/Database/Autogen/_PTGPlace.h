// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGPlace.h instead.

#import <CoreData/CoreData.h>


extern const struct PTGPlaceAttributes {
	__unsafe_unretained NSString *categoryType;
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *descriptionText;
	__unsafe_unretained NSString *distance;
	__unsafe_unretained NSString *faxes;
	__unsafe_unretained NSString *lat;
	__unsafe_unretained NSString *longit;
	__unsafe_unretained NSString *mainImage;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *openDayTo;
	__unsafe_unretained NSString *openTimeAMFrom;
	__unsafe_unretained NSString *openTimeAMTo;
	__unsafe_unretained NSString *openTimePMFrom;
	__unsafe_unretained NSString *openTimePMTo;
	__unsafe_unretained NSString *opendayFrom;
	__unsafe_unretained NSString *phones;
	__unsafe_unretained NSString *placeBoardId;
	__unsafe_unretained NSString *placeBoardName;
	__unsafe_unretained NSString *placeDescription;
	__unsafe_unretained NSString *placeId;
	__unsafe_unretained NSString *placePortId;
	__unsafe_unretained NSString *placePortName;
	__unsafe_unretained NSString *province;
	__unsafe_unretained NSString *slides;
	__unsafe_unretained NSString *street;
	__unsafe_unretained NSString *streetNo;
	__unsafe_unretained NSString *webAddresses;
	__unsafe_unretained NSString *zipCode;
} PTGPlaceAttributes;

extern const struct PTGPlaceRelationships {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *diaryItem;
} PTGPlaceRelationships;

extern const struct PTGPlaceFetchedProperties {
} PTGPlaceFetchedProperties;

@class PTGCategory;
@class PTGDiaryItem;






























@interface PTGPlaceID : NSManagedObjectID {}
@end

@interface _PTGPlace : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PTGPlaceID*)objectID;





@property (nonatomic, strong) NSString* categoryType;



//- (BOOL)validateCategoryType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* city;



//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* descriptionText;



//- (BOOL)validateDescriptionText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* distance;



//- (BOOL)validateDistance:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* faxes;



//- (BOOL)validateFaxes:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lat;



//- (BOOL)validateLat:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* longit;



//- (BOOL)validateLongit:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mainImage;



//- (BOOL)validateMainImage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* openDayTo;



//- (BOOL)validateOpenDayTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* openTimeAMFrom;



//- (BOOL)validateOpenTimeAMFrom:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* openTimeAMTo;



//- (BOOL)validateOpenTimeAMTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* openTimePMFrom;



//- (BOOL)validateOpenTimePMFrom:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* openTimePMTo;



//- (BOOL)validateOpenTimePMTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* opendayFrom;



//- (BOOL)validateOpendayFrom:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* phones;



//- (BOOL)validatePhones:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* placeBoardId;



//- (BOOL)validatePlaceBoardId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* placeBoardName;



//- (BOOL)validatePlaceBoardName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* placeDescription;



//- (BOOL)validatePlaceDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* placeId;



//- (BOOL)validatePlaceId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* placePortId;



//- (BOOL)validatePlacePortId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* placePortName;



//- (BOOL)validatePlacePortName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* province;



//- (BOOL)validateProvince:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* slides;



//- (BOOL)validateSlides:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* street;



//- (BOOL)validateStreet:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* streetNo;



//- (BOOL)validateStreetNo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* webAddresses;



//- (BOOL)validateWebAddresses:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* zipCode;



//- (BOOL)validateZipCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PTGCategory *category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) PTGDiaryItem *diaryItem;

//- (BOOL)validateDiaryItem:(id*)value_ error:(NSError**)error_;





#if TARGET_OS_IPHONE





#endif

@end

@interface _PTGPlace (CoreDataGeneratedAccessors)

@end

@interface _PTGPlace (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategoryType;
- (void)setPrimitiveCategoryType:(NSString*)value;




- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveDescriptionText;
- (void)setPrimitiveDescriptionText:(NSString*)value;




- (NSString*)primitiveDistance;
- (void)setPrimitiveDistance:(NSString*)value;




- (NSData*)primitiveFaxes;
- (void)setPrimitiveFaxes:(NSData*)value;




- (NSString*)primitiveLat;
- (void)setPrimitiveLat:(NSString*)value;




- (NSString*)primitiveLongit;
- (void)setPrimitiveLongit:(NSString*)value;




- (NSString*)primitiveMainImage;
- (void)setPrimitiveMainImage:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveOpenDayTo;
- (void)setPrimitiveOpenDayTo:(NSString*)value;




- (NSString*)primitiveOpenTimeAMFrom;
- (void)setPrimitiveOpenTimeAMFrom:(NSString*)value;




- (NSString*)primitiveOpenTimeAMTo;
- (void)setPrimitiveOpenTimeAMTo:(NSString*)value;




- (NSString*)primitiveOpenTimePMFrom;
- (void)setPrimitiveOpenTimePMFrom:(NSString*)value;




- (NSString*)primitiveOpenTimePMTo;
- (void)setPrimitiveOpenTimePMTo:(NSString*)value;




- (NSString*)primitiveOpendayFrom;
- (void)setPrimitiveOpendayFrom:(NSString*)value;




- (NSData*)primitivePhones;
- (void)setPrimitivePhones:(NSData*)value;




- (NSString*)primitivePlaceBoardId;
- (void)setPrimitivePlaceBoardId:(NSString*)value;




- (NSString*)primitivePlaceBoardName;
- (void)setPrimitivePlaceBoardName:(NSString*)value;




- (NSString*)primitivePlaceDescription;
- (void)setPrimitivePlaceDescription:(NSString*)value;




- (NSString*)primitivePlaceId;
- (void)setPrimitivePlaceId:(NSString*)value;




- (NSString*)primitivePlacePortId;
- (void)setPrimitivePlacePortId:(NSString*)value;




- (NSString*)primitivePlacePortName;
- (void)setPrimitivePlacePortName:(NSString*)value;




- (NSString*)primitiveProvince;
- (void)setPrimitiveProvince:(NSString*)value;




- (NSData*)primitiveSlides;
- (void)setPrimitiveSlides:(NSData*)value;




- (NSString*)primitiveStreet;
- (void)setPrimitiveStreet:(NSString*)value;




- (NSString*)primitiveStreetNo;
- (void)setPrimitiveStreetNo:(NSString*)value;




- (NSData*)primitiveWebAddresses;
- (void)setPrimitiveWebAddresses:(NSData*)value;




- (NSString*)primitiveZipCode;
- (void)setPrimitiveZipCode:(NSString*)value;





- (PTGCategory*)primitiveCategory;
- (void)setPrimitiveCategory:(PTGCategory*)value;



- (PTGDiaryItem*)primitiveDiaryItem;
- (void)setPrimitiveDiaryItem:(PTGDiaryItem*)value;


@end
