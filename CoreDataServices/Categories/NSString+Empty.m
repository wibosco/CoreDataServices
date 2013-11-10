//
//  NSString+Empty.m
//  Boles
//
//  Created by William Boles on 15/06/2012.
//  Copyright (c) 2012 Boles. All rights reserved.
//

#import "NSString+Empty.h"

@implementation NSString (Empty)

#pragma mark - Empty

- (BOOL) isEmpty
{
    if ([self length] == 0) {
        
        return YES;
        
    } else {
        
        NSString *trimmedString = [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([trimmedString length] == 0) {
            
            return YES;
            
        }
    }
    
    return NO; 
}

+ (BOOL) isStringEmpty:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]]){
        
        return YES;
        
    }
    
    if ([string length] == 0) {
        
        return YES;
        
    } else {
        
        NSString *trimmedString = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([trimmedString length] == 0) {
            
            return YES;
            
        }
    }
    
    return NO;
}

@end
