//
//  OutfitDetailViewController.m
//  MyWardrobe
//
//  Created by Devayani Dahake on 31/07/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "OutfitDetailViewController.h"

@interface OutfitDetailViewController ()

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
