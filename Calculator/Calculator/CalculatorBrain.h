//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Raul Ramirez on 4/1/12.
//  Copyright (c) 2012 FIS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(NSString *)operand;
- (double) performOperation;

//assigment 1
- (void)clear;

//Lecture 4 additions
@property (readonly) id program;

+ (double) runProgram:(id) program;

+ (NSString *) descriptionOfProgram:(id)program;


+ (NSSet *)variablesUsedInProgram:(id)program;


//extra
+ (NSNumber *)getConstantRegistered:(NSString *)variable;


//assigment 2
+ (double) runProgram:(id)program usingVariableValues:(NSMutableDictionary *)dictionary;

+ (NSString *) descriptionOfProgram:(id)program usingVariableValues:(NSMutableDictionary *)dictionary;


@end
