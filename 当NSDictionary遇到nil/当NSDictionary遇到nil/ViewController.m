//
//  ViewController.m
//  当NSDictionary遇到nil
//
//  Created by 宋宏康 on 2018/8/16.
//  Copyright © 2018年 中施科技. All rights reserved.
//

#import "ViewController.h"
#import "HKTestObject.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    HKTestObject *objec = [[HKTestObject alloc] init];
    
    
}


- (IBAction)btnClick:(UIButton *)sender
{
    id nilVal = nil;
    NSDictionary *dict = @{@"age":@"18",@"name":@"dsfdf",@"job":nilVal};
    NSLog(@"dict:%@",dict);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
