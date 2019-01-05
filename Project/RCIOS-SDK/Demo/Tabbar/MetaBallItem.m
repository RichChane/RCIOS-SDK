
#import "MetaBallItem.h"
#import "PointUtils.h"


@implementation MetaBallItem

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if(self) {
        self.color = kUIColorFromRGB(0xFCB23C);
        _view = [self duplicate:view];
        
        float w = view.frame.size.width;
        float h = view.frame.size.height;
        
        CGPoint point = [PointUtils getGlobalCenterPositionOf:view];
        
        self.centerCircle = [Circle initWithcenterPoint:point radius:MIN(w, h)/2 color:_color];
        self.touchCircle = [Circle initWithcenterPoint:point radius:MIN(w, h)/2 color:_color];
        
        self.maxDistance = kMax_Distance;
        
        if (MIN(w, h) > kMax_Distance) {
            self.maxDistance = kMax_Distance * 2;
        }
    }
    return self;
}

// Duplicate UIView
- (UIView *)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    
    UIView *tempView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    [tempView.layer setCornerRadius:view.layer.cornerRadius];
    [tempView setClipsToBounds:YES];
    
    return tempView;
}

@end
