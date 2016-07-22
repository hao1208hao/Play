//
//  QDBDataManager.h
//  
//
//  Created by haohao on 16/3/10.
//  Copyright © 2016年 某某某. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    deleteFileKey,
    deleteFileIndex,
    deleteFileAll
} deleteFileType;

@interface QDBDataManager : NSObject

/**
 *  创建Plist文件,并返回路径
 *
 *  @param fileName 文件名
 */
+(NSString*)getFilePath:(NSString*)fileName;

/**
 *  读文件
 *
 *  @param fileName 文件名
 *
 *  @return 返回文件数据内容
 */
+(NSMutableDictionary*)readDictFileWithFileName:(NSString*)fileName;

/**
 *  读文件
 *
 *  @param fileName 文件名
 *
 *  @return 返回文件数据内容
 */
+(NSMutableArray*)readArrFileWithFileName:(NSString*)fileName;

/**
 *  写数据到文件
 *
 *  @param writeData 写入文件的数据内容
 *  @param fileName  文件名
 */
+(void)writeData:(id)writeData toFile:(NSString*)fileName;

/**
 *  删除文件中的元素
 *
 *  @param fileName   删除指定文件
 *  @param deleteType 删除类型  通过key、下标删除一个或者全部删除
 *  @param val        通过关键字删除
 *
 *  @return 返回新数据
 */
+(NSMutableDictionary*)deleteDictFromFile:(NSString*)fileName andDeleteType:(deleteFileType)deleteType andVal:(id)val;

/**
 *  删除文件中的某个元素
 *
 *  @param fileName   删除指定文件
 *  @param deleteType 删除类型  通过key、下标删除一个或者全部删除
 *  @param val        通过关键字删除
 *
 *  @return 返回新数据
 */
+(NSMutableArray*)deleteArrFromFile:(NSString*)fileName andDeleteType:(deleteFileType)deleteType andVal:(id)val;

/**
 *  删除文件
 *
 *  @param fileName 文件名
 */
+(void)deleteDataFromFile:(NSString*)fileName;

/**
 *  保存到NSUserDefaults中
 *
 *  @param key key值
 *  @param obj val值
 */
+(void)saveUserDefaultWithKey:(NSString*)key andObj:(NSObject*)obj;

/**
 *  从NSUserDefaults中取值
 *
 *  @param key key值
 *
 *  @return 通过key取到的值
 */
+(instancetype)getUserDefaultWithKey:(NSString*)key;

/**
 *  删除NSUserDefaults中的某个值
 *
 *  @param key key值
 */
+(void)deleteUserDefaultForKey:(NSString*)key;

/**
 *  加密(数据存储时加密)
 *
 *  @param plainText 需要加密的字符
 *
 *  @return 返回加密后的数据
 */
+ (NSString *) encryDES:(NSString *)plainText;

/**
 *  解密
 *
 *  @param cipherText 解密的字符串
 *
 *  @return 返回解密后数据
 */
+ (NSString *) decryDES:(NSString*)cipherText;

@end
