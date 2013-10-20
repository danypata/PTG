#import "_PTGDiaryItem.h"

@interface PTGDiaryItem : _PTGDiaryItem {}

+(PTGDiaryItem *)diaryItemWithPlace:(PTGPlace *)place visited:(BOOL)isVisited;

+(NSArray *)allDiaryItems;
+(BOOL)isDiaryForPlace:(PTGPlace *)place;
+(void)removeDiaryForPlace:(PTGPlace *)place;
@end
