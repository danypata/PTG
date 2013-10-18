// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Test.h instead.

#import <CoreData/CoreData.h>


extern const struct TestAttributes {
	__unsafe_unretained NSString *attribute;
	__unsafe_unretained NSString *test;
} TestAttributes;

extern const struct TestRelationships {
} TestRelationships;

extern const struct TestFetchedProperties {
} TestFetchedProperties;





@interface TestID : NSManagedObjectID {}
@end

@interface _Test : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TestID*)objectID;





@property (nonatomic, strong) NSNumber* attribute;



@property int16_t attributeValue;
- (int16_t)attributeValue;
- (void)setAttributeValue:(int16_t)value_;

//- (BOOL)validateAttribute:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* test;



//- (BOOL)validateTest:(id*)value_ error:(NSError**)error_;






#if TARGET_OS_IPHONE

#endif

@end

@interface _Test (CoreDataGeneratedAccessors)

@end

@interface _Test (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAttribute;
- (void)setPrimitiveAttribute:(NSNumber*)value;

- (int16_t)primitiveAttributeValue;
- (void)setPrimitiveAttributeValue:(int16_t)value_;




- (NSString*)primitiveTest;
- (void)setPrimitiveTest:(NSString*)value;




@end
