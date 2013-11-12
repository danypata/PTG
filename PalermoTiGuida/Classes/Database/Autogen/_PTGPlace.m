// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGPlace.m instead.

#import "_PTGPlace.h"

const struct PTGPlaceAttributes PTGPlaceAttributes = {
	.airportPrice = @"airportPrice",
	.categoryId = @"categoryId",
	.categoryType = @"categoryType",
	.city = @"city",
	.descriptionText = @"descriptionText",
	.distance = @"distance",
	.faxes = @"faxes",
	.lat = @"lat",
	.longit = @"longit",
	.mainImage = @"mainImage",
	.name = @"name",
	.openDayTo = @"openDayTo",
	.openTimeAMFrom = @"openTimeAMFrom",
	.openTimeAMTo = @"openTimeAMTo",
	.openTimePMFrom = @"openTimePMFrom",
	.openTimePMTo = @"openTimePMTo",
	.opendayFrom = @"opendayFrom",
	.phones = @"phones",
	.placeBoardId = @"placeBoardId",
	.placeBoardName = @"placeBoardName",
	.placeDescription = @"placeDescription",
	.placeId = @"placeId",
	.placePortId = @"placePortId",
	.placePortName = @"placePortName",
	.province = @"province",
	.slides = @"slides",
	.stationNumber = @"stationNumber",
	.stops = @"stops",
	.street = @"street",
	.streetNo = @"streetNo",
	.urbanPrice = @"urbanPrice",
	.webAddresses = @"webAddresses",
	.zipCode = @"zipCode",
};

const struct PTGPlaceRelationships PTGPlaceRelationships = {
	.category = @"category",
	.diaryItem = @"diaryItem",
	.news = @"news",
};

const struct PTGPlaceFetchedProperties PTGPlaceFetchedProperties = {
};

@implementation PTGPlaceID
@end

@implementation _PTGPlace

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PTGPlace" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PTGPlace";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PTGPlace" inManagedObjectContext:moc_];
}

- (PTGPlaceID*)objectID {
	return (PTGPlaceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic airportPrice;






@dynamic categoryId;






@dynamic categoryType;






@dynamic city;






@dynamic descriptionText;






@dynamic distance;






@dynamic faxes;






@dynamic lat;






@dynamic longit;






@dynamic mainImage;






@dynamic name;






@dynamic openDayTo;






@dynamic openTimeAMFrom;






@dynamic openTimeAMTo;






@dynamic openTimePMFrom;






@dynamic openTimePMTo;






@dynamic opendayFrom;






@dynamic phones;






@dynamic placeBoardId;






@dynamic placeBoardName;






@dynamic placeDescription;






@dynamic placeId;






@dynamic placePortId;






@dynamic placePortName;






@dynamic province;






@dynamic slides;






@dynamic stationNumber;






@dynamic stops;






@dynamic street;






@dynamic streetNo;






@dynamic urbanPrice;






@dynamic webAddresses;






@dynamic zipCode;






@dynamic category;

	

@dynamic diaryItem;

	

@dynamic news;

	
- (NSMutableSet*)newsSet {
	[self willAccessValueForKey:@"news"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"news"];
  
	[self didAccessValueForKey:@"news"];
	return result;
}
	






#if TARGET_OS_IPHONE






- (NSFetchedResultsController*)newNewsFetchedResultsControllerWithSortDescriptors:(NSArray*)sortDescriptors {
	NSFetchRequest *fetchRequest = [NSFetchRequest new];
	
	fetchRequest.entity = [NSEntityDescription entityForName:@"PTGNews" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"place == %@", self];
	fetchRequest.sortDescriptors = sortDescriptors;
	
	return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											   managedObjectContext:self.managedObjectContext
												 sectionNameKeyPath:nil
														  cacheName:nil];
}


#endif

@end
