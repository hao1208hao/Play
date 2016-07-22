//
//  NSString+reverse.m
//  qiandaibao_pos
//
//  Created by 亮亮 on 16/5/10.
//  Copyright © 2016年 钱袋宝. All rights reserved.
//

#import "NSString+reverse.h"

@implementation NSString (reverse)

-(NSString *)reverse{
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i=self.length; i>0; i--) {
        [s appendString:[self substringWithRange:NSMakeRange(i-1, 1)]];
    }
    return s;
}

@end
