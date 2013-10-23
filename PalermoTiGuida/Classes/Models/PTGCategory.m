#import "PTGCategory.h"
#import "PTGURLUtils.h"
#import "PTGPlace.h"
#import "PTGLocationUtils.h"
@interface PTGCategory ()

// Private interface goes here.

@end


@implementation PTGCategory

+(PTGCategory *)categoryFromDictionary:(NSDictionary *)dictionary usingCategory:(PTGCategory *)category context:(NSManagedObjectContext *)context{
    if(context == nil) {
        context = [NSManagedObjectContext contextForCurrentThread];
    }
    if(!VALID(category, PTGCategory)) {
        category = [PTGCategory createEntity];
    }
    category.categoryId = [dictionary objectForKey:categoryKeyId];
    category.name = [dictionary objectForKey:categoryKeyName];
    category.parrentId = [dictionary objectForKey:categoryKeyParentId];
    category.type = [dictionary objectForKey:categoryKeyType];
    category.position = [dictionary objectForKey:categoryKeyPostion];
    category.imageType = [dictionary objectForKey:categoryKeyImageType];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    category.placesCount = [formatter numberFromString:[dictionary objectForKey:categoryKeyPlacesCount]];
    category.subcategoryCount = [formatter numberFromString:[dictionary objectForKey:categoryKeyCategoryCount]];
    return category;
}

+(PTGCategory *)firstLevelCategoryWithName:(NSString *)name {
    NSArray *firstLevel = [self firstLevelCategories];
    for(PTGCategory *category in firstLevel) {
        if([category.name compare:name options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return category;
        }
    }
    return nil;
}

+(NSArray *)firstLevelCategories {
    NSArray *resutls = [PTGCategory findAllWithPredicate:[NSPredicate predicateWithFormat:@"parrentId == 1"] inContext:[NSManagedObjectContext defaultContext]];
    return [resutls filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(PTGCategory *evaluatedObject, NSDictionary *bindings) {
        if([evaluatedObject.children count] == 0) {
            return NO;
        }
        return YES;
    }]];
    
}

-(NSArray *)childCategories {
    return [[self.children allObjects] sortedArrayUsingComparator:^NSComparisonResult(PTGCategory *obj1, PTGCategory *obj2) {
        return [obj1.position compare:obj2.position];
    }];
}

+(void)loadCategoriesFromServerWithSuccess:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSString *requestUrl, NSError *))failureBlock {
    [[SMFWebService sharedInstance] sendJSONRequestWithURLString:[PTGURLUtils mainCategoryUrl]
                                                          method:@"GET"
                                                      parameters:nil
                                        withResponseOnMainThread:NO
                                                         success:^(NSString *requestURL, id JSON) {
                                                             if(VALID_NOTEMPTY(JSON, NSDictionary)) {
                                                                 [self parseCatgoriesFromJSON:JSON];
                                                                 successBlock([PTGCategory firstLevelCategories]);
                                                             }
                                                             else {
                                                                 failureBlock(requestURL, [NSError errorWithDomain:@"Invalid JSON format" code:1910 userInfo:nil]);
                                                             }
                                                             
                                                         } failure:^(NSString *requestURL, NSError *error) {
                                                             failureBlock(requestURL, error);
                                                         }];
}


-(NSArray *)allSubcategories {
    NSMutableArray *allSubcategories = [NSMutableArray new];
    for(PTGCategory *category in self.children) {
        if([category.children count] == 0) {
            [allSubcategories addObject:category];
        }
        else {
            [allSubcategories addObjectsFromArray:[category allSubcategories]];
        }
    }
    return allSubcategories;
}

-(void)loadPlacesWithSuccess:(void(^)(NSArray *products))successBlock
                     failure:(void(^)(NSString *requestUrl, NSError *error))failureBlock {
    __block CLLocation *oldLocation = nil;
    [[PTGLocationUtils sharedInstance] getLocationWithCompletionBlock:^(CLLocation *location) {
        if(oldLocation.coordinate.latitude != location.coordinate.latitude
           && oldLocation.coordinate.longitude != location.coordinate.longitude) {
            oldLocation = location;
            
            NSString *url = [[PTGURLUtils categoryPlacesUrl] stringByAppendingString:self.categoryId];
            url =[url stringByAppendingFormat:@"/%f/%f",location.coordinate.latitude, location.coordinate.longitude];
            [PTGPlace placesForUrl:url succes:^(NSString *requestUrl, NSArray *products) {
                NSArray *finalProducts = [PTGPlace findAllWithPredicate:[NSPredicate predicateWithFormat:@"self in %@", [products valueForKey:@"objectID"]] inContext:self.managedObjectContext];
                [self addPlaces:[NSSet setWithArray:finalProducts]];
                successBlock([self.places allObjects]);
            } failure:failureBlock];
        }
    }];
}

+(void)parseCatgoriesFromJSON:(id)JSON {
    NSArray *mainCategories = [JSON objectForKey:categoryKeyRoot];
    NSManagedObjectContext *context = [NSManagedObjectContext contextForCurrentThread];
    [self getCategoriesFromArray:mainCategories context:context];
    [context saveToPersistentStoreAndWait];
}

+(NSArray *)getCategoriesFromArray:(NSArray *)array context:(NSManagedObjectContext *)context {
    NSMutableArray *categories = [NSMutableArray new];
    NSArray *allCategories = [PTGCategory findAll];
    for(NSDictionary *dict in array) {
        PTGCategory *category = [self isCategoryWithIDAdded:[dict objectForKey:categoryKeyId] allCategories:allCategories];
        category = [PTGCategory categoryFromDictionary:dict usingCategory:category context:context];
        if(VALID_NOTEMPTY([dict objectForKey:@"child"], NSArray)) {
            NSArray *children = [NSArray arrayWithArray:[PTGCategory getCategoriesFromArray:[dict objectForKey:@"child"] context:context]];
            [category setChildren:[NSSet setWithArray:children]];
        }
        if(VALID(category, PTGCategory)) {
            [categories addObject:category];
        }
    }
    return categories;
}

+(PTGCategory *)isCategoryWithIDAdded:(NSString *)categoryId allCategories:(NSArray *)all {
    if(!VALID_NOTEMPTY(all, NSArray)) {
        return nil;
    }
    else {
        for(PTGCategory *category in all) {
            if([category.categoryId isEqualToString:categoryId]) {
                return category;
            }
        }
    }
    return nil;
}


@end
