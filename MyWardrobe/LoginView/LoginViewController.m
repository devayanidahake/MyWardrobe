//
//  LoginViewController.m
//  MyWardrobe
//
//  Created by Mackintosh on 21/01/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "CategoryViewController.h"
@interface LoginViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation LoginViewController

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
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_SignupClicked:(id)sender
{
    SignupViewController *obj_SignupView = [[SignupViewController alloc] initWithNibName:@"SignupViewController" bundle:nil];
    [self presentViewController:obj_SignupView animated:YES completion:nil];
    
    
}

- (IBAction)btn_LoginClicked:(id)sender
{
    NSFetchRequest *request =[[NSFetchRequest alloc]initWithEntityName:@"RegisteredUser"];
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"username =%@ and password =%@",txt_username.text,txt_password.text];
    [request setPredicate:predicate];
    NSError *error;
    RegisteredUser *regUser = [[appDelegate.managedObjectContext executeFetchRequest:request error:&error] lastObject];
    
    if (!error && regUser)
    {
         NSLog(@"user data==%@",regUser.username);
        CategoryViewController *obj_categoryView =[[CategoryViewController alloc] initWithStyle:UITableViewStyleGrouped];
        obj_categoryView.view.frame=self.view.frame;
        UINavigationController *obj_navigationController =[[UINavigationController alloc]initWithRootViewController:obj_categoryView];
        [self presentViewController:obj_navigationController animated:YES completion:nil];
        [[NSUserDefaults standardUserDefaults]setValue:regUser.username forKey:@"currentUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
//        UIAlertView *alert=[[UIAlertView alloc] ];
    }
    
}

#pragma textfield delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txt_username) {
        [txt_password becomeFirstResponder];
    }
    if (textField == txt_password) {
        [txt_password resignFirstResponder
         ];
    }
    return YES;
}

@end
