//
//  CDEUserInsertionOperation.h
//  iOSExample
//
//  Created by William Boles on 25/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDEUserInsertionOperation : NSOperation

- (instancetype)initWithCompletion:(void (^)(void))completion;

@end
