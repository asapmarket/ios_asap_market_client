//
//  NSData+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "NSData+extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (extension)

- (NSString*)md5{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(NSData *)AES128EncryptWithKey:(NSString *)key{
    char keyByte[key.length];
    for (int i=0; i<key.length; i++) {
        char byte=(char)[key characterAtIndex:i];
        keyByte[i]=byte;
    }
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    const char *iVStr = [@"key" UTF8String];
    unsigned char iv[CC_MD5_DIGEST_LENGTH];
    CC_MD5(iVStr, (CC_LONG)strlen(iVStr), iv);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyByte, kCCKeySizeAES128,
                                          iv /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData *)AES128DecryptWithKey:(NSString *)key{
    char keyByte[key.length];
    for (int i=0; i<key.length; i++) {
        char byte=(char)[key characterAtIndex:i];
        keyByte[i]=byte;
    }
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    const char *iVStr = [@"key" UTF8String];
    unsigned char iv[CC_MD5_DIGEST_LENGTH];
    CC_MD5(iVStr, (CC_LONG)strlen(iVStr), iv);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyByte, kCCKeySizeAES128,
                                          iv /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)base64Str{
    if (base64Str.length%4!=0) {
        int num=4-(base64Str.length%4);
        for (int i=0; i<num; i++) {
           base64Str=[base64Str stringByAppendingString:@"="];
        }
    }
    if ([base64Str containsString:@"-"]) {
        base64Str=[base64Str stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    }
    if ([base64Str containsString:@"_"]) {
        base64Str=[base64Str stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    }
    return [[NSData alloc] initWithBase64EncodedString:base64Str options:0];
}

+ (NSString *)base64EncodedStringFrom:(NSData *)data{
    NSString *base64Str=[data base64EncodedStringWithOptions:0];
    if ([base64Str containsString:@"="]) {
        base64Str=[base64Str stringByReplacingOccurrencesOfString:@"=" withString:@""];
    }
    if ([base64Str containsString:@"+"]) {
        base64Str=[base64Str stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    }
    if ([base64Str containsString:@"/"]) {
        base64Str=[base64Str stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    }
    return base64Str;
}
@end
