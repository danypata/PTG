#import "_PTGNews.h"

@interface PTGNews : _PTGNews {}

+(BOOL)isNewsWithId:(NSString *)newsId;
+(PTGNews *)newsFromDictionary:(NSDictionary *)newsDict context:(NSManagedObjectContext *)moc ;
@end
