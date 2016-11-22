//
//  convertGB_BIG.h
//  myTest
//
//  Created by sffofn on 11-8-17.
//  Copyright 2011 keke.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface convertGB_BIG : NSObject {
	NSString*	_string_GB;
	NSString*	_string_BIG5;
    NSString *_string_Hot;
    NSString *_sub;
}

@property(nonatomic, strong) NSString*	string_GB;
@property(nonatomic, strong) NSString*	string_BIG5;
@property(nonatomic, strong) NSString*	string_Hot;
@property(nonatomic, strong) NSString*	sub;
-(NSString*)gbToBig5:(NSString*)srcString;// 简体转繁体
-(NSString*)big5ToGb:(NSString*)srcString;// 繁体转简体

-(NSString*)gbToHot:(NSString*)srcString; //简体转火星文
-(NSString*)hotToGb:(NSString*)srcString; //火星文转简体

-(NSString*)subTo:(NSString*)srcString; //简体拆字
@end
