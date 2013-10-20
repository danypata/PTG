#import "PTGDiaryItem.h"
#import "PTGPlace.h"

@interface PTGDiaryItem ()

// Private interface goes here.

@end


@implementation PTGDiaryItem

+(PTGDiaryItem *)diaryItemWithPlace:(PTGPlace *)place visited:(BOOL)isVisited {
    NSArray *all = [PTGDiaryItem allDiaryItems];
    for(PTGDiaryItem *item in all) {
        if([item.place.placeBoardId isEqualToString:place.placeBoardId]) {
            item.isVisited = [NSNumber numberWithBool:isVisited];
            [item.managedObjectContext saveToPersistentStoreAndWait];
            return item;
        }
    }
    PTGDiaryItem *item = [PTGDiaryItem createInContext:place.managedObjectContext];
    item.place = place;
    item.isVisited = [NSNumber numberWithBool:isVisited];
    [item.managedObjectContext saveToPersistentStoreAndWait];
    return item;
}

+(NSArray *)allDiaryItems {
    return [PTGDiaryItem findAll];
}

+(BOOL)isDiaryForPlace:(PTGPlace *)place {
    NSArray *all = [PTGDiaryItem allDiaryItems];
    for(PTGDiaryItem *item in all) {
        if([item.place.placeBoardId isEqualToString:place.placeBoardId]) {
            return YES;
        }
    }
    return NO;

}

+(void)removeDiaryForPlace:(PTGPlace *)place {
    PTGDiaryItem *item = [PTGDiaryItem diaryItemWithPlace:place visited:YES];
    [item deleteEntity];
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
}


@end
