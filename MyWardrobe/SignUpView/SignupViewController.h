//
//  SignupViewController.h
//  MyWardrobe
//
//  Created by Mackintosh on 29/01/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisteredUser.h"

@interface SignupViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet UITextField *txt_name;
    __weak IBOutlet UITextField *txt_username;
    __weak IBOutlet UITextField *txt_password;
    __weak IBOutlet UITextField *txt_gender;
    __weak IBOutlet UITextField *txt_age;
}
- (IBAction)btn_RegisterClicked:(id)sender;
- (IBAction)btn_CancelClicked:(id)sender;


@end
