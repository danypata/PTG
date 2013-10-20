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

static NSString *enBaseUrl                      = @"http://palermotiguida.it/webservice/cm/";
static NSString *ruBaseUrl                      = @"http://palermotiguida.it/webservice/cm/";
static NSString *itBaseUrl                      = @"http://palermotiguida.it/webservice/cm/";

static NSString *imagePath                      =@"img/";
static NSString *pinImageUrl                    =@"img/pinpoint/";
static NSString *categoryUrl                    = @"api/categoryall";
static NSString *subcategoryUrl                 = @"api/category_place_by_parent";
static NSString *placesUrl                      = @"api/place_by_category/";
static NSString *placeByIdUrl                   = @"api/place_by_id/";
static NSString *placeWithDistanceUrl           = @"api/place_by_id_distance/";
static NSString *placesNearMeUrl                = @"api/place_near_me/";

static NSString *mainImageIphoneRetina          = @"MainPictureiPhone_retina";
static NSString *mainImageIphone                = @"MainPictureiPhone_iphone";
static NSString *mainImageIpadRetina            = @"MainPictureiPad_retina";

static NSString *imageDetailsIphone             = @"Slide1iPhone";
static NSString *imageDetailsIphoneRetina       = @"Slide1iPhone_retina";
static NSString *imageDetailsIpad               = @"Slide1iPad_retina";


@interface PTGURLUtils : NSObject {
    
    
}
+(NSString *)baseUrlString;
+(NSString *)pinImageUrlString;
+(NSString *)mainCategoryUrl;
+(NSString *)subcategoryUrl;
+(NSString *)categoryPlacesUrl;
+(NSString *)placeUrl;
+(NSString *)placeWithDistanceUrl;
+(NSString *)placesNearMeUrlString;
+(NSString *)mainImageUrlForId:(NSString *)imageId;
+(NSString *)detailImageUrlForId:(NSString *)imageId;
@end
