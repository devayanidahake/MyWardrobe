//
//  LoginViewController.h
//  MyWardrobe
//
//  Created by Mackintosh on 21/01/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
    __weak IBOutlet UITextField *txt_username;
    __weak IBOutlet UITextField *txt_password;
    
    
}
- (IBAction)btn_SignupClicked:(id)sender;
- (IBAction)btn_LoginClicked:(id)sender;


@end
