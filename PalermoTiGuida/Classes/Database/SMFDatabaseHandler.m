//
//  SMFDatabaseHandler.m
//  ShopMob
//
//  Created by dan.patacean on 9/9/13.
//  Copyright (c) 2013 dan.patacean. All rights reserved.
//

#import "SMFDatabaseHandler.h"

static dispatch_queue_t coredDataSaveQueue;

@interface SMFDatabaseHandler (Private)
/**
 *
 * @Description: Method used to create a new NSManagedObjectContext instance for background operations
 * @param:nil
 * @return: new instance of NSManagedObjectContext
 *
 */

-(NSManagedObjectContext *)getBackgroundContext;
@end

@implementation SMFDatabaseHandler
@synthesize mainContext = _mainContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



#pragma mark - Core Data methods
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    if (_mainContext != nil) {
        return _mainContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_mainContext setPersistentStoreCoordinator:coordinator];
        fetchContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [fetchContext setParentContext:_mainContext];
    }
    return _mainContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SMFDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PTGDataModel.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


-(NSManagedObjectContext *)getBackgroundContext {
    NSManagedObjectContext *backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [backgroundContext setParentContext:_mainContext];
    return backgroundContext;
}

-(void)mergeChangesOnMainThread:(NSNotification *)notification {
    if([NSThread isMainThread]) {
        [_mainContext mergeChangesFromContextDidSaveNotification:notification];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mainContext mergeChangesFromContextDidSaveNotification:notification];
        });
    }
}


#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(id) init {
    self = [super init];
    if(self) {
        _mainContext = [self managedObjectContext];
        [_mainContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    }
    return self;
}
#pragma mark - Public methods

+(SMFDatabaseHandler *)sharedInstance {
    static dispatch_once_t pred = 0;
    static SMFDatabaseHandler *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

-(NSManagedObjectContext *)getThreadContext {
    if([NSThread isMainThread]) {
        return _mainContext;
    }
    else {
        return [self getBackgroundContext];
    }
}
@end
