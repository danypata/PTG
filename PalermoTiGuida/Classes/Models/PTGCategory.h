#import "_PTGCategory.h"


static NSString *categoryKeyRoot            = @"categorys";
static NSString *categoryKeyId              = @"id_category";
static NSString *categoryKeyParentId        = @"parent_id";
static NSString *categoryKeyType            = @"id_category_type";
static NSString *categoryKeyPostion         = @"position";
static NSString *categoryKeyImageType       = @"imagetype";
static NSString *categoryKeyPlacesCount     = @"cate_places";
static NSString *categoryKeyCategoryCount   = @"cate_cat";

static NSString *categoryKeyName            = @"name";

@interface PTGCategory : _PTGCategory {
}

+(PTGCategory *)categoryFromDictionary:(NSDictionary *)dictionary usingCategory:(PTGCategory *)category context:(NSManagedObjectContext *)context;
+(NSArray *)firstLevelCategories;
-(NSArray *)childCategories;
+(void)loadCategoriesFromServerWithSuccess:(void (^)(NSArray *))successBlock
                              failureBlock:(void (^)(NSString *requestUrl, NSError *))failureBlock;

+(PTGCategory *)firstLevelCategoryWithName:(NSString *)name;

-(void)loadPlacesWithSuccess:(void(^)(NSArray *products))successBlock
                     failure:(void(^)(NSString *requestUrl, NSError *error))failureBlock;
-(void)loadAllPlacesProperties:(void(^)(NSArray *products))successBlock
                       failure:(void(^)(NSString *requestUrl, NSError *error))failureBlock;

-(NSArray *)allSubcategories;
-(NSArray *)lowestLevelOfChildren;
@end
