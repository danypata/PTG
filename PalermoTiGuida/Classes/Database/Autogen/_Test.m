// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Test.m instead.

#import "_Test.h"

const struct TestAttributes TestAttributes = {
	.attribute = @"attribute",
	.test = @"test",
};

const struct TestRelationships TestRelationships = {
};

const struct TestFetchedProperties TestFetchedProperties = {
};

@implementation TestID
@end

@implementation _Test

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Test" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Test";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Test" inManagedObjectContext:moc_];
}

- (TestID*)objectID {
	return (TestID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"attributeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"attribute"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic attribute;



- (int16_t)attributeValue {
	NSNumber *result = [self attribute];
	return [result shortValue];
}

- (void)setAttributeValue:(int16_t)value_ {
	[self setAttribute:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAttributeValue {
	NSNumber *result = [self primitiveAttribute];
	return [result shortValue];
}

- (void)setPrimitiveAttributeValue:(int16_t)value_ {
	[self setPrimitiveAttribute:[NSNumber numberWithShort:value_]];
}





@dynamic test;











#if TARGET_OS_IPHONE

#endif

@end
