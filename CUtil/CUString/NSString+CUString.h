//
//  NSString+CUString.h
//  CUtil
//
//  Created by Acttos on 12/20/16.
//  Sources https://github.com/acttos/CommonUtilities
//  Copyright © 2016 Acttos.org. All codes follow MIT License.
//

#import <Foundation/Foundation.h>

@interface NSString (CUString)

-(NSUInteger)indexOf:(NSString *)pattern;
-(NSUInteger)lastIndexOf:(NSString *)pattern;

-(void)replaceFirst:(NSString *)pattern with:(NSString *)replacement;
-(void)replaceLast:(NSString *)pattern with:(NSString *)replacement;
-(void)replaceAll:(NSString *)pattern with:(NSString *)replacement;

@end
