//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Raul Ramirez on 4/1/12.
//  Copyright (c) 2012 FIS. All rights reserved.
//

#import "CalculatorBrain.h"




@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *operandStack;

@end


@implementation CalculatorBrain


@synthesize operandStack=_operandStack;

- (NSMutableArray *) operandStack
{
    if (_operandStack==nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}


-(double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject){
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double) performOperation:(NSString *)operation
{
//    NSString *st = @"operation ";
    NSLog(@"%@",operation);
    
    double result= 0;
    
    if([operation isEqualToString:@"+"]){
        result = [self popOperand] + [self popOperand];
    }else if([@"*" isEqualToString:operation]){
        result = [self popOperand] * [self popOperand];
    }else if([@"/" isEqualToString:operation]){
        double numerator= [self popOperand];
        double denominator = [self popOperand];
        if(denominator!=0){
            result = numerator / denominator;
        }else{
            NSLog(@"division by zero");
        }
    }else if([@"-" isEqualToString:operation]){
        result = [self popOperand] - [self popOperand];
    }else if([@"sin" isEqualToString:operation]){
        result = sin([self popOperand]);
    }else if([@"cos" isEqualToString:operation]){
        result = cos([self popOperand]);
    }else if([@"sqrt" isEqualToString:operation]){
        result = sqrt([self popOperand]);
    }else if([@"π" isEqualToString:operation]){
        result = M_PI;
    }
    [self pushOperand:result];
    return result;
}

-(void) clear{
    while ([self operandStack].count>0) {
        [self popOperand];
    }
}

@end
