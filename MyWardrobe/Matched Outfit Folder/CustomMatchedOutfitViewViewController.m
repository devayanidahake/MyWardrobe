//
//  CustomMatchedOutfitViewViewController.m
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "CustomMatchedOutfitViewViewController.h"

@interface CustomMatchedOutfitViewViewController ()
{
    NSMutableArray *arrCaterory;
    NSMutableArray *arrOutfit;
}
@end

@implementation CustomMatchedOutfitViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFrame:(CGRect)_rect
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame = _rect;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RegisteredUser *user = [DatabaseManager getCurrentUser];
    arrCaterory= [[NSMutableArray alloc]init];
    for (CategoryList *catObj in user.regusertoCategorylist) {
        
        [arrCaterory addObject:catObj];
    }
    arrOutfit= [[NSMutableArray alloc]init];
    for (CategoryList *catObj in user.regusertoCategorylist) {
        [arrCaterory addObject:catObj];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)slideMenuView:(SlideMenuView *)menuView DidSelectMenu:(NSString *)menuTitle
{
    
}

-(void)slideMenuViewDoHide:(SlideMenuView *)slideMenuView
{
    
}

-(void)slideMenuViewDoShow:(SlideMenuView *)slideMenuView
{
    
}

@end
