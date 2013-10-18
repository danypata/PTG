//
//  SMFDatabaseHandler.h
//  ShopMob
//
//  Created by dan.patacean on 9/9/13.
//  Copyright (c) 2013 dan.patacean. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *
 * @Description: Class used for database init. This class provide the required NSManagedObjectContext for main thread and background threads. Use only this class for getting NSManagedObjectContext objects for accessing the database.
 *
 */


@interface SMFDatabaseHandler : NSObject {
    NSManagedObjectContext *fetchContext;
    
}

/**
 * Context used for database operations on main thread
 */

@property(nonatomic, readonly) NSManagedObjectContext *mainContext;

/**
 * Default core data model
 */
@property (nonatomic, readonly) NSManagedObjectModel *managedObjectModel;

/**
 * Default core data persistent store coordinator
 */
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 *
 * @Description: Returns an instance of SMFDatabaseHandler
 * @param:nil
 * @return:SMFDatabaseHandler instance
 *
 */
+(SMFDatabaseHandler *)sharedInstance;

/**
 *
 * @Description: Method used for creating a new NSManagedObjectContext instance for background thread fetch operations . If current thread is the main thread then mainContext will be returned
 * @param:nil
 * @return:new instance of NSManagedObjectContext if current thread is background thread, mainContext if current thread is main thread
 *
 */
-(NSManagedObjectContext *)getThreadContext;

@end
