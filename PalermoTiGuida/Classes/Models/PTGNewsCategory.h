#import "_PTGNewsCategory.h"

@interface PTGNewsCategory : _PTGNewsCategory {}

+(void)newsCategoriesWithSuccess:(void(^)(NSInteger newNews))success failure:(void(^)(NSError *error))failure;
-(void)loadNewsWithSuccess:(void(^)(BOOL done))successBlock failure:(void(^)(NSError *error))failureBlock;
+(NSArray *)firstLevel;
@end
