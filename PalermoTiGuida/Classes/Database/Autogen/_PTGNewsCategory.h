// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGNewsCategory.h instead.

#import <CoreData/CoreData.h>


extern const struct PTGNewsCategoryAttributes {
	__unsafe_unretained NSString *categoryType;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *newNews;
	__unsafe_unretained NSString *newsCategoryId;
	__unsafe_unretained NSString *newsCount;
} PTGNewsCategoryAttributes;

extern const struct PTGNewsCategoryRelationships {
	__unsafe_unretained NSString *children;
	__unsafe_unretained NSString *news;
	__unsafe_unretained NSString *parent;
} PTGNewsCategoryRelationships;

extern const struct PTGNewsCategoryFetchedProperties {
} PTGNewsCategoryFetchedProperties;

@class PTGNewsCategory;
@class PTGNews;
@class PTGNewsCategory;







@interface PTGNewsCategoryID : NSManagedObjectID {}
@end

@interface _PTGNewsCategory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PTGNewsCategoryID*)objectID;





@property (nonatomic, strong) NSString* categoryType;



//- (BOOL)validateCategoryType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* newNews;



@property int32_t newNewsValue;
- (int32_t)newNewsValue;
- (void)setNewNewsValue:(int32_t)value_;

//- (BOOL)validateNewNews:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* newsCategoryId;



//- (BOOL)validateNewsCategoryId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* newsCount;



//- (BOOL)validateNewsCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *children;

- (NSMutableSet*)childrenSet;




@property (nonatomic, strong) NSSet *news;

- (NSMutableSet*)newsSet;




@property (nonatomic, strong) PTGNewsCategory *parent;

//- (BOOL)validateParent:(id*)value_ error:(NSError**)error_;





#if TARGET_OS_IPHONE


- (NSFetchedResultsController*)newChildrenFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors;



- (NSFetchedResultsController*)newNewsFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors;




#endif

@end

@interface _PTGNewsCategory (CoreDataGeneratedAccessors)

- (void)addChildren:(NSSet*)value_;
- (void)removeChildren:(NSSet*)value_;
- (void)addChildrenObject:(PTGNewsCategory*)value_;
- (void)removeChildrenObject:(PTGNewsCategory*)value_;

- (void)addNews:(NSSet*)value_;
- (void)removeNews:(NSSet*)value_;
- (void)addNewsObject:(PTGNews*)value_;
- (void)removeNewsObject:(PTGNews*)value_;

@end

@interface _PTGNewsCategory (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategoryType;
- (void)setPrimitiveCategoryType:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveNewNews;
- (void)setPrimitiveNewNews:(NSNumber*)value;

- (int32_t)primitiveNewNewsValue;
- (void)setPrimitiveNewNewsValue:(int32_t)value_;




- (NSString*)primitiveNewsCategoryId;
- (void)setPrimitiveNewsCategoryId:(NSString*)value;




- (NSString*)primitiveNewsCount;
- (void)setPrimitiveNewsCount:(NSString*)value;





- (NSMutableSet*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableSet*)value;



- (NSMutableSet*)primitiveNews;
- (void)setPrimitiveNews:(NSMutableSet*)value;



- (PTGNewsCategory*)primitiveParent;
- (void)setPrimitiveParent:(PTGNewsCategory*)value;


@end
