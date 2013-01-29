//
//  ViewController.m
//  Substraction
//
//  Created by Raul Ramirez on 8/4/12.
//  Copyright (c) 2012 FIS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize display;
@synthesize textField1;
@synthesize textField2;

- (IBAction)pressButton:(UIButton *)sender {
    int a =[[textField1 text] intValue];
    int b = [[textField2 text] intValue];
    int res = [self sum: a:b];
    //display.text = [NSString stringWithFormat:@"%d",res];
    [display setText:[NSString stringWithFormat:@"%d",res]];
}

- (int) sum:(int)first :(int) second{
    return first+second;
}
     

@end
