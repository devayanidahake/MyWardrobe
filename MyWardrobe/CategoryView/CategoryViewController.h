//
//  CategoryViewController.h
//  MyWardrobe
//
//  Created by Mackintosh on 30/01/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutfitGridViewController.h"
#import "DatabaseManager.h"
@interface CategoryViewController : UITableViewController<UIAlertViewDelegate>
{
    NSMutableArray *arr_categoryList;
    NSManagedObjectContext *managedObjectContext;
}
@end
