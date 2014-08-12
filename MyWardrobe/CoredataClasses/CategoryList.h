//
//  CategoryList.h
//  MyWardrobe
//
//  Created by Devayani Dahake on 01/08/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Outfit, RegisteredUser;

@interface CategoryList : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *categorylisttoOutfit;
@property (nonatomic, retain) RegisteredUser *categorylisttoReguser;
@end

@interface CategoryList (CoreDataGeneratedAccessors)

- (void)addCategorylisttoOutfitObject:(Outfit *)value;
- (void)removeCategorylisttoOutfitObject:(Outfit *)value;
- (void)addCategorylisttoOutfit:(NSSet *)values;
- (void)removeCategorylisttoOutfit:(NSSet *)values;

@end
