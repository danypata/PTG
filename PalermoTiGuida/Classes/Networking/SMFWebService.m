//
//  SMFWebService.m
//  ShopMob
//
//  Created by dan.patacean on 9/10/13.
//  Copyright (c) 2013 dan.patacean. All rights reserved.
//

#import "SMFWebService.h"

@interface SMFWebService (Private)


/**
 *
 * @Description: Will create a new instance of AFJSONRequestOperation that will use the the NSURLRequest created by "URLRequestWithURLString:" method. If user and password are set, this method will also set the AuthenticationChallenge block required in case of HTAccess, or other authentications.
 * @param:request - the request used for creating the AFJSONRequestOperation
 * @return:new instace of AFJSONRequestOperation
 *
 */
-(AFJSONRequestOperation *)requestOperationWithURLRequest:(NSURLRequest *)request;

/**
 *
 * @Description: This method will set the compelition blocks (success and failure) for the AFJSONRequestOperation passed as parameters. This method ensure that the blocks are called on the desired queue (main queue or background queue) depending on the parameter "withResponseOnMainThread" passed for all request methods
 * @param:operation - the operation which will have the blocks set
 * @return:void
 *
 */
-(void)setOperationCompletionBlocks:(AFJSONRequestOperation *)operation
                            success:(void(^)(NSString *requestURL, id JSON))successBock
                            failure:(void(^)(NSString *requestURL, NSError *error))failureBlock;
@end

@implementation SMFWebService
@synthesize maxConcurentOperations = _maxConcurentOperations;
@synthesize requestTimeoutInterval;
@synthesize requestPassword;
@synthesize requestUser;
@synthesize baseUrl;

#pragma mark - Init methods

+(SMFWebService *)sharedInstance {
    static dispatch_once_t pred = 0;
    static SMFWebService *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

-(id)init {
    self = [super init];
    if(self) {
        requestQueue = [[NSOperationQueue alloc] init];
        searchOperationQueue = [[NSOperationQueue alloc] init];
        self.requestTimeoutInterval = 60;
    }
    return self;
}

-(void)setMaxConcurentOperations:(NSInteger)maxConcurentOperations {
    _maxConcurentOperations = maxConcurentOperations;
    searchOperationQueue.maxConcurrentOperationCount = _maxConcurentOperations;
}


#pragma mark - URL utils methods

-(void)sendJSONRequestWithURLString:(NSString *)url
                             method:(NSString *)method
                         parameters:(NSDictionary *)parameters
           withResponseOnMainThread:(BOOL)sendResponseOnMainThread
                            success:(void(^)(NSString *requestURL, id JSON))success
                            failure:(void(^)(NSString *requestURL, NSError *error)) failure {
    [self cancelAllJSONRequests];
    dispatch_queue_t responseQueue = nil;
    if(sendResponseOnMainThread) {
        responseQueue = dispatch_get_main_queue();
    }
    else {
        responseQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
    NSURLRequest *request  = [self URLRequestWithURLString:url method:method parameters:parameters];
    ZLog(@"%@",request.URL);
    if(!VALID(request, NSURLRequest)) {
        dispatch_async(responseQueue, ^{
            if(failure) {
                failure(url, [NSError errorWithDomain:@"Request is nill, check url used" code:1213 userInfo:nil]);
            }
        });
        return;
    }
    AFJSONRequestOperation *operation = [self requestOperationWithURLRequest:request];
    [self setOperationCompletionBlocks:operation
                               success:success
                               failure:failure
                         dispatchQueue:responseQueue];
    [requestQueue addOperation:operation];
}

-(void)cancelAllRequests {
    [self cancelAllJSONRequests];
    [self cancelAllSearchRequests];
}
-(void)cancelAllSearchRequests {
    [searchOperationQueue cancelAllOperations];
}
-(void)cancelAllJSONRequests {
    [requestQueue cancelAllOperations];
}


#pragma mark - Helper methods

-(NSURLRequest *)URLRequestWithURLString:(NSString *)urlString
                                  method:(NSString *)method
                              parameters:(NSDictionary *)parameters {
    if(VALID_NOTEMPTY(urlString, NSString)) {
        if(!VALID(method, NSString)) {
            method = @"GET";
        }
        NSURL *url = [NSURL URLWithString:urlString];
        if(VALID(url, NSURL)) {
            AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
            NSMutableURLRequest *request = [httpClient requestWithMethod:method
                                                                    path:@""
                                                              parameters:parameters];
            request.timeoutInterval = self.requestTimeoutInterval;
            return request;
        }
        else {
            ZLog(@"%@ is not a valid URL format", urlString);
            return nil;
        }
    }
    else {
        ZLog(@"nil URL passed");
        return nil;
    }
}

-(AFJSONRequestOperation *)requestOperationWithURLRequest:(NSURLRequest *)request {
    AFJSONRequestOperation *requestOperation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    if(VALID_NOTEMPTY(self.requestUser, NSString) && VALID_NOTEMPTY(self.requestPassword, NSString)) {
        [requestOperation setWillSendRequestForAuthenticationChallengeBlock:^(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge) {
            NSURLCredential *newCredentials = [NSURLCredential credentialWithUser:self.requestUser password:self.requestPassword persistence:NSURLCredentialPersistenceForSession];
            [challenge.sender useCredential:newCredentials forAuthenticationChallenge:challenge];
        }];
    }
    return requestOperation;
}

-(void)setOperationCompletionBlocks:(AFJSONRequestOperation *)operation
                            success:(void(^)(NSString *requestURL, id JSON))successBock
                            failure:(void(^)(NSString *requestURL, NSError *error))failureBlock
                      dispatchQueue:(dispatch_queue_t)queue {
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(successBock && !operation.isCancelled) {
            dispatch_async(queue, ^{
                successBock([operation.request.URL absoluteString], responseObject);
            });
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failureBlock && !operation.isCancelled) {
            dispatch_async(queue, ^{
                failureBlock([operation.request.URL absoluteString], error);
            });
        }
    }];
}

@end
