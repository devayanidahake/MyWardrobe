//
//  SlideMenuView.m
//  slideToBringTheMenu
//
//  Created by Bharat Jagtap on 09/02/13.
//  Copyright (c) 2013 Bharat Jagtap. All rights reserved.
//

#import "SlideMenuView.h"

@implementation SlideMenuView
@synthesize menuItems;
@synthesize delegate;

- (id)initWithMenuItems:(NSArray*)categoryArray
{
    self = [super init];
    if (self) {
        

        menuTable = [[UITableView alloc]init];
        menuTable.delegate = self;
        menuTable.dataSource = self;
        menuItems = categoryArray;
        
        
        menuTable.backgroundColor = [UIColor blackColor];
        [self addSubview:menuTable];
        
        isVisible = NO;
        
        self.backgroundColor = [UIColor grayColor];
        
        
    }
    return self;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    if([[touches anyObject] view] == self )
    {
        if (isVisible) {
            
            [self.delegate slideMenuViewDoHide:self];
            isVisible = NO;
        }
        else
        {
            [self.delegate slideMenuViewDoShow:self];
            isVisible = YES;
        }
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    menuTable.frame = CGRectMake(0, 0, self.bounds.size.width - 10, self.bounds.size.height);
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:11.0];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    CategoryList *category = (CategoryList*)[self.menuItems objectAtIndex:indexPath.row];
    cell.textLabel.text = category.name;
    cell.backgroundColor =[UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.delegate)
    {
       if ([self.delegate respondsToSelector:@selector(slideMenuView:DidSelectMenu:)])
       {
           [self.delegate slideMenuView:self DidSelectMenu:[self.menuItems objectAtIndex:indexPath.row]];
           isVisible = NO;
           [self.delegate slideMenuViewDoHide:self];
       }
        
    }
}


@end
