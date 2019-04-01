//
//  NSDictionary+AXNetworkingMethods.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/4/1.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "NSDictionary+AXNetworkingMethods.h"

@implementation NSDictionary (AXNetworkingMethods)

- (NSString *)RC_transformToUrlParamString
{
    NSMutableString *paramString = [NSMutableString string];
    for (int i = 0; i < self.count; i ++) {
        NSString *string;
        if (i == 0) {
            string = [NSString stringWithFormat:@"?%@=%@", self.allKeys[i], self[self.allKeys[i]]];
        } else {
            string = [NSString stringWithFormat:@"&%@=%@", self.allKeys[i], self[self.allKeys[i]]];
        }
        [paramString appendString:string];
    }
    return paramString;
}

- (NSString *)RC_jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
