// UIImageView+AFNetworking.m
//
// Copyright (c) 2011 Gowalla (http://gowalla.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
//#import "SMFImageUrlUtils.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#define INDICATOR_TAG           12131
#import "UIImageView+AFNetworking.h"

@interface AFImageCache : NSCache
- (UIImage *)cachedImageForRequest:(NSURLRequest *)request;
- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request;
@end

#pragma mark -

static char kAFImageRequestOperationObjectKey;

@interface UIImageView (_AFNetworking)
@property (readwrite, nonatomic, strong, setter = af_setImageRequestOperation:) AFImageRequestOperation *af_imageRequestOperation;
@end

@implementation UIImageView (_AFNetworking)
@dynamic af_imageRequestOperation;
@end

#pragma mark -

@implementation UIImageView (AFNetworking)

- (void)addPlaceholderView {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)[self viewWithTag:INDICATOR_TAG];
        if(!VALID(activityIndicatorView, UIActivityIndicatorView)) {
            activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicatorView.frame = CGRectMake(self.frame.size.width / 2 - activityIndicatorView.frame.size.width / 2,
                                                     self.frame.size.height / 2 - activityIndicatorView.frame.size.height / 2,
                                                     activityIndicatorView.frame.size.width,
                                                     activityIndicatorView.frame.size.height);
            activityIndicatorView.tag = INDICATOR_TAG;
            [self addSubview:activityIndicatorView];
        }
        activityIndicatorView.hidden = NO;
        [activityIndicatorView startAnimating];
        [self bringSubviewToFront:activityIndicatorView];
    }];
}

-(void)removePlaceholderView {
    UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)[self viewWithTag:INDICATOR_TAG];
    if(VALID(activityIndicatorView, UIActivityIndicatorView)) {
        [activityIndicatorView stopAnimating];
        activityIndicatorView.hidden = YES;
    }
}
-(void)updateImage:(UIImage *)image {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.hidden = NO;
        self.alpha = 0.0;
        self.image = image;
        [self removePlaceholderView];
        [UIView animateWithDuration:0.4f
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             self.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             
                         }];
    }];
    
}

- (AFHTTPRequestOperation *)af_imageRequestOperation {
    return (AFHTTPRequestOperation *)objc_getAssociatedObject(self, &kAFImageRequestOperationObjectKey);
}

- (void)af_setImageRequestOperation:(AFImageRequestOperation *)imageRequestOperation {
    objc_setAssociatedObject(self, &kAFImageRequestOperationObjectKey, imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue {
    static NSOperationQueue *_af_imageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _af_imageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_af_imageRequestOperationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    });
    
    return _af_imageRequestOperationQueue;
}

+ (AFImageCache *)af_sharedImageCache {
    static AFImageCache *_af_imageCache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _af_imageCache = [[AFImageCache alloc] init];
    });
    
    return _af_imageCache;
}

#pragma mark -

- (void)setImageWithURL:(NSURL *)url {
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:nil failure:nil];
}

- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
{
    [self cancelImageRequestOperation];
    
    UIImage *cachedImage = [[[self class] af_sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        self.af_imageRequestOperation = nil;
        
        if (success) {
            success(nil, nil, cachedImage);
        } else {
            self.image = cachedImage;
        }
    } else {
        if (placeholderImage) {
            self.image = placeholderImage;
        }
        
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest];
		
#ifdef _AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_
		requestOperation.allowsInvalidSSLCertificate = YES;
#endif
		
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                if (self.af_imageRequestOperation == operation) {
                    self.af_imageRequestOperation = nil;
                }
                
                if (success) {
                    success(operation.request, operation.response, responseObject);
                } else if (responseObject) {
                    self.image = responseObject;
                }
            }
            
            [[[self class] af_sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                if (self.af_imageRequestOperation == operation) {
                    self.af_imageRequestOperation = nil;
                }
                
                if (failure) {
                    failure(operation.request, operation.response, error);
                }
            }
        }];
        
        self.af_imageRequestOperation = requestOperation;
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
}

+(void)downloadImageWithURLString:(NSString *)urlString
                urlRebuildOptions:(RebuildEnum)urlRebuiltOptions
                         viewSize:(CGSize)size{
//    CGFloat scaleFactor = 0;
    NSURL *url = [NSURL URLWithString:urlString];
    BOOL shouldRebuild = NO;
    if(urlRebuiltOptions == kFromProduct || urlRebuiltOptions == kFromOther) {
        shouldRebuild = YES;
    }
//    if (shouldRebuild && !CGSizeEqualToSize(CGSizeZero, size) ) {
//        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
//            scaleFactor = 2;
//        }
//        else {
//            scaleFactor = 1;
//        }
//        CGSize finalSize = CGSizeMake(size.width * scaleFactor, size.height * scaleFactor);
//        NSString *rebuildedUrl = [[SMFImageUrlUtils sharedInstance] rebuildImageUrl:urlString forSize:finalSize andCacheOptions:urlRebuiltOptions];
//        url  = [NSURL URLWithString:rebuildedUrl];
//    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *finalUrl = url;
        NSURLRequest *request = [NSURLRequest requestWithURL:finalUrl];
        AFImageRequestOperation *op = [[self class] checkExistingOperationsWithUrl:[finalUrl absoluteString]];
        UIImage *cachedImage = [[[self class] af_sharedImageCache] cachedImageForRequest:request];
        if (cachedImage && op != nil) {
            return;
        } else {
            AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:request];
            [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                [[[self class] af_sharedImageCache] cacheImage:responseObject forRequest:request];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            }];
            [[[self class] af_sharedImageRequestOperationQueue] addOperation:requestOperation];
        }
    });
}

+(void)downloadImageWithURLString:(NSString *)urlString
                     successBlock:(void(^)(UIImage *image))success
                      failureBloc:(void(^)(NSError *error))failure {

    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *finalUrl = url;
        NSURLRequest *request = [NSURLRequest requestWithURL:finalUrl];
        UIImage *cachedImage = [[[self class] af_sharedImageCache] cachedImageForRequest:request];
        if (cachedImage) {
            success(cachedImage);
        } else {
            AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:request];
            [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                [[[self class] af_sharedImageCache] cacheImage:responseObject forRequest:request];
                success(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }];
            [[[self class] af_sharedImageRequestOperationQueue] addOperation:requestOperation];
        }
    });
}

- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
              urlRebuildOption:(RebuildEnum)option
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
{
    [self cancelImageRequestOperation];
    
    UIImage *cachedImage = [[[self class] af_sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        self.af_imageRequestOperation = nil;
        if (success) {
            success(nil, nil, cachedImage);
        }
    } else {
        self.image = placeholderImage;
        
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest] ;
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[urlRequest URL] isEqual:[[self.af_imageRequestOperation request] URL]]) {
                self.af_imageRequestOperation = nil;
            }
            if (success) {
                if(responseObject) {
//                    if (![[urlRequest URL] isFileURL]) {
//                        [SMFImageCache cacheImageData:operation.responseData withURL:[[urlRequest URL] absoluteString] type:option];
//                    }
                }
                success(operation.request, operation.response, responseObject);
            }
            
            [[[self class] af_sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([[urlRequest URL] isEqual:[[self.af_imageRequestOperation request] URL]]) {
                self.af_imageRequestOperation = nil;
            }
            
            if (failure) {
                failure(operation.request, operation.response, error);
            }
        }];
        
        self.af_imageRequestOperation = requestOperation;
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
}

-(void)setImageWithURLString:(NSString *)urlString
           urlRebuildOptions:(RebuildEnum)urlRebuiltOptions
                 withSuccess:(void(^)(BOOL completed))success
                     failure:(void(^)(NSError *erro))failure {
    
    [self addPlaceholderView];
//    CGFloat scaleFactor = 0;
    NSURL *url = [NSURL URLWithString:urlString];
    BOOL shouldRebuild = NO;
    if(urlRebuiltOptions == kFromProduct || urlRebuiltOptions == kFromOther) {
        shouldRebuild = YES;
    }
//    if (shouldRebuild) {
//        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
//            scaleFactor = 2;
//        }
//        else {
//            scaleFactor = 1;
//        }
//        CGSize finalSize = CGSizeMake(self.frame.size.width * scaleFactor, self.frame.size.height * scaleFactor);
//        NSString *rebuildedUrl = [[SMFImageUrlUtils sharedInstance] rebuildImageUrl:urlString forSize:finalSize andCacheOptions:urlRebuiltOptions];
//        url  = [NSURL URLWithString:rebuildedUrl];
//    }
    dispatch_queue_t callerQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    AFImageRequestOperation *operation = [[self class] checkExistingOperationsWithUrl:[url absoluteString]];
    if(operation!=nil) {
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([url isEqual:[[self.af_imageRequestOperation request] URL]]) {
                //                    dispatch_async(callerQueue, ^{
                [self updateImage:responseObject];
                self.af_imageRequestOperation = nil;
            }
            if (success) {
//                if(responseObject) {
//                    [SMFImageCache cacheImageData:operation.responseData withURL:[url absoluteString] type:urlRebuiltOptions];
//                }
                dispatch_async(callerQueue, ^{
                    success(YES);
                });
            }
            
            [[[self class] af_sharedImageCache] cacheImage:responseObject forRequest:self.af_imageRequestOperation.request];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([url isEqual:[[self.af_imageRequestOperation request] URL]]) {
                self.af_imageRequestOperation = nil;
            }
            
            if (failure) {
                NSString *urlString = [operation.request.URL absoluteString];
                NSString *extension = [[urlString componentsSeparatedByString:@"."] lastObject];
                if([extension isEqualToString:@"webp"]) {
                    urlString = [urlString stringByReplacingOccurrencesOfString:@"webp" withString:@"jpg"];
                    [self setImageWithURLString:urlString urlRebuildOptions:kNone withSuccess:success failure:failure];
                }
                else {
                    failure(error);
                }
            }
            
        }];
        
        self.af_imageRequestOperation = operation;
        
    }
    else {
        NSURL *finalUrl = url;
        __weak UIImageView *weakSelf = self;
        [self setImageWithURLRequest:[NSURLRequest requestWithURL:finalUrl]
                    placeholderImage:nil
                    urlRebuildOption:urlRebuiltOptions
                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                 [weakSelf updateImage:image];
                                 if(success) {
                                     success(YES);
                                 }
                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                 NSString *urlString = [request.URL absoluteString];
                                 NSString *extension = [[urlString componentsSeparatedByString:@"."] lastObject];
                                 if([extension isEqualToString:@"webp"]) {
                                     urlString = [urlString stringByReplacingOccurrencesOfString:@"webp" withString:@"jpg"];
                                     [weakSelf setImageWithURLString:urlString urlRebuildOptions:kNone withSuccess:success failure:failure];
                                 }
                                 else {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         if(failure) {
                                             failure(error);
                                         }
                                     });
                                     
                                 }
                             }];
    }
}



+(AFImageRequestOperation *)checkExistingOperationsWithUrl:(NSString *)urlString {
    for(AFImageRequestOperation *operation in [[[self class] af_sharedImageRequestOperationQueue] operations]) {
        if([operation.request.URL.absoluteString isEqualToString:urlString]) {
            return operation;
        }
    }
    return nil;
}

- (void)cancelImageRequestOperation {
    [self.af_imageRequestOperation cancel];
    self.af_imageRequestOperation = nil;
}

+(void)cancelAllImageDownloadscance{
    [[[self class] af_sharedImageRequestOperationQueue] cancelAllOperations];
}


@end

#pragma mark -

static inline NSString * AFImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

@implementation AFImageCache

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    
	return [self objectForKey:AFImageCacheKeyFromURLRequest(request)];
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    if (image && request) {
        [self setObject:image forKey:AFImageCacheKeyFromURLRequest(request)];
    }
}

@end

#endif
