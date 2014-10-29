//
//  ViewController.m
//  CLScrollPicker
//
//  Created by Chao Li on 10/28/14.
//  Copyright (c) 2014 Columbia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *stringArr = @[@"String One",@"String Two",@"String Three",@"String Four",@"String Five",@"String Six",@"String Seven",@"String Eight",@"String Nine",@"String Ten",@"String Eleven",@"String Twelve",@"String Thirteen",@"String Fourteen",@"String Fifteen"];
    
    //create scroll picker view
    CLScrollPickerView *pickerView = [[CLScrollPickerView alloc]initWithFrame:CGRectMake(0, 200, 320, 200)];
    [pickerView setStringArr:stringArr];
    [pickerView setSelectedRow:1];
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma CLScrollPickerView Delegate
-(void)pickerview:(CLScrollPickerView *)pickerView selectedRow:(NSInteger)selectedRow{
    NSLog(@"ROW%li is selected",(long)selectedRow);
}

@end
