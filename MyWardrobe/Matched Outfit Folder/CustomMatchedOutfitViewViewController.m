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
    NSArray *arrCaterory;
    NSMutableArray *arrOutfit;
    
}

@end

@implementation CustomMatchedOutfitViewViewController
@synthesize catType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFrame:(CGRect)_rect withCatArray:(NSArray *)categoryArray
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        arrCaterory = categoryArray;
        self.view.frame = _rect;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // RegisteredUser *user = [DatabaseManager getCurrentUser];
    
    arrOutfit= [[NSMutableArray alloc]init];
    for (Outfit *outfitObj in [[arrCaterory objectAtIndex:0] categorylisttoOutfit])
    {
        [arrOutfit addObject:outfitObj];
    }
    outfitView.menuItems = arrOutfit;
    outfitView.sizeOfMenuItem = 150;
    [outfitView setup];
    outfitView.delegate = self;
    

    categoryView = [[SlideMenuView alloc]initWithMenuItems:arrCaterory];
    categoryView.delegate = self;
    categoryView.frame = CGRectMake(-90, 20, 100, 100);
    
    [self.view addSubview:categoryView];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)menuView:(BCMenuView *)menuView didSelectMenuItemAtIndex:(int)index withMenuName:(NSString *)menuName
{
    
   //Need to write one delegate from here.....
    
}

-(void)slideMenuView:(SlideMenuView *)menuView DidSelectMenu:(CategoryList *)selectedCategory
{
    for (CategoryList *catObj in arrCaterory) {
        if ([catObj.name isEqual:selectedCategory.name]) {
            [arrOutfit removeAllObjects];
            for (Outfit *outfitObj in catObj.categorylisttoOutfit)
            {
                [arrOutfit addObject:outfitObj];
                
            }
            outfitView.menuItems = arrOutfit;
            [outfitView setup];
        }
    }
}

-(void)slideMenuViewDoHide:(SlideMenuView *)slideMenuView
{
    [UIView animateWithDuration:0.3 animations:^(){
        CGRect rect = slideMenuView.frame;
        rect.origin.x = - 90;
        slideMenuView.frame = rect;
    }];
    
}

-(void)slideMenuViewDoShow:(SlideMenuView *)slideMenuView
{
    [UIView animateWithDuration:0.3 animations:^(){
        CGRect rect = slideMenuView.frame;
        rect.origin.x = 0;
        slideMenuView.frame = rect;
    }];

}

@end
