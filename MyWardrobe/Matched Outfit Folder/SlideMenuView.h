//
//  SlideMenuView.h
//  slideToBringTheMenu
//
//  Created by Bharat Jagtap on 09/02/13.
//  Copyright (c) 2013 Bharat Jagtap. All rights reserved.
//

#import <UIKit/UIKit.h> 

@class SlideMenuView;


@protocol SlideMenuViewDelegate <NSObject>

- (void)slideMenuView:(SlideMenuView*)menuView DidSelectMenu:(NSString*)menuTitle;
- (void)slideMenuViewDoShow:(SlideMenuView*)slideMenuView;
- (void)slideMenuViewDoHide:(SlideMenuView*)slideMenuView;

@end



@interface SlideMenuView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView * menuTable;
    BOOL isVisible;
    
    
}

@property(nonatomic,retain) NSArray * menuItems;
@property(nonatomic,assign) id < SlideMenuViewDelegate > delegate;

@end