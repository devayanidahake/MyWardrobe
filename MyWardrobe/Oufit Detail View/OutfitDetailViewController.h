//
//  OutfitDetailViewController.h
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutfitDetailViewController : UIViewController
{
    
    IBOutlet UIImageView *imgViewOutfit;
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblPrice;
    IBOutlet UILabel *lblDate;
    IBOutlet UILabel *lblDiscription;
}
@property(nonatomic,retain)Outfit *outfit;
@end
