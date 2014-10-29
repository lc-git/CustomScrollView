//
//  CLScrollPickerView.m
//  CLScrollPicker
//
//  Created by Chao Li on 10/28/14.
//  Copyright (c) 2014 Columbia. All rights reserved.
//

#import "CLScrollPickerView.h"

@implementation CLScrollPickerView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedRow = 0;
        _widthOffset = 20.0;
        
        _stringArr = [[NSArray alloc] init];
        labelArr = [[NSMutableArray alloc] init];
        baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}


-(void)initScrollView{
    [self initWithSelectedRow:5];
}

-(void)initWithSelectedRow:(NSInteger)row{
    if (_rowSize.width == 0 && _rowSize.height == 0) {
        _rowSize = CGSizeMake(baseScrollView.frame.size.width - 2 * _widthOffset, baseScrollView.frame.size.height/5);
    }
    
    [self addSubview:baseScrollView];
    baseScrollView.showsHorizontalScrollIndicator = NO;
    baseScrollView.showsVerticalScrollIndicator = NO;
    _selectedRow = row;
    
    if (_stringArr.count > 0) {
        for (int i=0; i < _stringArr.count; i++) {
            UILabel *tmpLabel = [[UILabel alloc]initWithFrame:CGRectMake(_widthOffset, i * _rowSize.height, _rowSize.width, _rowSize.height)];
            tmpLabel.text = _stringArr[i];
            [tmpLabel setBackgroundColor:[UIColor lightGrayColor]];
            tmpLabel.layer.borderColor = [[UIColor blackColor] CGColor];
            tmpLabel.layer.borderWidth = 1.0;
            [labelArr addObject:tmpLabel];
            [baseScrollView addSubview:tmpLabel];
        }
        baseScrollView.delegate = self;
        baseScrollView.contentInset = UIEdgeInsetsMake(baseScrollView.frame.size.height/2 - _rowSize.height/2, 0, baseScrollView.frame.size.height/2 - _rowSize.height/2, 0);
        baseScrollView.contentSize = CGSizeMake(baseScrollView.frame.size.width, _stringArr.count * _rowSize.height);
        float midViewY = -baseScrollView.frame.size.height/2 + _rowSize.height/2 + row * _rowSize.height;
        baseScrollView.contentOffset = CGPointMake(0, midViewY);
        [self reloadView:row];
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_async(queue, ^ {
//            [self reloadView:row];
//            dispatch_async(dispatch_get_main_queue(), ^ {
//                //[self snapToAnEmotion];
//            });
//        });
    }
    
    
}


-(void)setStringArr:(NSArray *)stringArr{
    _stringArr = stringArr;
    [self initScrollView];
}


-(void)setRowSize:(CGSize)rowSize{
    _rowSize = rowSize;
    [self initScrollView];
}

-(void)setWidthOffset:(float)widthOffset{
    _widthOffset = widthOffset;
    [self initScrollView];
}


#pragma ScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int num = floor((scrollView.contentOffset.y + scrollView.contentInset.top + _rowSize.height/2)/_rowSize.height);
    [self reloadView:num];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate == NO) {
        int num = floor((scrollView.contentOffset.y + scrollView.contentInset.top + _rowSize.height/2)/_rowSize.height) ;
        float midViewY = -baseScrollView.frame.size.height/2 + _rowSize.height/2 + num * _rowSize.height;
        [scrollView setContentOffset:CGPointMake(0, midViewY) animated:YES];
        _selectedRow = num;
            [self.delegate pickerview:self selectedRow:_selectedRow];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int num = floor((scrollView.contentOffset.y + scrollView.contentInset.top + _rowSize.height/2)/_rowSize.height) ;
    float midViewY = -baseScrollView.frame.size.height/2 + _rowSize.height/2 + num * _rowSize.height;
    [scrollView setContentOffset:CGPointMake(0, midViewY) animated:YES];
    _selectedRow = num;
    [self.delegate pickerview:self selectedRow:_selectedRow];
}

-(void)reloadView:(NSInteger)index{
    id biggestView;
    for (int i=0; i < labelArr.count; i++) {
        UILabel *view = [labelArr objectAtIndex:i];
        if (i == index){
            view.frame = CGRectMake(0, view.frame.origin.y, _rowSize.width + 2*_widthOffset, _rowSize.height);
            biggestView = view;
        } else {
            view.frame = CGRectMake(_widthOffset, view.frame.origin.y, _rowSize.width, _rowSize.height);
        }
    }
    
    for (int i = 0; i < labelArr.count; i++)
    {
        UIView *cBlock = [labelArr objectAtIndex:i];
        cBlock.alpha = 0.3;
        
        if (i > 0)
        {
            UIView *pBlock = [labelArr objectAtIndex:i-1];
            cBlock.frame = CGRectMake(cBlock.frame.origin.x, pBlock.frame.origin.y + pBlock.frame.size.height, cBlock.frame.size.width, cBlock.frame.size.height);
        }
    }
    
    [(UIView *)biggestView setAlpha:1.0];
}



@end











