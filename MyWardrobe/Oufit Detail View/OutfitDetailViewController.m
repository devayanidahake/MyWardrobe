//
//  OutfitDetailViewController.m
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "OutfitDetailViewController.h"

@interface OutfitDetailViewController ()
{
    NSMutableArray * arrOutfitDetail;
}
@end

@implementation OutfitDetailViewController

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
    lblTitle.text = self.outfit.title;
     lblPrice.text = self.outfit.price;
     lblDate.text = self.outfit.date;
     lblDiscription.text = self.outfit.discription;
    [imgViewOutfit setImage:[UIImage imageWithContentsOfFile:self.outfit.image]];
    arrOutfitDetail =[[NSMutableArray alloc]init];
    [arrOutfitDetail addObject:[NSString stringWithFormat:@"Title      : %@",self.outfit.title]];
    [arrOutfitDetail addObject:[NSString stringWithFormat:@"Purchase Cost      : %@",self.outfit.price]];
    [arrOutfitDetail addObject:[NSString stringWithFormat:@"Purchase Date      : %@",self.outfit.date]];
     [arrOutfitDetail addObject:[NSString stringWithFormat:@"Details     : %@",self.outfit.discription]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrOutfitDetail count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = arrOutfitDetail[indexPath.row];
    return cell;
}


@end
