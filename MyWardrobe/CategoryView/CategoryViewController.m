//
//  CategoryViewController.m
//  MyWardrobe
//
//  Created by Mackintosh on 30/01/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
{
    RegisteredUser *currentUser;
}
@property BOOL editing;
@end

@implementation CategoryViewController
@synthesize editing;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = YES;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *editButton=[[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(addORDeleteRows:)];
    self.navigationItem.rightBarButtonItem = editButton;
    self.editButtonItem.target=self;
    self.navigationController.navigationBarHidden=NO;
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(btnLogoutClicked:)];
    [self.navigationItem setLeftBarButtonItem:backButton animated:YES];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    managedObjectContext = appDelegate.managedObjectContext;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (arr_categoryList) {
        [arr_categoryList removeAllObjects];
        arr_categoryList=nil;
    }
    if (currentUser) {
        currentUser = nil;
       
    }
      currentUser= [DatabaseManager getCurrentUser];
       arr_categoryList = [DatabaseManager getAllCategoriesForUser:currentUser];
    
    [self.tableView reloadData];
}

-(void)btnLogoutClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addORDeleteRows:(id)sender
{
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
        self.editing = NO;
        
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        self.editing = YES;
        
    }
}
-(void)addCategoryForUserWithName:(NSString*)categoryName withType:(NSString*)categoryType
{
   
    CategoryList *obj_cat=[NSEntityDescription insertNewObjectForEntityForName:@"CategoryList" inManagedObjectContext:managedObjectContext];
    obj_cat.name=categoryName;
    obj_cat.type=categoryType;
    if ([DatabaseManager addCategory:obj_cat forUser:currentUser])
        [self viewWillAppear:YES];
   
}

-(void)editButtonClicked:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Add Category" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save",nil];
    alert.alertViewStyle=UIAlertViewStyleDefault;
    UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 70)];
    UITextField *lblName = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    lblName.tag=1000;
    lblName.placeholder=@"category name";
    UITextField *lblType = [[UITextField alloc]initWithFrame:CGRectMake(0, lblName.frame.origin.y + lblName.frame.size.height+5, 250, 30)];
    lblType.tag=1001;
    lblType.placeholder=@"category type";
    [v addSubview:lblName];
    [v addSubview:lblType];
    v.backgroundColor=[UIColor clearColor];
   // [alert addSubview:lbl];
    [alert setValue:v forKey:@"accessoryView"];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *categoryName,*categoryType;
//    if (![categoryName isEqualToString:@""])
//    {
//        [self addCategoryForUserWithName:categoryName];
//    }
    if (buttonIndex == 1) {
        UIView *v = (UIView*)[alertView valueForKey:@"accessoryView"];
        for (UITextField *txt in v.subviews)
        {
            if (txt.tag==1000) {
                categoryName=txt.text;
            }
            else if(txt.tag==1001)
            {
                categoryType=txt.text;
            }
        }
        if (![categoryName isEqualToString:@""] && ![categoryType isEqualToString:@""])
        {
            [self addCategoryForUserWithName:categoryName withType:categoryType];
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
//    NSInteger count = [arr_categoryList count];
//    if(self.editing)
//        count++;
//    return count;
    return [arr_categoryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    CategoryList *obj_category = [arr_categoryList objectAtIndex:indexPath.row];
    cell.textLabel.text = obj_category.name;
    obj_category=nil;
    
    int count = 0;
    if(self.editing && indexPath.row != 0)
        count = 1;
    
    if(indexPath.row == ([arr_categoryList count]) && self.editing){
        cell.textLabel.text = @"Append a new row";
        return cell;
    }
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing == NO || !indexPath)
        return UITableViewCellEditingStyleNone;
    
    if (self.editing && indexPath.row == ([arr_categoryList count]))
        return UITableViewCellEditingStyleInsert;
    else
        return UITableViewCellEditingStyleDelete;
    
    return UITableViewCellEditingStyleNone;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        //
        if ([currentUser isEqual:@""] && !currentUser) {
            currentUser = [DatabaseManager getCurrentUser];
        }
        
        CategoryList *obj_cat= (CategoryList*)[arr_categoryList objectAtIndex:indexPath.row];
        NSString*txt_input= obj_cat.name;
        if (![txt_input isEqualToString:@""])
        {
            for (CategoryList *obj_cat in currentUser.regusertoCategorylist)
            {
                if ([obj_cat.name isEqualToString:txt_input])
                {
                    
                    if ([DatabaseManager removeCategory:obj_cat forUser:currentUser])
                    {
                        [tableView beginUpdates];
                        [arr_categoryList removeObject:obj_cat];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        [tableView endUpdates];
                        break;
                    }
                    
                }
            }
            
            
            
        }

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
//        [arr_categoryList insertObject:@"New version" atIndex:[arr_categoryList count]];
//        [self.tableView reloadData];
        // Delete the row from the data source
        //
//        if ([currentUser isEqual:@""] && !currentUser) {
//            currentUser = [DatabaseManager getCurrentUser];
//        }
//        
//        CategoryList *obj_cat= (CategoryList*)[arr_categoryList objectAtIndex:indexPath.row];
//        NSString*txt_input= obj_cat.name;
//        if (![txt_input isEqualToString:@""])
//        {
//            for (CategoryList *obj_cat in currentUser.regusertoCategorylist)
//            {
//                if ([obj_cat.name isEqualToString:txt_input])
//                {
//                    
//                    if ([DatabaseManager addCategory:obj_cat forUser:currentUser])
//                    {
//                        break;
//                    }
//                    
//                }
//            }
//            
//            [arr_categoryList addObject:obj_cat];
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }

    }
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//       //
//        if ([currentUser isEqual:@""] && !currentUser) {
//            currentUser = [DatabaseManager getCurrentUser];
//        }
//        
//        CategoryList *obj_cat= (CategoryList*)[arr_categoryList objectAtIndex:indexPath.row];
//        NSString*txt_input= obj_cat.name;
//        if (![txt_input isEqualToString:@""])
//        {
//            for (CategoryList *obj_cat in currentUser.regusertoCategorylist)
//            {
//                if ([obj_cat.name isEqualToString:txt_input])
//                {
//                   
//                    if ([DatabaseManager removeCategory:obj_cat forUser:currentUser])
//                    {
//                        break;
//                    }
//                    
//                }
//            }
//           
//            [arr_categoryList removeObject:obj_cat];
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }
//    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//    }
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    addBtn.frame =CGRectMake(10, 5, 30 , 30);
    addBtn.userInteractionEnabled = NO;
    //[addBtn addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 140, 30)];
    lable.text = @"Add new category";
    [lable setTextAlignment:NSTextAlignmentLeft];
    lable.textColor = [UIColor blackColor];
    [view addSubview:lable];
    UIButton *btnFooter = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFooter.frame = CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height);
    [btnFooter addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnFooter];
    return view;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    //    NSString *stringToMove = [self.reorderingRows objectAtIndex:sourceIndexPath.row];
    //    [self.reorderingRows removeObjectAtIndex:sourceIndexPath.row];
    //    [self.reorderingRows insertObject:stringToMove atIndex:destinationIndexPath.row];
}

//- (NSIndexPath *)tableView:(UITableView *)tableView
//targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
//       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
//    NSDictionary *section = [data objectAtIndex:sourceIndexPath.section];
//    NSUInteger sectionCount = [[section valueForKey:@"content"] count];
//    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
//        NSUInteger rowInSourceSection =
//        (sourceIndexPath.section > proposedDestinationIndexPath.section) ?
//        0 : sectionCount - 1;
//        return [NSIndexPath indexPathForRow:rowInSourceSection inSection:sourceIndexPath.section];
//    } else if (proposedDestinationIndexPath.row >= sectionCount) {
//        return [NSIndexPath indexPathForRow:sectionCount - 1 inSection:sourceIndexPath.section];
//    }
//    // Allow the proposed destination.
//    return proposedDestinationIndexPath;
//}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
//    if (indexPath.row == 0) // Don't move the first row
//        return NO;
    return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    OutfitGridViewController *obj_outfitGridView = [[OutfitGridViewController alloc] initWithNibName:@"OutfitGridViewController" bundle:nil];
      // Pass the selected object to the new view controller.
      obj_outfitGridView.category = [arr_categoryList objectAtIndex:indexPath.row];
    // Push the view controller.
    [self.navigationController pushViewController:obj_outfitGridView animated:YES];
}

@end
