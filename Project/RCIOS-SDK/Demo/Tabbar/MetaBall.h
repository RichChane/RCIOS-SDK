//
//

#import <UIKit/UIKit.h>
#import "Circle.h"

#define RADIUS 40.0
//#define IS_FILL true
//#define IS_STROKE true


@interface MetaBall : UIView

@property(nonatomic,strong) Circle *centerCircle;
@property(nonatomic,strong) Circle *touchCircle;

@property(nonatomic) bool isFill;

//改变半径
-(void)changeCenterCircleRadiusTo:(float)radius;
-(void)changeTouchCircleRadiusTo:(float)radius;


@end
