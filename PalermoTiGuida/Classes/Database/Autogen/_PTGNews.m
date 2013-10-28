// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PTGNews.m instead.

#import "_PTGNews.h"

const struct PTGNewsAttributes PTGNewsAttributes = {
	.alert = @"alert",
	.categoryId = @"categoryId",
	.categoryType = @"categoryType",
	.date = @"date",
	.descriptionText = @"descriptionText",
	.mail = @"mail",
	.newsId = @"newsId",
	.phone = @"phone",
	.title = @"title",
	.validFrom = @"validFrom",
	.validTo = @"validTo",
	.web = @"web",
};

const struct PTGNewsRelationships PTGNewsRelationships = {
	.category = @"category",
	.place = @"place",
};

const struct PTGNewsFetchedProperties PTGNewsFetchedProperties = {
};

@implementation PTGNewsID
@end

@implementation _PTGNews

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PTGNews" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PTGNews";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PTGNews" inManagedObjectContext:moc_];
}

- (PTGNewsID*)objectID {
	return (PTGNewsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic alert;






@dynamic categoryId;






@dynamic categoryType;






@dynamic date;






@dynamic descriptionText;






@dynamic mail;






@dynamic newsId;






@dynamic phone;






@dynamic title;






@dynamic validFrom;






@dynamic validTo;






@dynamic web;






@dynamic category;

	

@dynamic place;

	






#if TARGET_OS_IPHONE





#endif

@end
