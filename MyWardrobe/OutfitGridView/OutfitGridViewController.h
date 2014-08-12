//
//  OutfitGridViewController.h
//  MyWardrobe
//
//  Created by Mackintosh on 21/03/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutfitAddViewController.h"
#import "OutfitDetailViewController.h"
#import "MatchedOufitViewController.h"
#import "DatabaseManager.h"

@interface OutfitGridViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>
{
    IBOutlet UICollectionView *collectionviewOutfit;
    IBOutlet UIImageView *imgView_outfit;
    NSMutableArray *arr_outfit;
    NSManagedObjectContext *managedObjectContext;
}
@property(nonatomic,retain) CategoryList *category;
@end
