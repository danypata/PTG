//
//  PTGJSONUtils.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/17/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGJSONUtils.h"

@implementation PTGJSONUtils


+(id)clearJSON:(id)JSON {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:JSON];
    for(NSString *key in [JSON allKeys]) {
        if([[NSNull null] isEqual:[JSON objectForKey:key]]) {
            [dict setValue:@"" forKey:key];
        }
    }
    return dict;
}
@end
