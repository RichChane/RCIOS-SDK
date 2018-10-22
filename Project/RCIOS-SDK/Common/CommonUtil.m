//
//  CommonUtil.m
//  RCIOS-SDK
//
//  Created by gzkp on 2018/10/22.
//  Copyright © 2018年 RC. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+ (void )testQuickArray
{
    int a[] = {6,2,7,3,9,8};
    int length = sizeof(a)/sizeof(int);
    sort(a, 0, length-1);
    
}

//array = @[@(6),@(2),@(7),@(3),@(9),@(8)].mutableCopy;
+ (void)quickSort:(NSMutableArray *)array left:(NSNumber *)left right:(NSNumber *)right
{
    
    
    if (left.intValue > 0 && right.intValue < array.count - 1 && left.intValue >= right.intValue ) { /*如果左边索引大于或者等于右边的索引就代表已经整理完成了*/
        return;
    }
    NSNumber *i = left;
    NSNumber *j = right;
    NSNumber *key = array[i.intValue]; // 取出中间数
    
    while (i.intValue < j.intValue) {
        /* 从后往前找 */
        while (i.intValue < j.intValue && key.intValue <= ((NSNumber *)array[j.intValue]).intValue) {
            j = @(j.intValue-1); /*向前寻找*/
        }
        array[i.intValue] = array[j.intValue];
        
        /* 从前往后找 */
        while (i.intValue < j.intValue && key.intValue >= ((NSNumber *)array[i.intValue]).intValue) {
            i = @(i.intValue+1); /*向后寻找*/
        }
        array[j.intValue] = array[i.intValue];
        
    }
    
    array[i.intValue] = key;   // 回归中间数
    
    [self quickSort:array left:left right:@(j.intValue-1)];  //  用同样的方法对分出来的左边的小组进行同上做法
    [self quickSort:array left:@(i.intValue + 1) right:right];// 用同样的方法对分出来的右边的小组进行同上的做法
    
    /* 知道 i=j 为止 */
}

void sort (int *a,int left,int right)
{
    if (left >= right) {
        return;
    }
    int i = left;
    int j = right;
    int key = a[left];
    
    while (i < j) {
        while (i < j && key <= a[j]) {
            j --;
        }
        a[i] = a[j];
        
        while (i < j && key >= a[i]) {
            i ++;
        }
        a[j] = a[i];
        
    }
    a[i] = key;
    
    sort(a, left, i - 1);
    sort(a, i+1, right);
    
    
}

@end
