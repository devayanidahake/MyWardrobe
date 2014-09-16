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
    NSMutableArray *arrVisableCategoryList;
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
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(btnSaveClicked:)];
    [self.navigationItem setRightBarButtonItem:saveButton];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //[self prepareViewForCategoriesAndOutfits];
}

-(void)prepareViewForCategoriesAndOutfits
{
    if (scrollView) {
        for (UIView *v in scrollView.subviews) {
            [v removeFromSuperview];
        }
    }
    
    int y=0;
   
    
    RegisteredUser *currentUser = [DatabaseManager getCurrentUser];
    for (int i=0 ; i<3; i++)
    {
        NSMutableArray *result;
        if (result) {
            [result removeAllObjects];
            result = nil;
        }
        result =[[NSMutableArray alloc]init];
        
        for (CategoryList *category in currentUser.regusertoCategorylist)
        {
            
            if ([category.name isEqualToString:[arrVisableCategoryList objectAtIndex:i]]) {
                [result addObject:category];
            }
        }
        if (result && [result count]>0) {
            CustomMatchedOutfitViewViewController *customViewObj = [[CustomMatchedOutfitViewViewController alloc]initWithNibName:@"CustomMatchedOutfitViewViewController" bundle:nil withFrame:CGRectMake(0, y, scrollView.frame.size.width, 150) withCatArray:result];
            [scrollView addSubview:customViewObj.view];
            [arrCustomMatchedViews addObject:customViewObj];
            
        }
        y+=160;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okBtnClicked:(id)sender {
    
    NSString *topCategory = [[(UIButton *)[self.view viewWithTag:1000] titleLabel] text];
    NSString *middleCategory = [[(UIButton *)[self.view viewWithTag:2000] titleLabel] text];
    NSString *bottomCategory = [[(UIButton *)[self.view viewWithTag:3000] titleLabel] text];
    if (!topCategory || !middleCategory || !bottomCategory) {
        NSLog(@"field is empty....");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Field is empty...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [viewCategorySelection setHidden:YES];
        if (arrVisableCategoryList) {
            [arrVisableCategoryList removeAllObjects];
            arrVisableCategoryList=nil;
        }
        
        arrVisableCategoryList =[[NSMutableArray alloc]initWithObjects:topCategory,middleCategory,bottomCategory, nil];
        [self prepareViewForCategoriesAndOutfits];
    }
}
-(void)btnSaveClicked:(id)sender
{
    
}

- (IBAction)btnCategorySelectionClicked:(id)sender {
    RegisteredUser * currentUser= [DatabaseManager getCurrentUser];
     NSArray *arrCat = [DatabaseManager getAllCategoriesForUser:currentUser];
    UIActionSheet *action =[[UIActionSheet alloc]initWithTitle:@"Select Category" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
    action.tag = [sender tag] ;
    for (CategoryList *category in arrCat) {
        [action addButtonWithTitle:category.name];
    }
    action.cancelButtonIndex = [action addButtonWithTitle:@"Cancel"];
    
    [action showInView:self.view];
    
}

#pragma - actionsheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!(buttonIndex == actionSheet.cancelButtonIndex))
    {
        UIButton *btn;
        btn = (UIButton *)[self.view viewWithTag:actionSheet.tag];
        NSString *str = [actionSheet buttonTitleAtIndex:buttonIndex] ;
        [btn setTitle:str forState:UIControlStateNormal];
    }
}

@end
