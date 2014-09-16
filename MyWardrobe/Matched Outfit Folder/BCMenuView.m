//
//  BCScrollView.m
//  MCSD-Scroll-Test
//
//  Created by Bitcode Technologies on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BCMenuView.h"

@implementation BCMenuView
@synthesize scrollView;
@synthesize menuItems;
@synthesize sizeOfMenuItem;
@synthesize delegate;
@synthesize currentIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
    }
    return self;
}

-(void)setup
{
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    
    if(self.scrollView)
    {

        for(UIView * v in [scrollView subviews] )
        {
            [v removeFromSuperview];
        }
        [self.scrollView removeFromSuperview];
        self.scrollView = nil ;
        
    }
    
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((self.bounds.size.width/2)-(self.sizeOfMenuItem/2), 0, self.sizeOfMenuItem, self.bounds.size.height )];
    scrollView.pagingEnabled = YES;
    scrollView.clipsToBounds = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width*self.menuItems.count, self.bounds.size.height);
    currentIndex = 0;
    
    CGRect lastRect = CGRectMake(2.5, 0, sizeOfMenuItem-5, self.bounds.size.height);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(lastRect.origin.x + self.sizeOfMenuItem/2.0 +10.0  , 0, self.sizeOfMenuItem-5, self.bounds.size.height)];
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.borderWidth = 2;
    [self addSubview:view];
    
    int i = 0;
    for(Outfit * outfit in menuItems)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //[btn setTitle:menuName forState:UIControlStateNormal];
        
        ///
        // for Images in Bundle
              // [btn setImage:[UIImage imageWithContentsOfFile:outfit.image] forState:UIControlStateNormal];
         [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:outfit.image]] forState:UIControlStateNormal];
         [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:outfit.image]] forState:UIControlStateSelected];
        
        //btn.backgroundColor = [UIColor yellowColor];
        ///
        // for Images in Doc dir
        //[btn setImage:[UIImage imageWithContentsOfFile:[self.menuItems objectAtIndex:i]] forState:UIControlStateNormal];
        
        
        
        [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = lastRect;
        btn.tag = i;
        i++;
        lastRect = CGRectMake(lastRect.origin.x + self.sizeOfMenuItem + 2.5 , 0, self.sizeOfMenuItem-5, self.bounds.size.height);
        [scrollView addSubview:btn];
        
    }
    if (menuItems && [menuItems count]==0) {
        UILabel *lableNoData = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        lableNoData.text = @"No data available";
        [self.scrollView addSubview:lableNoData];
    }
    
    [self addSubview:scrollView];
    [self bringSubviewToFront:view];
    
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //NSLog(@"did End");
}


-(void)btnTapped:(UIButton*)sender
{
    NSLog(@"Outfit tapped...");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"did Scroll");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"did DeAccelearte");
    //NSLog(@"%f",self -> scrollView.contentOffset.x);
    
    int newIndex = (int) ( self -> scrollView.contentOffset.x / self.sizeOfMenuItem );
    if(currentIndex != newIndex)
    {
        currentIndex = newIndex;
        if([delegate respondsToSelector:@selector(menuView:didSelectMenuItemAtIndex:withMenuName:)])
         {
             [delegate menuView:self didSelectMenuItemAtIndex:currentIndex withMenuName:[self.menuItems objectAtIndex:currentIndex]];
         }
    }
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        if ([[self subviews] count] > 0) {
            //force return of first child, if exists
            return [[self subviews] objectAtIndex:0];
        } else {
            return self;
        }
    }
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
