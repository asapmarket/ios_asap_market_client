//
//  NSURLRequest+SSL.h
//  chason
//
//  Created by chason on 17/4/14.
//  Copyright © 2017年 Nanjing G•life E-Business Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (SSL)
+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+(void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end
