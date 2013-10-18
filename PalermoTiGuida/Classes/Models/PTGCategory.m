#import "PTGCategory.h"
#import "PTGURLUtils.h"
#import "PTGPlace.h"
#import "PTGLocationUtils.h"
@interface PTGCategory ()

// Private interface goes here.

@end


@implementation PTGCategory

+(PTGCategory *)categoryFromDictionary:(NSDictionary *)dictionary usingCategory:(PTGCategory *)category{
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
    category.subcategoryCount = [formatter numberFromString:[dictionary objectForKey:categoryKeyPlacesCount]];
    return category;
    
}

+(NSArray *)firstLevelCategories {
    return [PTGCategory findAllWithPredicate:[NSPredicate predicateWithFormat:@"parrentId == 1"]];
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
                                                                 successBlock([self getCategoriesFromArray:[JSON objectForKey:categoryKeyRoot]]);
                                                             }
                                                             else {
                                                                 failureBlock(requestURL, [NSError errorWithDomain:@"Invalid JSON format" code:1910 userInfo:nil]);
                                                             }
                                                             
                                                         } failure:^(NSString *requestURL, NSError *error) {
                                                             failureBlock(requestURL, error);
                                                         }];
}

-(void)loadSubcategoriesFromServerWithSucces:(void(^)(NSArray *subcategories))successBlock failureBlock:(void(^)(NSString *requestUrl, NSError *error))failureBlock {
    NSString *url = [[PTGURLUtils subcategoryUrl] stringByAppendingFormat:@"/%@",self.categoryId];
    [[SMFWebService sharedInstance] sendJSONRequestWithURLString:url
                                                          method:@"GET"
                                                      parameters:nil
                                        withResponseOnMainThread:NO
                                                         success:^(NSString *requestURL, id JSON) {
                                                             if(VALID_NOTEMPTY(JSON, NSDictionary)) {
                                                                 NSArray *subcategories = [PTGCategory  getCategoriesFromArray:[JSON objectForKey:categoryKeyRoot]];
                                                                 [self addChildren:[NSSet setWithArray:subcategories]];
                                                                 successBlock([self.children allObjects]);
                                                             }
                                                             else {
                                                                 failureBlock(requestURL, [NSError errorWithDomain:@"Invalid JSON format" code:1910 userInfo:nil]);
                                                             }
                                                             
                                                         } failure:^(NSString *requestURL, NSError *error) {
                                                             failureBlock(requestURL, error);
                                                         }];
}

-(void)loadPlacesWithSuccess:(void(^)(NSArray *products))successBlock
                     failure:(void(^)(NSString *requestUrl, NSError *error))failureBlock {
    [[PTGLocationUtils sharedInstance] getLocationWithCompletionBlock:^(CLLocation *location) {
        
        NSString *url = [[PTGURLUtils categoryPlacesUrl] stringByAppendingString:self.categoryId];
        url =[url stringByAppendingFormat:@"/%f/%f",location.coordinate.latitude, location.coordinate.longitude];
        [PTGPlace placesForUrl:url succes:^(NSString *requestUrl, NSArray *products) {
            NSArray *finalProducts = [PTGPlace findAllWithPredicate:[NSPredicate predicateWithFormat:@"self in %@", [products valueForKey:@"objectID"]] inContext:self.managedObjectContext];
            [self addPlaces:[NSSet setWithArray:finalProducts]];
            successBlock([self.places allObjects]);
        } failure:failureBlock];
    }];
}

+(NSArray *)getCategoriesFromArray:(NSArray *)array  {
    NSMutableArray *categories = [NSMutableArray new];
    NSArray *allCategories = [PTGCategory findAll];
    for(NSDictionary *dict in array) {
        PTGCategory *category = [self isCategoryWithIDAdded:[dict objectForKey:categoryKeyId] allCategories:allCategories];
        category = [PTGCategory categoryFromDictionary:dict usingCategory:category];
        
        if(VALID(category, PTGCategory)) {
            [categories addObject:category];
        }
    }
    [[NSManagedObjectContext MR_contextForCurrentThread] saveToPersistentStoreAndWait];
    NSArray *fetchedCategory = [PTGCategory findAllWithPredicate:[NSPredicate predicateWithFormat:@"self in %@",[categories valueForKey:@"objectID"]] inContext:[NSManagedObjectContext defaultContext]];
    return [fetchedCategory sortedArrayUsingComparator:^NSComparisonResult(PTGCategory *obj1, PTGCategory *obj2) {
        return [obj1.position compare:obj2.position];
    }];
    
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
