//
//  CLScrollPickerView.h
//  CLScrollPicker
//
//  Created by Chao Li on 10/28/14.
//  Copyright (c) 2014 Columbia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class CLScrollPickerView;

@protocol CLScrollPickerDelegate <NSObject>

@optional
-(void)pickerview:(CLScrollPickerView *)pickerView selectedRow:(NSInteger)selectedRow;

@end

@interface CLScrollPickerView : UIView<UIScrollViewDelegate>{
    NSMutableArray *labelArr;
    UIScrollView *baseScrollView;
}

@property(nonatomic, strong)NSArray *stringArr;
@property(nonatomic)CGSize rowSize;
@property(nonatomic)NSInteger selectedRow;
@property(nonatomic)float widthOffset;

@property(nonatomic, weak)id<CLScrollPickerDelegate> delegate;

@end
