//
//  OutfitAddViewController.h
//  MyWardrobe
//
//  Created by Mackintosh on 29/03/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "DatabaseManager.h"
@interface OutfitAddViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    __weak IBOutlet UIImageView *imgV_Outfit;
    __weak IBOutlet UITextField *title_Outfit;

    __weak IBOutlet UITextField *price_Outfit;
    __weak IBOutlet UITextField *date_Outfit;
    __weak IBOutlet UITextField *discription_Outfit;
    NSData * imageDataCaptured;
    BOOL newMedia;
}
@property(nonatomic,retain) CategoryList *categoryName;
- (IBAction)btn_OutfitImageClicked:(id)sender;

- (IBAction)btn_saveClicked:(id)sender;
- (IBAction)btn_cancelClicked:(id)sender;
@end
