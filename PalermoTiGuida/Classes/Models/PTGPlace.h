#import "_PTGPlace.h"

static const NSString *placeKeyRoot = @"places";
static const NSString *placeKeyId = @"id_place";
static const NSString *placeKeyName = @"name";
static const NSString *placeKeyStreet = @"street";
static const NSString *placeKeyMainImage = @"mainimage";
static const NSString *placeKeyCategoryType = @"id_category_type";
static const NSString *placeKeyDistance = @"distance";



@interface PTGPlace : _PTGPlace {}

+(void)placesForUrl:(NSString *)url
               succes:(void(^)(NSString *requestUrl, NSArray *products))successBlock
              failure:(void(^)(NSString *requestUrl, NSError *error))failureBlock;

-(void)loadDetailsWithSuccess:(void(^)(PTGPlace *place))success failure:(void(^)(NSError *error))failureBlock;
+(void)placesNearMeForUrl:(NSString *)url
                   succes:(void(^)(NSString *requestUrl, NSArray *products))successBlock
                  failure:(void(^)(NSString *requestUrl, NSError *error))failureBlock;

+(PTGPlace *)placeWithId:(NSString*) placeId allPlaces:(NSArray *)allPlaces;
+(PTGPlace *)placeFromDictionary:(NSDictionary *)dictionary oldPlace:(PTGPlace *)place;
@end
