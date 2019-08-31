

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Circle.h"


#define kMax_Distance 75

@interface MetaBallItem : NSObject

@property(nonatomic, weak, readonly) UIView *view;

@property(nonatomic,strong) Circle *centerCircle;

@property(nonatomic,strong) Circle *touchCircle;

@property(nonatomic) float maxDistance; // 最大距离

@property(nonatomic) UIColor *color;    // 颜色

- (instancetype)initWithView:(UIView *)view;

@end
