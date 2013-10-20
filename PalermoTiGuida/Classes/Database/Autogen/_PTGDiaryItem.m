// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGDiaryItem.m instead.

#import "_PTGDiaryItem.h"

const struct PTGDiaryItemAttributes PTGDiaryItemAttributes = {
	.isVisited = @"isVisited",
};

const struct PTGDiaryItemRelationships PTGDiaryItemRelationships = {
	.place = @"place",
};

const struct PTGDiaryItemFetchedProperties PTGDiaryItemFetchedProperties = {
};

@implementation PTGDiaryItemID
@end

@implementation _PTGDiaryItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PTGDiaryItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PTGDiaryItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PTGDiaryItem" inManagedObjectContext:moc_];
}

- (PTGDiaryItemID*)objectID {
	return (PTGDiaryItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isVisitedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isVisited"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic isVisited;



- (BOOL)isVisitedValue {
	NSNumber *result = [self isVisited];
	return [result boolValue];
}

- (void)setIsVisitedValue:(BOOL)value_ {
	[self setIsVisited:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsVisitedValue {
	NSNumber *result = [self primitiveIsVisited];
	return [result boolValue];
}

- (void)setPrimitiveIsVisitedValue:(BOOL)value_ {
	[self setPrimitiveIsVisited:[NSNumber numberWithBool:value_]];
}





@dynamic place;

	






#if TARGET_OS_IPHONE



#endif

@end
