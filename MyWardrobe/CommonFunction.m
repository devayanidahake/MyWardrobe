//
//  CommonFunction.m
//  MyWardrobe
//
//  Created by Devayani Dahake on 23/04/14.
//  Copyright (c) 2014 Mackintosh. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction
+(UIImage*)getImageWithName:(NSString*)imageName
{
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",[self getResourcePathFromBundle],imageName];
    return [UIImage imageWithContentsOfFile:imagePath];
}

+(NSString*)getResourcePathFromBundle
{
    return [[NSBundle mainBundle]resourcePath];
}
@end
