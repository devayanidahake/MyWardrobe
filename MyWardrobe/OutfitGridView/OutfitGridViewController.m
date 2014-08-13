//
//  OutfitGridViewController.m
//  MyWardrobe
//
//  Created by Mackintosh on 21/03/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "OutfitGridViewController.h"

@interface OutfitGridViewController ()
{
    AppDelegate *appDelegate;
    RegisteredUser *currentUser;

}
@end

@implementation OutfitGridViewController
@synthesize category;
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
    [collectionviewOutfit registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:5];
    [flowLayout setMinimumLineSpacing:5];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [flowLayout setItemSize:CGSizeMake(90, 90)];
    [flowLayout setHeaderReferenceSize:CGSizeZero];
    [collectionviewOutfit setCollectionViewLayout:flowLayout];
    collectionviewOutfit.backgroundColor = [UIColor clearColor];
    appDelegate = [[UIApplication sharedApplication]delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    
    //[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnAddCategoryClicked:)] animated:YES];
    UIBarButtonItem *categoryButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnAddCategoryClicked:)];
    UIBarButtonItem *matchedOutfitButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(btnmatchedOutfitClicked:)];
    
    //    matchedOutfitButton.frame = CGRectMake((self.view.frame.size.width - 50)/2, 5, 50, 40);
   // matchedOutfitButton.backgroundColor=[UIColor greenColor];
    //self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnAddCategoryClicked:)] animated:YES];
   // [matchedOutfitButton addTarget:self action:@selector(btnAddCategoryClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:categoryButton,matchedOutfitButton,nil] animated:YES];
   // [self.navigationController.navigationBar addSubview:matchedOutfitButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    currentUser = [DatabaseManager getCurrentUser];
    if (arr_outfit) {
        [arr_outfit removeAllObjects];
        arr_outfit=nil;
    }
    arr_outfit = [DatabaseManager getAllOutfitsRelatedToCategory:category forUser:currentUser];
    if ([arr_outfit count]==0)
    {
        NSLog(@"no outfit is there....");
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No outfit is present" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    [collectionviewOutfit reloadData];
}
#pragma collection view delegate methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arr_outfit count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"  forIndexPath:indexPath];
    if ([arr_outfit count] > 0 && indexPath.row != [arr_outfit count])
    {
        Outfit *objOutfit = (Outfit*)[arr_outfit objectAtIndex:indexPath.row];
        if (objOutfit)
        {
            imgView_outfit=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
            [imgView_outfit setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:objOutfit.image]]];
            imgView_outfit.opaque = YES;
            [imgView_outfit setUserInteractionEnabled:YES];
            [cell.contentView  addSubview:imgView_outfit];
        }
    }
    
    return cell;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UIView *viewPopover = [UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)
    OutfitDetailViewController * obj_OutfitDetailView = [[OutfitDetailViewController alloc]initWithNibName:@"OutfitDetailViewController" bundle:nil];
    obj_OutfitDetailView.outfit = arr_outfit[indexPath.row];
    [self.navigationController pushViewController:obj_OutfitDetailView animated:YES];
}

-(void)btnAddCategoryClicked:(id)sender
{
    OutfitAddViewController *obj_OutfitAddView = [[OutfitAddViewController alloc] initWithNibName:@"OutfitAddViewController" bundle:nil];
    NSLog(@"category=%@",category);
    obj_OutfitAddView.categoryName = category;
    [self presentViewController:obj_OutfitAddView animated:YES completion:nil];

}
-(void)btnmatchedOutfitClicked:(id)sender
{
    MatchedOufitViewController * obj_MatchedOufitView = [[MatchedOufitViewController alloc]initWithNibName:@"MatchedOufitViewController" bundle:nil];
    [self.navigationController pushViewController:obj_MatchedOufitView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
