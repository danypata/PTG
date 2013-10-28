#import "PTGNews.h"
#import  "PTGPlace.h"

@interface PTGNews ()

// Private interface goes here.

@end


@implementation PTGNews

+(BOOL)isNewsWithId:(NSString *)newsId {
    return [[[PTGNews findAll] valueForKey:@"newsId"] containsObject:newsId];
}

+(PTGNews *)newsFromDictionary:(NSDictionary *)newsDict context:(NSManagedObjectContext *)moc {
    PTGNews *news = [PTGNews findFirstByAttribute:@"newsId" withValue:[newsDict objectForKey:@"id_news"] inContext:moc];
    if(!VALID(news, PTGNews)) {
        news = [PTGNews createInContext:moc];
    }
    news.newsId = [newsDict objectForKey:@"id_news"];
    news.categoryId = [newsDict objectForKey:@"id_category"];
    news.categoryType =[newsDict objectForKey:@"id_category_type"];
    news.date = [newsDict objectForKey:@"date"];
    news.validFrom = [newsDict objectForKey:@"validfrom"];
    news.validTo = [newsDict objectForKey:@"validto"];
    news.title = [newsDict objectForKey:@"title"];
    news.descriptionText = [newsDict objectForKey:@"description"];
    if(VALID_NOTEMPTY([newsDict objectForKey:@"places"], NSArray)) {
        NSDictionary *placeDict = [[newsDict objectForKey:@"places"] firstObject];
        PTGPlace *place = [PTGPlace placeWithId:[placeDict objectForKey:@"id_place"] allPlaces:[PTGPlace findAllInContext:moc]];
        if(!place) {
            place =[PTGPlace createInContext:moc];
        }
        place = [PTGPlace placeFromDictionary:placeDict oldPlace:place];
        news.place = place;
    }
    return news;
}

@end
