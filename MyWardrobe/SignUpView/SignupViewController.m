//
//  SignupViewController.m
//  MyWardrobe
//
//  Created by Mackintosh on 29/01/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation SignupViewController

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
    appDelegate =[[UIApplication sharedApplication] delegate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma user actions
- (IBAction)btn_RegisterClicked:(id)sender
{
    if (![txt_name.text isEqualToString:@""] && ![txt_username.text isEqualToString:@""] && ![txt_password.text isEqualToString:@""] && ![txt_gender.text isEqualToString:@""])
    {
        RegisteredUser *obj_ResisterdUser=[NSEntityDescription insertNewObjectForEntityForName:@"RegisteredUser" inManagedObjectContext:appDelegate.managedObjectContext];
        obj_ResisterdUser.name=txt_name.text;
        obj_ResisterdUser.username=txt_username.text;
        obj_ResisterdUser.password=txt_password.text;
        obj_ResisterdUser.gender=txt_gender.text;
        obj_ResisterdUser.age=txt_age.text;
        NSError *error;
        [appDelegate.managedObjectContext save:&error];
        if (!error) {
            NSLog(@"registrationiscompleted-%@",obj_ResisterdUser);
            
        }
        error =nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Field is empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)btn_CancelClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma textfield delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txt_name) {
        [txt_username becomeFirstResponder];
    }
    if (textField == txt_username) {
        [txt_password becomeFirstResponder];
    }
    if (textField == txt_password) {
        [txt_gender becomeFirstResponder];
    }
    if (textField == txt_gender) {
        [txt_age becomeFirstResponder];
    }
    if (textField == txt_age) {
        [txt_age resignFirstResponder
         ];
    }
    return YES;
}

@end
