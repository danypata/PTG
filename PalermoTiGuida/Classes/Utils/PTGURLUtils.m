//
//  PTGURLUtils.m
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGURLUtils.h"

@implementation PTGURLUtils

+(NSString *)baseUrlString {
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([currentLanguage isEqualToString:@"en"]) {
        return enBaseUrl;
    }
    else if([currentLanguage isEqualToString:@"it"]) {
        return itBaseUrl;
    }
    else if([currentLanguage isEqualToString:@"ru"]) {
        return ruBaseUrl;
    }
    return enBaseUrl;
}

+(NSString *)pinImageUrlString {
    return [[self baseUrlString] stringByAppendingString:pinImageUrl];
}

+(NSString *)mainCategoryUrl {
     return [[self baseUrlString] stringByAppendingString:categoryUrl];
}

+(NSString *)subcategoryUrl {
    return [[self baseUrlString] stringByAppendingString:subcategoryUrl];
}

+(NSString *)categoryPlacesUrl {
    return [[self baseUrlString] stringByAppendingString:placesUrl];
}

+(NSString *)placeUrl {
    return [[self baseUrlString] stringByAppendingString:placeByIdUrl];
}
+(NSString *)placeWithDistanceUrl {
    return [[self baseUrlString] stringByAppendingString:placeWithDistanceUrl];
}
+(NSString *)placesNearMeUrlString {
    return [[self baseUrlString] stringByAppendingString:placesNearMeUrl];
}
+(NSString *)mainImageUrlForId:(NSString *)imageId {
    NSString *imageType = @"";
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0){
            imageType = mainImageIphoneRetina;
        }
        else {
            imageType = mainImageIphone;
        }
    }
    else {
        imageType = mainImageIphoneRetina;
    }
    ZLog(@"%@",[[self baseUrlString] stringByAppendingFormat:@"%@%@-%@.jpg", imagePath,imageId,imageType ]);
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@-%@.jpg", imagePath,imageId,imageType ];
}

+(NSString *)detailImageUrlForId:(NSString *)imageId {
    NSString *imageType = @"";
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0){
            imageType = imageDetailsIphoneRetina;
        }
        else {
            imageType = imageDetailsIphone;
        }
    }
    else {
        imageType = imageDetailsIpad;
    }
    ZLog(@"%@",[[self baseUrlString] stringByAppendingFormat:@"%@%@-%@.jpg", imagePath,imageId,imageType ]);
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@-%@.jpg", imagePath,imageId,imageType ];
}
@end
