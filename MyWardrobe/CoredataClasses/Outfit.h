//
//  Outfit.h
//  MyWardrobe
//
//  Created by Mackintosh on 29/03/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CategoryList, RegisteredUser;

@interface Outfit : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * discription;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) CategoryList *outfittoCategorylist;
@property (nonatomic, retain) RegisteredUser *outfittoReguser;

@end
