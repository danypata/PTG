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
    return baseUrl;
}

+(NSString *)languageExtension {
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([currentLanguage isEqualToString:@"en"] || [currentLanguage isEqualToString:@"it"] || [currentLanguage isEqualToString:@"ru"]) {
        return [NSString stringWithFormat:@"api/%@/",currentLanguage];
    }
    return @"api/en";
    
}

+(NSString *)pinImageUrlString {
    return [[self baseUrlString] stringByAppendingString:pinImageUrl];
}

+(NSString *)mainCategoryUrl {
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], categoryUrl];
}

+(NSString *)allPropertiesUrl {
       return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], placesWithAllProperties];
}

+(NSString *)subcategoryUrl {
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], subcategoryUrl];
}

+(NSString *)categoryPlacesUrl {
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], placesUrl];
}
+(NSString *)placesSearchUrl {
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], placesSearch];
}
+(NSString *)placeUrl {
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], placeByIdUrl];
}
+(NSString *)categoriesNewsUrl{
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], newsCategoriesUrl];
    
}
+(NSString *)newsByCategoryUrl {
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], newsByCategoryUrl];
    return [[self baseUrlString] stringByAppendingString:newsByCategoryUrl];
}
+(NSString *)placeWithDistanceUrl {
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], placeWithDistanceUrl];
}
+(NSString *)placesNearMeUrlString {
    return [[self baseUrlString] stringByAppendingFormat:@"%@%@",[self languageExtension], placesNearMeUrl];
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
        imageType = mainImageIpadRetina;
    }
    ZLog(@"%@",[[self baseUrlString] stringByAppendingFormat:@"%@maincategory/%@-%@.jpg", imagePath,imageId,imageType ]);
    return [[self baseUrlString] stringByAppendingFormat:@"%@maincategory/%@-%@.jpg", imagePath,imageId,imageType ];
}

+(NSString *)mainPlaceImageUrlForId:(NSString *)imageId{
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
