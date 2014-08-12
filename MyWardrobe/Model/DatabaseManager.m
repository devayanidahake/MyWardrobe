//
//  DatabaseManager.m
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager
@synthesize currentUser;
// Ask for logged user
+(AppDelegate*)getAppDelegateInstance
{
    return [[UIApplication sharedApplication]delegate];
}
+(RegisteredUser*)getCurrentUser
{
    RegisteredUser *user = nil;
    //AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *tmp_string=[defaults valueForKey:@"currentUser"];
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:@"RegisteredUser"];
    NSPredicate *predicate= [NSPredicate predicateWithFormat:@"username=%@",tmp_string];
    [req setPredicate:predicate];
    user=[[[self getAppDelegateInstance].managedObjectContext executeFetchRequest:req error:nil]lastObject];
    return user;
}

+(NSMutableArray*)getAllCategoriesForUser:(RegisteredUser*)user
{
    
    //    RegisteredUser *user =[self getCurrentUser];
    if (user.regusertoCategorylist)
    {
        NSMutableArray *arrCategory = [[NSMutableArray alloc]init];
        for (CategoryList *catList in user.regusertoCategorylist)
        {
            [arrCategory addObject:catList];
        }
        user=nil;
        return arrCategory;
    }
    return nil;
}

+(NSMutableArray*)getAllOutfitsRelatedToCategory:(CategoryList*)category forUser:(RegisteredUser*)user

{
    //NSMutableArray *arrOutfit = [[NSMutableArray alloc]init];
    //RegisteredUser *user=[self getCurrentUser];
    if (user.regusertoCategorylist)
    {
        for (CategoryList *catList in user.regusertoCategorylist)
        {
            if ([catList isEqual:category])
            {
                NSMutableArray  *arrOutfit=[[NSMutableArray alloc]init];
                for (Outfit *objOutfit in catList.categorylisttoOutfit)
                {
                    [arrOutfit addObject:objOutfit];
                }
                user=nil;
                return arrOutfit;
            }
        }
    }
    return nil;
}

+(BOOL)addCategory:(CategoryList*)category forUser:(RegisteredUser*)user
{
    [user addRegusertoCategorylistObject:category];
    NSError *error;
    [[self getAppDelegateInstance].managedObjectContext save:&error];
    if (!error) {
        return YES;
    }
    else
        return NO;
}


+(BOOL)removeCategory:(CategoryList*)category forUser:(RegisteredUser*)user
{
    [user removeRegusertoCategorylistObject:category];
    NSError *error;
    [[self getAppDelegateInstance].managedObjectContext save:&error];
    if (!error) {
        return YES;
    }
    else
        return NO;
}

+(BOOL)addOufit:(Outfit*)outfit toCategory:(CategoryList*)category forUser:(RegisteredUser*)user;
{
    [category addCategorylisttoOutfitObject:outfit];
    NSError *error;
    [[self getAppDelegateInstance].managedObjectContext save:&error];
    if (!error) {
        return YES;
    }
    else
        return NO;
}
+(BOOL)removeOufit:(Outfit*)outfit fromCategory:(CategoryList*)category forUser:(RegisteredUser*)user
{
    return YES;
}
@end
