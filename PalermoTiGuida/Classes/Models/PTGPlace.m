#import "PTGPlace.h"
#import "PTGLocationUtils.h"
#import "PTGURLUtils.h"
#import "PTGCategory.h"
#import "PTGJSONUtils.h"
@interface PTGPlace ()

// Private interface goes here.

@end


@implementation PTGPlace

+(PTGPlace *)placeFromDictionary:(NSDictionary *)dictionary oldPlace:(PTGPlace *)place {
    if(!VALID(place, PTGPlace)) {
        place = [PTGPlace createEntity];
    }
    
    place.placeId = [dictionary objectForKey:placeKeyId];
    place.name = [dictionary objectForKey:placeKeyName];
    if(VALID_NOTEMPTY([dictionary objectForKey:placeKeyMainImage], NSString)) {
        place.mainImage = [dictionary objectForKey:placeKeyMainImage];
    }
    place.categoryType = [dictionary objectForKey:placeKeyCategoryType];
    place.street = [dictionary objectForKey:placeKeyStreet];
    place.distance = [PTGLocationUtils distanceStringFromString:[dictionary objectForKey:placeKeyDistance]];
    [place copyPropertiesFromJSON:dictionary];
    return place;
    
}

+(void)placesForUrl:(NSString *)url
             succes:(void(^)(NSString *requestUrl, NSArray *products))successBlock
            failure:(void(^)(NSString *requestUrl, NSError *error))failureBlock {
    [[SMFWebService sharedInstance] sendJSONRequestWithURLString:url
                                                          method:@"GET"
                                                      parameters:nil
                                        withResponseOnMainThread:NO
                                                         success:^(NSString *requestURL, id JSON) {
                                                             if([JSON isKindOfClass:[NSArray class]])  {
                                                                 successBlock(requestURL, [self placesFromJSONArray:JSON]);
                                                             }
                                                             else {
                                                                 successBlock(requestURL, [self placesFromJSONArray:[JSON objectForKey:placeKeyRoot]]);
                                                             }
                                                         } failure:failureBlock];
}

+(NSArray *)placesFromJSONArray:(NSArray *)array {
    NSArray *allPlaces = [PTGPlace findAll];
    NSMutableArray *results = [NSMutableArray new];
    for(NSDictionary *dict in array) {
        PTGPlace *place = [self placeWithId:[dict objectForKey:placeKeyId] allPlaces:allPlaces];
        place = [PTGPlace placeFromDictionary:dict oldPlace:place];
        if(VALID(place, PTGPlace)) {
            [results addObject:place];
        }
    }
    [[NSManagedObjectContext MR_contextForCurrentThread] saveToPersistentStoreAndWait];
    results = [[PTGPlace findAllWithPredicate:[NSPredicate predicateWithFormat:@"self in %@", [results valueForKey:@"objectID"]]] mutableCopy];
    return [results sortedArrayUsingComparator:^NSComparisonResult(PTGPlace *obj1, PTGPlace *obj2) {
        return [obj1.name compare:obj2.name options:NSCaseInsensitiveSearch];
    }];
}

+(PTGPlace *)placeWithId:(NSString*) placeId allPlaces:(NSArray *)allPlaces {
    for(PTGPlace *place in allPlaces) {
        if([place.placeId isEqualToString:placeId]) {
            return place;
        }
    }
    return nil;
}

-(void)loadDetailsWithSuccess:(void(^)(PTGPlace *place))success failure:(void(^)(NSError *error))failureBlock {
    NSString *url = [[PTGURLUtils placeUrl] stringByAppendingFormat:@"%@/%@",self.placeId, self.categoryType];
    [[SMFWebService sharedInstance] sendJSONRequestWithURLString:url method:@"GET" parameters:nil withResponseOnMainThread:NO success:^(NSString *requestURL, id JSON) {
        if(VALID_NOTEMPTY(JSON, NSArray)) {
            [self copyPropertiesFromJSON:[JSON objectAtIndex:0]];
            success(self);
        }
        else {
            failureBlock([NSError errorWithDomain:@"Invalid JSON format" code:1231 userInfo:nil]);
        }
    } failure:^(NSString *requestURL, NSError *error) {
        failureBlock(error);
    }];
}

-(void)copyPropertiesFromJSON:(id)json {
    json = [PTGJSONUtils clearJSON:json];
    self.streetNo = [json objectForKey:@"streetno"];
    self.zipCode = [json objectForKey:@"zip"];
    self.province = [json objectForKey:@"province"];
    self.lat = [json objectForKey:@"lat"];
    self.longit = [json objectForKey:@"longit"];
    self.phones = [NSKeyedArchiver archivedDataWithRootObject:[self phoneArrayFromJSON:json]];
    self.faxes = [NSKeyedArchiver archivedDataWithRootObject:[self faxArrayFromJSON:json]];
    self.opendayFrom = [json objectForKey:@"opendayfrom"];
    self.openDayTo = [json objectForKey:@"opendayto"];
    self.openTimeAMFrom = [json objectForKey:@"opentimeamfrom"];
    self.openTimeAMTo = [json objectForKey:@"opentimeamto"];
    self.openTimePMFrom = [json objectForKey:@"opentimepmfrom"];
    self.openTimePMTo = [json objectForKey:@"opentimepmto"];
    self.descriptionText = [json objectForKey:@"description"];
    self.placeBoardId = [json objectForKey:@"id_place_connect_board"];
    self.placeBoardName = [json objectForKey:@"name_place_connect_board"];
    self.placePortId = [json objectForKey:@"id_place_connect_port"];
    self.placePortName = [json objectForKey:@"name_place_connect_port"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *value = [json objectForKey:@"website"];
    if(VALID_NOTEMPTY(value, NSString)) {
        [array addObject:value];
    }
    [array addObjectsFromArray:[self emailArrayFromJSON:json]];
    self.webAddresses = [NSKeyedArchiver archivedDataWithRootObject:array];
    [self.managedObjectContext saveToPersistentStoreAndWait];
}

-(NSArray *)phoneArrayFromJSON:(id)JSON {
    NSString *key = @"phone";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i=1; i<=5; i++) {
        NSString *value = [JSON objectForKey:[key stringByAppendingFormat:@"%d",i]];
        if(VALID_NOTEMPTY(value, NSString)) {
            [array addObject:value];
        }
    }
    return array;
}

-(NSArray *)faxArrayFromJSON:(id)JSON {
    NSString *key = @"fax";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i=1; i<=5; i++) {
        NSString *value = [JSON objectForKey:[key stringByAppendingFormat:@"%d",i]];
        if(VALID_NOTEMPTY(value, NSString)) {
            [array addObject:value];
        }
    }
    return array;
}

-(NSArray *)emailArrayFromJSON:(id)JSON {
    NSString *key = @"email";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i=1; i<=5; i++) {
        NSString *value = [JSON objectForKey:[key stringByAppendingFormat:@"%d",i]];
        if(VALID_NOTEMPTY(value, NSString)) {
            [array addObject:value];
        }
    }
    return array;
}

@end
