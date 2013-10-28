// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGNewsCategory.m instead.

#import "_PTGNewsCategory.h"

const struct PTGNewsCategoryAttributes PTGNewsCategoryAttributes = {
	.categoryType = @"categoryType",
	.name = @"name",
	.newNews = @"newNews",
	.newsCategoryId = @"newsCategoryId",
	.newsCount = @"newsCount",
};

const struct PTGNewsCategoryRelationships PTGNewsCategoryRelationships = {
	.children = @"children",
	.news = @"news",
	.parent = @"parent",
};

const struct PTGNewsCategoryFetchedProperties PTGNewsCategoryFetchedProperties = {
};

@implementation PTGNewsCategoryID
@end

@implementation _PTGNewsCategory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PTGNewsCategory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PTGNewsCategory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PTGNewsCategory" inManagedObjectContext:moc_];
}

- (PTGNewsCategoryID*)objectID {
	return (PTGNewsCategoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"newNewsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"newNews"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic categoryType;






@dynamic name;






@dynamic newNews;



- (int32_t)newNewsValue {
	NSNumber *result = [self newNews];
	return [result intValue];
}

- (void)setNewNewsValue:(int32_t)value_ {
	[self setNewNews:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveNewNewsValue {
	NSNumber *result = [self primitiveNewNews];
	return [result intValue];
}

- (void)setPrimitiveNewNewsValue:(int32_t)value_ {
	[self setPrimitiveNewNews:[NSNumber numberWithInt:value_]];
}





@dynamic newsCategoryId;






@dynamic newsCount;






@dynamic children;

	
- (NSMutableSet*)childrenSet {
	[self willAccessValueForKey:@"children"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"children"];
  
	[self didAccessValueForKey:@"children"];
	return result;
}
	

@dynamic news;

	
- (NSMutableSet*)newsSet {
	[self willAccessValueForKey:@"news"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"news"];
  
	[self didAccessValueForKey:@"news"];
	return result;
}
	

@dynamic parent;

	






#if TARGET_OS_IPHONE


- (NSFetchedResultsController*)newChildrenFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors {
	NSFetchRequest *fetchRequest = [NSFetchRequest new];
	
	fetchRequest.entity = [NSEntityDescription entityForName:@"PTGNewsCategory" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"parent == %@", self];
	fetchRequest.sortDescriptors = sortDescriptors;
	
	return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											   managedObjectContext:self.managedObjectContext
												 sectionNameKeyPath:nil
														  cacheName:nil];
}



- (NSFetchedResultsController*)newNewsFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors {
	NSFetchRequest *fetchRequest = [NSFetchRequest new];
	
	fetchRequest.entity = [NSEntityDescription entityForName:@"PTGNews" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"category == %@", self];
	fetchRequest.sortDescriptors = sortDescriptors;
	
	return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											   managedObjectContext:self.managedObjectContext
												 sectionNameKeyPath:nil
														  cacheName:nil];
}




#endif

@end
