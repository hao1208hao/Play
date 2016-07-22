/*
 @author: ideawu
 @link: https://github.com/ideawu/Objective-C-RSA
*/

#import <Foundation/Foundation.h>
static NSString *RSA_PUB_KEY = @"-----BEGIN PUBLIC KEY-----\
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwNiX3WUyhloygBjzNFT8sDe6x\
EeHGC24lh89aDni9dvyFYin0JYAjRPH1H7PGtGawJVlk0udt+Gpuo/XOmyCVbz/g\
8oU1ChWU4e6FeslctcC5r2DIS09VHrjT4qU0IDSfsdJJ/Dd/hT8ubCpy5NE5on5w\
KLiPnEF02VpdfpwF5wIDAQAB\
-----END PUBLIC KEY-----";

//static NSString *RSA_PUB_KEY = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwNiX3WUyhloygBjzNFT8sDe6xEeHGC24lh89aDni9dvyFYin0JYAjRPH1H7PGtGawJVlk0udt+Gpuo/XOmyCVbz/g8oU1ChWU4e6FeslctcC5r2DIS09VHrjT4qU0IDSfsdJJ/Dd/hT8ubCpy5NE5on5wKLiPnEF02VpdfpwF5wIDAQAB";

@interface RSA : NSObject

// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
// enc with private key NOT working YET!
//+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
//+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)f
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
@end
