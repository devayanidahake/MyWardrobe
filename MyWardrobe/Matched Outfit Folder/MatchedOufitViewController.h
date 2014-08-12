//
//  MatchedOufitViewController.h
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuView.h"
#import "BCMenuView.h"
#import "CustomMatchedOutfitViewViewController.h"
#import "DatabaseManager.h"

@interface MatchedOufitViewController : UIViewController<BCMenuViewDelegate,SlideMenuViewDelegate>
{
    BCMenuView  * menu1;
    SlideMenuView * subMenu1;
    
    NSArray * menu1_Arr1;
    NSArray * menu1_Arr2;
    
    BCMenuView  * menu2;
    SlideMenuView * subMenu2;
    IBOutlet UIScrollView *scrollView;
}

@end
