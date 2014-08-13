//
//  CustomMatchedOutfitViewViewController.h
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMenuView.h"
#import "SlideMenuView.h"
#import "DatabaseManager.h"

@interface CustomMatchedOutfitViewViewController : UIViewController<SlideMenuViewDelegate,BCMenuViewDelegate>

{
    CategoryList* categoryObj;
    IBOutlet BCMenuView *outfitView;
    IBOutlet SlideMenuView *categoryView;
}
@property (nonatomic,retain) NSString * catType;
//@property (nonatomic,retain)CategoryList* categoryObj;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFrame:(CGRect)_rect withCatArray:(NSArray*)categoryArray;

@end
