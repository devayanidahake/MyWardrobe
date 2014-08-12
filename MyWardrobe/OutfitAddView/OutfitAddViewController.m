//
//  OutfitAddViewController.m
//  MyWardrobe
//
//  Created by Mackintosh on 29/03/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "OutfitAddViewController.h"
#import "Outfit.h"
#define CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define CHARACTERS_NUMBERS [CHARACTERS stringByAppendingString:@"1234567890"]

@interface OutfitAddViewController ()

@end

@implementation OutfitAddViewController
@synthesize categoryName;
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
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    date_Outfit.inputView = datePicker;
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextFieldDate:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma textfield delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == title_Outfit) {
        [price_Outfit becomeFirstResponder];
    }
    if (textField == price_Outfit) {
        [date_Outfit resignFirstResponder];
    }
    if (textField == date_Outfit) {
        [discription_Outfit becomeFirstResponder];
    }
    if (textField == discription_Outfit) {
        [discription_Outfit resignFirstResponder];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == date_Outfit) {
        UIDatePicker *datePicker1 = (UIDatePicker*) date_Outfit.inputView ;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateStyle = NSDateFormatterMediumStyle;
        date_Outfit.text = [NSString stringWithFormat:@"%@",
                          [df stringFromDate:[datePicker1 date]]];
        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    @try {
        int newLength = [textField.text length] + string.length - range.length;
        if (textField == title_Outfit) {
            NSCharacterSet *unacceptedInput =
            [[NSCharacterSet characterSetWithCharactersInString:CHARACTERS_NUMBERS] invertedSet];
            
            if ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] > 1)
                return NO;
            else
                return YES &&(newLength < 20);
            
            return YES;
        }
        else if (textField == price_Outfit) {
            NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            
            if ([[string componentsSeparatedByCharactersInSet:nonNumberSet] count] > 1)
                return NO;
            else
                return YES &&(newLength < 20);
            
            return YES;
        }
        else if (textField == discription_Outfit) {
            NSCharacterSet *unacceptedInput =
            [[NSCharacterSet characterSetWithCharactersInString:CHARACTERS_NUMBERS] invertedSet];
            
            if ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] > 1)
                return NO;
            else
                return YES &&(newLength < 30);
            
            return YES;
        }
        return YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

}

// To select image for outFit
- (IBAction)btn_OutfitImageClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Select Option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Via Camera",@"Via Gallery",nil];
    actionSheet.frame = self.view.frame ;
    [actionSheet showInView:self.view];
   
}
-(void)updateTextFieldDate:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    date_Outfit.text = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:[sender date]]];
}

#pragma ActionSheetDelegate methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
             [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera])
            {
                 UIImagePickerController *obj_Picker = [[UIImagePickerController alloc]init];
                 [obj_Picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                 obj_Picker.delegate = self;
                    obj_Picker.mediaTypes = @[(NSString *) kUTTypeImage];
                obj_Picker.allowsEditing = NO;
                
                [self presentViewController:obj_Picker animated:YES completion:nil];
                newMedia = YES;
            }
            break;
        }
        case 1:
        {
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            NSLog(@"buttonIndex= %@",[actionSheet buttonTitleAtIndex:buttonIndex]);
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypePhotoLibrary])
            {
                UIImagePickerController *obj_Picker = [[UIImagePickerController alloc]init];
                [obj_Picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                obj_Picker.delegate = self;
                obj_Picker.mediaTypes = @[(NSString *) kUTTypeImage];
                obj_Picker.allowsEditing = NO;
                newMedia = NO;
                [self presentViewController:obj_Picker animated:YES completion:nil];
            }
             break;
        }
        default:
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            break;
    }
}

#pragma PickerView methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    imageDataCaptured = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage]);
    [picker  dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        imgV_Outfit.image = image;
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
      [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}
- (IBAction)btn_saveClicked:(id)sender
{
    @try {
        NSString *errorMsg = [self validateField];
        if (![errorMsg isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Note" message:errorMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            AppDelegate*appDel=[[UIApplication sharedApplication] delegate];
            RegisteredUser *currentUser=[DatabaseManager getCurrentUser];
            
            if (currentUser.regusertoCategorylist)
            {
                for (CategoryList *catList in currentUser.regusertoCategorylist)
                {
                    if ([catList.name isEqualToString:categoryName.name])
                    {
                        NSLog(@"executed...____");
                        Outfit *Obj_Outfit = [NSEntityDescription insertNewObjectForEntityForName:@"Outfit" inManagedObjectContext:appDel.managedObjectContext];
                        Obj_Outfit.title = title_Outfit.text;
                        Obj_Outfit.price = price_Outfit.text;
                        Obj_Outfit.date = date_Outfit.text;
                        Obj_Outfit.discription = discription_Outfit.text;
                        static int i = 0001;
                        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                        NSString *imageName = [NSString stringWithFormat:@"%@%@%d",currentUser.name,categoryName.name,i];

                        NSString * imagePath = [NSString stringWithFormat:@"%@/%@.png",filePath,imageName];
                        i++;
        
                        [imageDataCaptured writeToFile:imagePath atomically:YES];
                        NSLog(@"image is inserted...");
                            Obj_Outfit.image = imagePath;
                        
                        if ([DatabaseManager addOufit:Obj_Outfit toCategory:catList forUser:currentUser])
                        {
                        }
                    }
                }
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
   
}
-(NSString*)validateField
{
    if ([[title_Outfit.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        return @"Please enter title";
    }
    else if ([[price_Outfit.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        return @"Please enter price";
    }
    else if ([[date_Outfit.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        return @"Please enter date";
    }
    else if ([[discription_Outfit.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        return @"Please enter discription";
    }
    return @"";
}
- (IBAction)btn_cancelClicked:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
