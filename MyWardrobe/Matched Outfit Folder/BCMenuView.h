//
//  BCScrollView.h
//  MCSD-Scroll-Test
//
//  Created by Bitcode Technologies on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCMenuView;
@protocol BCMenuViewDelegate <NSObject>

-(void)menuView:(BCMenuView*)menuView didSelectMenuItemAtIndex:(int)index withMenuName:(NSString*)menuName;

@end


@interface BCMenuView : UIView <UIScrollViewDelegate>
{
    UIScrollView * scrollView;
    int currentIndex;
    
}
@property(nonatomic,assign)id<BCMenuViewDelegate> delegate;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)NSArray * menuItems;
@property(nonatomic) float sizeOfMenuItem;
@property(nonatomic)int currentIndex;
-(void)setup;
@end
