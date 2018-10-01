//
//  NSURLRequest+SSL.m
//  chason
//
//  Created by chason on 17/4/14.
//  Copyright © 2017年 Nanjing G•life E-Business Co., Ltd. All rights reserved.
//

#import "NSURLRequest+SSL.h"

@implementation NSURLRequest (SSL)
+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host{
    return YES;
}

+(void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host{
    
}
@end
