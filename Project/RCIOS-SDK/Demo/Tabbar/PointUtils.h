

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PointUtils : NSObject

+ (CGPoint)getGlobalCenterPositionOf:(UIView *)view;

+ (CGPoint)getGlobalPositionOf:(UIView *)view;

@end
