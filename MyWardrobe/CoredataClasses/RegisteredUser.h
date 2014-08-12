//
//  RegisteredUser.h
//  MyWardrobe
//
//  Created by Mackintosh on 11/03/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CategoryList, Outfit;

@interface RegisteredUser : NSManagedObject

@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *regusertoCategorylist;
@property (nonatomic, retain) NSSet *regusertoOutfit;
@end

@interface RegisteredUser (CoreDataGeneratedAccessors)

- (void)addRegusertoCategorylistObject:(CategoryList *)value;
- (void)removeRegusertoCategorylistObject:(CategoryList *)value;
- (void)addRegusertoCategorylist:(NSSet *)values;
- (void)removeRegusertoCategorylist:(NSSet *)values;

- (void)addRegusertoOutfitObject:(Outfit *)value;
- (void)removeRegusertoOutfitObject:(Outfit *)value;
- (void)addRegusertoOutfit:(NSSet *)values;
- (void)removeRegusertoOutfit:(NSSet *)values;

@end
