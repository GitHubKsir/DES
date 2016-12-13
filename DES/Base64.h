//
//  Base64.h
//  DES
//
//  Created by LeadFair on 16/11/11.
//  Copyright © 2016年 LeadFair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+(NSString *)encode:(NSData *)data;
+(NSData *)decode:(NSString *)dataString;


@end
