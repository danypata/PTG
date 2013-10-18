//
//  SMFWebService.h
//
//  Created by dan.patacean on 9/10/13.
//  Copyright (c) 2013 dan.patacean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"


@interface SMFWebService : NSObject {

    NSOperationQueue *requestQueue;
    NSOperationQueue *searchOperationQueue;
    NSDictionary *urlDictionary;

}
@property(nonatomic) NSInteger requestTimeoutInterval;
@property(nonatomic) NSInteger maxConcurentOperations;
@property(nonatomic, strong) NSString *requestPassword;
@property(nonatomic, strong) NSString *requestUser;
@property(nonatomic, strong) NSString *baseUrl;



/**
 *
 * @Description: Method used for init the SMFWebService singleton class
 * @param:nil
 * @return:instance of SMFWebService class
 *
 */
+(SMFWebService *)sharedInstance;

-(NSURLRequest *)URLRequestWithURLString:(NSString *)urlString
                                  method:(NSString *)method
                              parameters:(NSDictionary *)parameters;

-(void)sendJSONRequestWithURLString:(NSString *)url
                             method:(NSString *)method
                         parameters:(NSDictionary *)parameters
           withResponseOnMainThread:(BOOL)sendResponseOnMainThread
                            success:(void(^)(NSString *requestURL, id JSON))success
                            failure:(void(^)(NSString *requestURL, NSError *error)) failure;

-(void)cancelAllRequests;
-(void)cancelAllSearchRequests;
-(void)cancelAllJSONRequests;
@end
