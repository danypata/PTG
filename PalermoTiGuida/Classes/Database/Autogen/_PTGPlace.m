// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGPlace.m instead.

#import "_PTGPlace.h"

const struct PTGPlaceAttributes PTGPlaceAttributes = {
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
	.street = @"street",
	.streetNo = @"streetNo",
	.webAddresses = @"webAddresses",
	.zipCode = @"zipCode",
};

const struct PTGPlaceRelationships PTGPlaceRelationships = {
	.category = @"category",
	.diaryItem = @"diaryItem",
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






@dynamic street;






@dynamic streetNo;






@dynamic webAddresses;






@dynamic zipCode;






@dynamic category;

	

@dynamic diaryItem;

	






#if TARGET_OS_IPHONE





#endif

@end
