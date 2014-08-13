//
//  MatchedOufitViewController.m
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "MatchedOufitViewController.h"

@interface MatchedOufitViewController ()
{
    NSMutableArray *arrCustomMatchedViews;
}
@end

@implementation MatchedOufitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrCustomMatchedViews =[[NSMutableArray alloc]init];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self prepareViewForCategoriesAndOutfits];
}

-(void)prepareViewForCategoriesAndOutfits
{
    if (scrollView) {
        for (UIView *v in scrollView.subviews) {
            [v removeFromSuperview];
        }
    }
    
    int y=0;
    int  i=1;
    NSMutableArray *result =[[NSMutableArray alloc]init];
    
    RegisteredUser *currentUser = [DatabaseManager getCurrentUser];
    NSString *str = [NSString stringWithFormat:@"%d",i++];

    for (CategoryList *category in currentUser.regusertoCategorylist) {
        if ([category.type isEqualToString:str]) {
            [result addObject:category];
        }
    }
    if (result && [result count]>0) {
        CustomMatchedOutfitViewViewController *customViewObj = [[CustomMatchedOutfitViewViewController alloc]initWithNibName:@"CustomMatchedOutfitViewViewController" bundle:nil withFrame:CGRectMake(0, y, scrollView.frame.size.width, 150) withCatArray:result];
        [scrollView addSubview:customViewObj.view];
        [arrCustomMatchedViews addObject:customViewObj];

    }
//    for (CategoryList *category in currentUser.regusertoCategorylist) {
//        
//        CustomMatchedOutfitViewViewController *customViewObj = [[CustomMatchedOutfitViewViewController alloc]initWithNibName:@"CustomMatchedOutfitViewViewController" bundle:nil withFrame:CGRectMake(x, y, scrollView.frame.size.width, 350) withCatType:[NSString stringWithFormat:@"%d",i++]];
//        y+=350;
//        [scrollView addSubview:customViewObj.view];
//        [arrCustomMatchedViews addObject:customViewObj];
//    }
    
   // [scrollView addSubview:<#(UIView *)#>]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
