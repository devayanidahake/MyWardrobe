//
//  DatabaseManager.h
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject
{
    //RegisteredUser *currentUser;
    //NSManagedObjectContext *managedObjectContext;
}
@property (nonatomic,retain) RegisteredUser *currentUser;
+(RegisteredUser*)getCurrentUser;
+(NSMutableArray*)getAllCategoriesForUser:(RegisteredUser*)user;
+(NSMutableArray*)getAllOutfitsRelatedToCategory:(CategoryList*)category forUser:(RegisteredUser*)user;

+(BOOL)addCategory:(CategoryList*)category forUser:(RegisteredUser*)user;
+(BOOL)removeCategory:(CategoryList*)category forUser:(RegisteredUser*)user;

+(BOOL)addOufit:(Outfit*)outfit toCategory:(CategoryList*)category forUser:(RegisteredUser*)user;
+(BOOL)removeOufit:(Outfit*)outfit fromCategory:(CategoryList*)category forUser:(RegisteredUser*)user;


@end
