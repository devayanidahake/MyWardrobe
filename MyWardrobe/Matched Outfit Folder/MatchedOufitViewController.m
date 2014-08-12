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
    float x=0,y=0;
    RegisteredUser *currentUser = [DatabaseManager getCurrentUser];
    for (CategoryList *category in currentUser.regusertoCategorylist) {
        CustomMatchedOutfitViewViewController *customViewObj = [[CustomMatchedOutfitViewViewController alloc]initWithNibName:@"CustomMatchedOutfitViewViewController" bundle:nil withFrame:CGRectMake(x, y, scrollView.frame.size.width, 350)];
        y+=350;
        [scrollView addSubview:customViewObj.view];
        [arrCustomMatchedViews addObject:customViewObj];
    }
    
   // [scrollView addSubview:<#(UIView *)#>]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
