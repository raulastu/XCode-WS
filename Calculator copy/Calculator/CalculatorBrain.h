//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Raul Ramirez on 4/1/12.
//  Copyright (c) 2012 FIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double) performOperation:(NSString *)operation;
- (void)clear;

//Lecture 4 additions
@property (readonly) id program;

+ (double) runProgram:(id) program;
+ (NSString *) descriptionOfProgram:(id)program;

@end
