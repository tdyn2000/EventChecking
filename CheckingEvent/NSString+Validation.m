//
//  NSString+Validation.m
//  CheckingEvent
//
//  Created by ADMIN on 7/11/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (FormValidation)

- (BOOL)isValidInput {
	return (self.length > 0);
}

@end
