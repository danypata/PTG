#import "PTGNewsCategory.h"
#import "PTGURLUtils.h"
#import "PTGNews.h"
#import "PTGLocationUtils.h"
#import "PTGURLUtils.h"
@interface PTGNewsCategory ()

// Private interface goes here.

@end


@implementation PTGNewsCategory

+(NSArray *)firstLevel {
    NSArray *all = [PTGNewsCategory findAll];
    all =[all filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(PTGNewsCategory *evaluatedObject, NSDictionary *bindings) {
        return evaluatedObject.parent == nil;
    }]];
    return [all sortedArrayUsingComparator:^NSComparisonResult(PTGNewsCategory *obj1, PTGNewsCategory *obj2) {
        return [obj1.name compare:obj2.name options:NSCaseInsensitiveSearch];
    }];
}

+(void)newsCategoriesWithSuccess:(void(^)(NSInteger newNews))success failure:(void(^)(NSError *error))failure {
    [[SMFWebService sharedInstance] sendJSONRequestWithURLString:[PTGURLUtils categoriesNewsUrl] method:@"GET"
                                                      parameters:nil
                                        withResponseOnMainThread:NO
                                                         success:^(NSString *requestURL, id JSON) {
                                                             NSArray *array =[PTGNewsCategory loadCategoriesFromJSON:[JSON objectForKey:@"categorys"]];
                                                             [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
                                                             NSArray *count = [array valueForKey:@"newNews"];
                                                             NSInteger total = 0;
                                                             for(NSNumber *number in count) {
                                                                 total += [number integerValue];
                                                             }
                                                             success(total);
                                                         } failure:^(NSString *requestURL, NSError *error) {
                                                             ZLog(@"%@",error);
                                                         }];
    
    
}

+(NSInteger *)newNews {
    NSArray *all = [PTGNewsCategory findAll];
    NSArray *count = [all valueForKey:@"newNews"];
    NSInteger total = 0;
    for(NSNumber *number in count) {
        total += [number integerValue];
    }
    return total;

}

+(PTGNewsCategory *)categoryFromDictionary:(NSDictionary *)categoryDict {
    PTGNewsCategory *news = [PTGNewsCategory createEntity];
    news.newsCategoryId = [categoryDict objectForKey:@"id_category"];
    news.name = [categoryDict objectForKey:@"name"];
    news.newsCount = [categoryDict objectForKey:@"cate_news"];
    news.categoryType = [categoryDict objectForKey:@"id_category_type"];
    return news;
}

+(NSArray *)loadCategoriesFromJSON:(id)JSON {
    NSArray *categories = [PTGNewsCategory findAll];
    NSDictionary *savedData = [NSDictionary dictionaryWithObjects:categories forKeys:[categories valueForKey:@"newsCategoryId"]];
    NSMutableArray *results = [NSMutableArray new];
    for(NSDictionary *dict in JSON) {
        PTGNewsCategory *news =nil;
        if([[savedData allKeys] containsObject:[dict objectForKey:@"id_category"]]) {
            news= [savedData objectForKey:[dict objectForKey:@"id_category"]];
            [news updatePropertiesWithDictionary:dict];
        }
        else {
            news = [PTGNewsCategory categoryFromDictionary:dict];
        }
        if(VALID_NOTEMPTY([dict objectForKey:@"child"], NSArray)) {
            [news addChildren:[NSSet setWithArray:[PTGNewsCategory loadCategoriesFromJSON:[dict objectForKey:@"child"]]]];
        }
        news.newNews = [NSNumber numberWithInteger:[PTGNewsCategory newNewsFromArray:[dict objectForKey:@"news"]]];
        [results addObject:news];
    }
    return results;
}

-(void)updatePropertiesWithDictionary:(NSDictionary *)categoryDict {
    self.newsCategoryId = [categoryDict objectForKey:@"id_category"];
    self.name = [categoryDict objectForKey:@"name"];
    self.newsCount = [categoryDict objectForKey:@"cate_news"];
    self.categoryType = [categoryDict objectForKey:@"id_category_type"];
}

+(NSInteger)newNewsFromArray:(NSArray *)array {
    NSInteger count = 0;
    for(NSDictionary *dict in array) {
        if(![PTGNews isNewsWithId:[dict objectForKey:@"id_news"]]) {
            count++;
        }
    }
    return count;
}

-(void)loadNewsWithSuccess:(void(^)(BOOL done))successBlock failure:(void(^)(NSError *error))failureBlock {
    [[PTGLocationUtils sharedInstance] getLocationWithCompletionBlock:^(CLLocation *location) {
        [[SMFWebService sharedInstance] cancelAllJSONRequests];
        NSString *url = [[PTGURLUtils newsByCategoryUrl] stringByAppendingFormat:@"%@/%f/%f", self.newsCategoryId, location.coordinate.latitude, location.coordinate.longitude];
        [[SMFWebService sharedInstance] sendJSONRequestWithURLString:url
                                                              method:@"GET"
                                                          parameters:nil
                                            withResponseOnMainThread:NO
                                                             success:^(NSString *requestURL, id JSON) {
                                                                 self.newNews = [NSNumber numberWithInteger:0];
                                                                 [self addNewsFromJSON:JSON];
                                                                 successBlock(YES);
                                                             } failure:^(NSString *requestURL, NSError *error) {
                                                                 failureBlock(error);
                                                             }];
    }];
}

-(void)addNewsFromJSON:(id)JSON {
    for(NSDictionary *dict in [JSON objectForKey:@"news"]) {
        [self addNewsObject:[PTGNews newsFromDictionary:dict context:self.managedObjectContext]];
    }
    [self.managedObjectContext saveToPersistentStoreAndWait];
}

@end
