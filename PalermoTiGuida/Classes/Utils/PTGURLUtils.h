//
//  PTGURLUtils.h
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *enLocale                       = @"en";
static NSString *ruLocale                       = @"ru";
static NSString *itLocale                       = @"it";

static NSString *baseUrl                      = @"http://palermotiguida.it/webservice/cm/";

static NSString *imagePath                      =@"img/";
static NSString *pinImageUrl                    =@"img/pinpoint/";
static NSString *categoryUrl                    = @"categoryall";
static NSString *subcategoryUrl                 = @"category_place_by_parent";
static NSString *placesUrl                      = @"place_by_category/";
static NSString *placeByIdUrl                   = @"place_by_id/";
static NSString *placeWithDistanceUrl           = @"place_by_id_distance/";
static NSString *placesNearMeUrl                = @"place_near_me/";
static NSString *placesSearch                   = @"places/search/";
static NSString *newsCategoriesUrl              = @"categorynewssall";
static NSString *newsByCategoryUrl              = @"news_by_category/";
static NSString *placesWithAllProperties        = @"place_by_category_all_prop/";

static NSString *mainImageIphoneRetina          = @"MainPictureiPad_retina";
static NSString *mainImageIphone                = @"MainPictureiPhone_iphone";
static NSString *mainImageIpadRetina            = @"Slide1iPad";

static NSString *imageDetailsIphone             = @"Slide1iPhone";
static NSString *imageDetailsIphoneRetina       = @"Slide1iPhone_retina";
static NSString *imageDetailsIpad               = @"Slide1iPad_retina";


@interface PTGURLUtils : NSObject {
    
    
}
+(NSString *)baseUrlString;
+(NSString *)pinImageUrlString;
+(NSString *)allPropertiesUrl;
+(NSString *)mainCategoryUrl;
+(NSString *)subcategoryUrl;
+(NSString *)categoryPlacesUrl;
+(NSString *)placesSearchUrl;
+(NSString *)placeUrl;
+(NSString *)categoriesNewsUrl;
+(NSString *)newsByCategoryUrl;
+(NSString *)placeWithDistanceUrl;
+(NSString *)placesNearMeUrlString;
+(NSString *)mainImageUrlForId:(NSString *)imageId;
+(NSString *)mainPlaceImageUrlForId:(NSString *)imageId;
+(NSString *)detailImageUrlForId:(NSString *)imageId;
@end
