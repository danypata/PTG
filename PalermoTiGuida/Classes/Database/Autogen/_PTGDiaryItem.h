// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGDiaryItem.h instead.

#import <CoreData/CoreData.h>


extern const struct PTGDiaryItemAttributes {
	__unsafe_unretained NSString *isVisited;
} PTGDiaryItemAttributes;

extern const struct PTGDiaryItemRelationships {
	__unsafe_unretained NSString *place;
} PTGDiaryItemRelationships;

extern const struct PTGDiaryItemFetchedProperties {
} PTGDiaryItemFetchedProperties;

@class PTGPlace;



@interface PTGDiaryItemID : NSManagedObjectID {}
@end

@interface _PTGDiaryItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PTGDiaryItemID*)objectID;





@property (nonatomic, strong) NSNumber* isVisited;



@property BOOL isVisitedValue;
- (BOOL)isVisitedValue;
- (void)setIsVisitedValue:(BOOL)value_;

//- (BOOL)validateIsVisited:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PTGPlace *place;

//- (BOOL)validatePlace:(id*)value_ error:(NSError**)error_;





#if TARGET_OS_IPHONE



#endif

@end

@interface _PTGDiaryItem (CoreDataGeneratedAccessors)

@end

@interface _PTGDiaryItem (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIsVisited;
- (void)setPrimitiveIsVisited:(NSNumber*)value;

- (BOOL)primitiveIsVisitedValue;
- (void)setPrimitiveIsVisitedValue:(BOOL)value_;





- (PTGPlace*)primitivePlace;
- (void)setPrimitivePlace:(PTGPlace*)value;


@end
