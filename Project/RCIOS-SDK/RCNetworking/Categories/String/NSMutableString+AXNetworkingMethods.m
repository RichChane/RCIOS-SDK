//
//  NSMutableString+AXNetworkingMethods.m
//  RCIOS-SDK
//
//  Created by gzkp on 2019/3/30.
//  Copyright © 2019年 RC. All rights reserved.
//

#import "NSMutableString+AXNetworkingMethods.h"
#import "NSObject+AXNetworkingMethods.h"
#import "NSURLRequest+RCNetworkingMethods.h"
#import "NSDictionary+AXNetworkingMethods.h"



@implementation NSMutableString (AXNetworkingMethods)

- (void)appendURLRequest:(NSURLRequest *)request
{
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Origin Params:\n\t%@", request.originRequestParams.RC_jsonString];
    [self appendFormat:@"\n\nHTTP Actual Params:\n\t%@", request.actualRequestParams.RC_jsonString];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] RC_defaultValue:@"\t\t\t\tN/A"]];
    
    NSMutableString *headerString = [[NSMutableString alloc] init];
    [request.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *header = [NSString stringWithFormat:@" -H \"%@: %@\"", key, obj];
        [headerString appendString:header];
    }];
    
    [self appendString:@"\n\nCURL:\n\t curl"];
    [self appendFormat:@" -X %@", request.HTTPMethod];
    
    if (headerString.length > 0) {
        [self appendString:headerString];
    }
    if (request.HTTPBody.length > 0) {
        [self appendFormat:@" -d '%@'", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] RC_defaultValue:@"\t\t\t\tN/A"]];
    }
    
    [self appendFormat:@" %@", request.URL];
}

@end
