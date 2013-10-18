// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGCategory.h instead.

#import <CoreData/CoreData.h>


extern const struct PTGCategoryAttributes {
	__unsafe_unretained NSString *categoryId;
	__unsafe_unretained NSString *imageType;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *parrentId;
	__unsafe_unretained NSString *placesCount;
	__unsafe_unretained NSString *position;
	__unsafe_unretained NSString *subcategoryCount;
	__unsafe_unretained NSString *type;
} PTGCategoryAttributes;

extern const struct PTGCategoryRelationships {
	__unsafe_unretained NSString *children;
	__unsafe_unretained NSString *parent;
	__unsafe_unretained NSString *places;
} PTGCategoryRelationships;

extern const struct PTGCategoryFetchedProperties {
} PTGCategoryFetchedProperties;

@class PTGCategory;
@class PTGCategory;
@class PTGPlace;










@interface PTGCategoryID : NSManagedObjectID {}
@end

@interface _PTGCategory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PTGCategoryID*)objectID;





@property (nonatomic, strong) NSString* categoryId;



//- (BOOL)validateCategoryId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* imageType;



//- (BOOL)validateImageType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* parrentId;



//- (BOOL)validateParrentId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* placesCount;



@property int32_t placesCountValue;
- (int32_t)placesCountValue;
- (void)setPlacesCountValue:(int32_t)value_;

//- (BOOL)validatePlacesCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* position;



//- (BOOL)validatePosition:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* subcategoryCount;



@property int32_t subcategoryCountValue;
- (int32_t)subcategoryCountValue;
- (void)setSubcategoryCountValue:(int32_t)value_;

//- (BOOL)validateSubcategoryCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* type;



//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *children;

- (NSMutableSet*)childrenSet;




@property (nonatomic, strong) PTGCategory *parent;

//- (BOOL)validateParent:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *places;

- (NSMutableSet*)placesSet;





#if TARGET_OS_IPHONE


- (NSFetchedResultsController*)newChildrenFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors;





- (NSFetchedResultsController*)newPlacesFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors;


#endif

@end

@interface _PTGCategory (CoreDataGeneratedAccessors)

- (void)addChildren:(NSSet*)value_;
- (void)removeChildren:(NSSet*)value_;
- (void)addChildrenObject:(PTGCategory*)value_;
- (void)removeChildrenObject:(PTGCategory*)value_;

- (void)addPlaces:(NSSet*)value_;
- (void)removePlaces:(NSSet*)value_;
- (void)addPlacesObject:(PTGPlace*)value_;
- (void)removePlacesObject:(PTGPlace*)value_;

@end

@interface _PTGCategory (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategoryId;
- (void)setPrimitiveCategoryId:(NSString*)value;




- (NSString*)primitiveImageType;
- (void)setPrimitiveImageType:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveParrentId;
- (void)setPrimitiveParrentId:(NSString*)value;




- (NSNumber*)primitivePlacesCount;
- (void)setPrimitivePlacesCount:(NSNumber*)value;

- (int32_t)primitivePlacesCountValue;
- (void)setPrimitivePlacesCountValue:(int32_t)value_;




- (NSString*)primitivePosition;
- (void)setPrimitivePosition:(NSString*)value;




- (NSNumber*)primitiveSubcategoryCount;
- (void)setPrimitiveSubcategoryCount:(NSNumber*)value;

- (int32_t)primitiveSubcategoryCountValue;
- (void)setPrimitiveSubcategoryCountValue:(int32_t)value_;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;





- (NSMutableSet*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableSet*)value;



- (PTGCategory*)primitiveParent;
- (void)setPrimitiveParent:(PTGCategory*)value;



- (NSMutableSet*)primitivePlaces;
- (void)setPrimitivePlaces:(NSMutableSet*)value;


@end
