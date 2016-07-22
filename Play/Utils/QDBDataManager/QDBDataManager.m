//
//  QDBDataManager.m
//  
//
//  Created by haohao on 16/3/10.
//  Copyright © 2016年 某某某. All rights reserved.
//

#import "QDBDataManager.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@implementation QDBDataManager

+(NSString*)getFilePath:(NSString*)fileName{
    if ([fileName rangeOfString:@"."].location ==NSNotFound) {
        fileName = [NSString stringWithFormat:@"%@.plist",fileName];
    }
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths lastObject];
    path=[path stringByAppendingPathComponent:fileName];
    
    if ([fileName rangeOfString:@"."].location ==NSNotFound) {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return path;
}

+(NSDictionary*)readDictFileWithFileName:(NSString*)fileName{
    NSString* path = [self getDefaultPathWithFileName:fileName];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:path];
    return dict;
}

+(NSMutableArray*)readArrFileWithFileName:(NSString*)fileName{
    NSString* path = [self getDefaultPathWithFileName:fileName];
    NSMutableArray* arr = [NSMutableArray arrayWithContentsOfFile:path];
    return arr;
}

+(void)writeData:(id)writeData toFile:(NSString*)fileName{
    NSString* path = [self getDefaultPathWithFileName:fileName];
    [writeData writeToFile:path atomically:YES];
}

+(NSMutableDictionary*)deleteDictFromFile:(NSString*)fileName andDeleteType:(deleteFileType)deleteType andVal:(id)val{
    
    NSMutableDictionary* fileDict = [self readDictFileWithFileName:fileName];
        
    if (deleteType == deleteFileKey) {
        [fileDict removeObjectForKey:val];
    }else if(deleteType == deleteFileAll){
        [fileDict removeAllObjects];
    }
    
    NSString* filePath = [self getDefaultPathWithFileName:fileName];
    [fileDict writeToFile:filePath atomically:YES];
    return fileDict;
}

+(NSMutableArray*)deleteArrFromFile:(NSString*)fileName andDeleteType:(deleteFileType)deleteType andVal:(id)val{
    NSMutableArray* fileArr = [self readArrFileWithFileName:fileName];
    
    if (deleteType == deleteFileIndex) {
        [fileArr removeObjectAtIndex:(int)val];
    }else if(deleteType == deleteFileKey){
        [fileArr removeObject:val];
    }else if(deleteType == deleteFileAll){
        [fileArr removeAllObjects];
    }
    NSString* filePath = [self getDefaultPathWithFileName:fileName];
    [fileArr writeToFile:filePath atomically:YES];
    return fileArr;
}

+(void)deleteDataFromFile:(NSString*)fileName{
    NSString* path = [self getDefaultPathWithFileName:fileName];
    
    NSFileManager *fileMger = [NSFileManager defaultManager];
    //如果文件路径存在的话
    BOOL fileExist = [fileMger fileExistsAtPath:path];
    if (fileExist) {
        //NSError *err;
        [fileMger removeItemAtPath:path error:nil];
    }
}

+(void)saveUserDefaultWithKey:(NSString*)key andObj:(NSObject*)obj{
    
    NSString* encryKeyStr = [self encryDES:key];
    NSString* encryObjStr = [self encryDES:obj];
    [userDefaults setObject:encryObjStr forKey:encryKeyStr];
    [userDefaults synchronize];
}

+(instancetype)getUserDefaultWithKey:(NSString*)key{
    NSString* encryKeyStr = [self encryDES:key];
    NSObject* obj = userDefaultsForKey(encryKeyStr);
    obj = [self decryDES:obj];
    return  obj;
}

+(void)deleteUserDefaultForKey:(NSString*)key{
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

+(NSString*)getDefaultPathWithFileName:(NSString*)fileName{
    if ([fileName rangeOfString:@"."].location ==NSNotFound) {
         fileName = [NSString stringWithFormat:@"%@.plist",fileName];
    }
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths lastObject];
    path=[path stringByAppendingPathComponent:fileName];
    return path;
}


/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
+ (NSString *) encryDES:(NSString *)plainText{
    NSString* key = md5Key;
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}

//解密
+ (NSString *) decryDES:(NSString*)cipherText{
    NSString* key = md5Key;
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

@end
