// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGCategory.m instead.

#import "_PTGCategory.h"

const struct PTGCategoryAttributes PTGCategoryAttributes = {
	.categoryId = @"categoryId",
	.imageType = @"imageType",
	.name = @"name",
	.parrentId = @"parrentId",
	.placesCount = @"placesCount",
	.position = @"position",
	.subcategoryCount = @"subcategoryCount",
	.type = @"type",
};

const struct PTGCategoryRelationships PTGCategoryRelationships = {
	.children = @"children",
	.parent = @"parent",
	.places = @"places",
};

const struct PTGCategoryFetchedProperties PTGCategoryFetchedProperties = {
};

@implementation PTGCategoryID
@end

@implementation _PTGCategory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PTGCategory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PTGCategory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PTGCategory" inManagedObjectContext:moc_];
}

- (PTGCategoryID*)objectID {
	return (PTGCategoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"placesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"placesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"subcategoryCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"subcategoryCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic categoryId;






@dynamic imageType;






@dynamic name;






@dynamic parrentId;






@dynamic placesCount;



- (int32_t)placesCountValue {
	NSNumber *result = [self placesCount];
	return [result intValue];
}

- (void)setPlacesCountValue:(int32_t)value_ {
	[self setPlacesCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePlacesCountValue {
	NSNumber *result = [self primitivePlacesCount];
	return [result intValue];
}

- (void)setPrimitivePlacesCountValue:(int32_t)value_ {
	[self setPrimitivePlacesCount:[NSNumber numberWithInt:value_]];
}





@dynamic position;






@dynamic subcategoryCount;



- (int32_t)subcategoryCountValue {
	NSNumber *result = [self subcategoryCount];
	return [result intValue];
}

- (void)setSubcategoryCountValue:(int32_t)value_ {
	[self setSubcategoryCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSubcategoryCountValue {
	NSNumber *result = [self primitiveSubcategoryCount];
	return [result intValue];
}

- (void)setPrimitiveSubcategoryCountValue:(int32_t)value_ {
	[self setPrimitiveSubcategoryCount:[NSNumber numberWithInt:value_]];
}





@dynamic type;






@dynamic children;

	
- (NSMutableSet*)childrenSet {
	[self willAccessValueForKey:@"children"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"children"];
  
	[self didAccessValueForKey:@"children"];
	return result;
}
	

@dynamic parent;

	

@dynamic places;

	
- (NSMutableSet*)placesSet {
	[self willAccessValueForKey:@"places"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"places"];
  
	[self didAccessValueForKey:@"places"];
	return result;
}
	






#if TARGET_OS_IPHONE


- (NSFetchedResultsController*)newChildrenFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors {
	NSFetchRequest *fetchRequest = [NSFetchRequest new];
	
	fetchRequest.entity = [NSEntityDescription entityForName:@"PTGCategory" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"parent == %@", self];
	fetchRequest.sortDescriptors = sortDescriptors;
	
	return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											   managedObjectContext:self.managedObjectContext
												 sectionNameKeyPath:nil
														  cacheName:nil];
}





- (NSFetchedResultsController*)newPlacesFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors {
	NSFetchRequest *fetchRequest = [NSFetchRequest new];
	
	fetchRequest.entity = [NSEntityDescription entityForName:@"PTGPlace" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %@", self];
	fetchRequest.sortDescriptors = sortDescriptors;
	
	return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											   managedObjectContext:self.managedObjectContext
												 sectionNameKeyPath:nil
														  cacheName:nil];
}


#endif

@end
