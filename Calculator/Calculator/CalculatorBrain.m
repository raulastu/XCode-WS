//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Raul Ramirez on 4/1/12.
//  Copyright (c) 2012 FIS. All rights reserved.
//

#import "CalculatorBrain.h"




@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *programStack;
+(NSMutableDictionary *) operandDictionary;

@end


@implementation CalculatorBrain

@synthesize programStack=_programStack;

- (NSMutableArray *) programStack
{
    if (_programStack==nil) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

+(NSMutableDictionary *) operandDictionary{

    static NSMutableDictionary *dic=nil;
    
    if(dic==nil){
        dic = [[NSMutableDictionary alloc]init];
        [self resetDictionary:dic];
        return dic;
    }
    return dic;
}

+(void)resetDictionary:(NSMutableDictionary*)dictionary{
    [dictionary removeAllObjects];
    NSNumber * pi = [NSNumber numberWithDouble:M_PI];
    [dictionary setObject:pi forKey:@"π"];
}

+ (NSNumber *) getConstantRegistered:(NSString *) variable{
    NSNumber *ob = [[CalculatorBrain operandDictionary]objectForKey:variable];
    return ob;
}

- (void)pushOperand:(NSString *)operand
{
    [self.programStack addObject:operand];
}

-(double)popOperand
{
    NSNumber *operandObject = [self.programStack lastObject];
    if(operandObject){
        [self.programStack removeLastObject];
    }
    return [operandObject doubleValue];
}

- (double) performOperation
{
}

- (id)program{
    return [self.programStack copy];
}



+ (NSString *) descriptionOfProgram:(id)program usingVariableValues:(NSMutableDictionary *)dictionary{
    
    [[CalculatorBrain operandDictionary] setDictionary:dictionary];
    NSString * res = [CalculatorBrain descriptionOfProgram:program];
    
    [CalculatorBrain resetDictionary: [CalculatorBrain operandDictionary] ];
    return res;
}
    
+ (NSString *) descriptionOfProgram:(id)program{
    
    NSArray *stack;
    if([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    NSString *result = @"";
    while(stack.count!=0){
        if([result isEqualToString:@""]){
            result = [self getSubProgram:stack];
        }else{
            result = [NSString stringWithFormat:@"%@,%@",result, [self getSubProgram:stack]];
        }
    }
    
    NSLog(@"result2 %@ ",result);    
    return [result isEqualToString:@""]?@"0":result;

//    return [NSString stringWithFormat:@"%@",program];
}

+ (NSString *)getSubProgram:(id)stack {
    NSString *result = @"";
    NSLog(@"stack %@ ",stack);

    id topOfStack = [stack lastObject];
    if(topOfStack){
        [stack removeLastObject];
    }
    
    NSNumber *operand = [self isOperand:topOfStack];

    if(operand!=nil){
        result = [NSString stringWithFormat:@"%@",topOfStack];
    }else if ([topOfStack isKindOfClass:[NSString class]]){
        if([topOfStack isEqualToString:@"sqrt"]){
            result = [NSString stringWithFormat:@"%@ (%@)",@"sqrt",[self getSubProgram:stack]];
        }else{
            NSString * operator = topOfStack;
            NSString *firstFactor = [self getSubProgram :stack];
            NSString *secondFactor = [self getSubProgram :stack];
            NSLog(@"firstFactor %@ ",firstFactor);
            NSLog(@"secondFactor %@ ",secondFactor);
            if([operator isEqualToString:@"/"] || [operator isEqualToString:@"*"]){
                NSString *parenthesizedFirstFactor = [self putParenthesesIfNecessary:firstFactor];
                firstFactor=parenthesizedFirstFactor;
                NSString *parenthesizedSecondFactor = [self putParenthesesIfNecessary:secondFactor];
                secondFactor=parenthesizedSecondFactor;
                result = [NSString stringWithFormat:@"%@ %@ %@",secondFactor, topOfStack, firstFactor];
            }else{
                result = [NSString stringWithFormat:@"%@ %@ %@",secondFactor, topOfStack, firstFactor];
            }
            if ([result isEqualToString:@"(3 + 3) * 3"]) {
                NSLog( @"here" );
            }
            NSLog(@"result %@ ",result);
        }
        
    }
    return result;
}

+ (NSString *)putParenthesesIfNecessary:(NSString *) expression{
    if([self higherOrderIsAddSub:expression]){
        return [NSString stringWithFormat:@"(%@)",expression];
    }
    return expression;
}

+(BOOL) higherOrderIsAddSub:(NSString *)expression{
    for(int i=0;i<[expression length];i++){
        char c = [expression characterAtIndex:i];
//        if(c==L'/' || c==L'*'){
//            return false;
//        }
        if(c==L'-' || c==L'+'){
            return true;
        }
        if(c=='('){
            int j = i+1;
            char d = [expression characterAtIndex:j];
            int counter = 1;
            while (counter!=0){
                d = [expression characterAtIndex:j];
                
                if(d=='(')
                    counter++;
                if(d==')')
                    counter--;
                if ([expression isEqualToString:@"(3 + 3) * 3"]) {
                    NSLog( @"here");
                }
                NSLog(@"%hhd, %d, %d",d,i,j);
                j++;
            }
            i=j;
        }
    }
    return false;
}

+ (NSNumber *) isOperand:(NSString *) operand{
    if([operand isKindOfClass:[NSString class]]){
        NSNumber * ob = [[[NSNumberFormatter alloc]init] numberFromString:operand];
        if(ob!=nil){
            //it's a number
            return ob;
        }
        id obj = [[CalculatorBrain operandDictionary] objectForKey:operand];
        if(obj!=nil){
            return obj;
        }
        return nil;
    }
    return nil;
}
//+ (NSString *) getThingInInfixedMode :(NSString *) prefix {
//    return @"";
//}

+ (double)popOperandOffStack:(id)stack{
    double result = 0;
    
    NSString * topOfStack = [stack lastObject];
    if(topOfStack){
        [stack removeLastObject];
    }
    
    NSNumber *ob = [CalculatorBrain isOperand:topOfStack];
    if(ob!=nil){
        result = [ob doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]){
        
        NSString *operation = topOfStack;
        
        if([operation isEqualToString:@"+"]){
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }else if([@"*" isEqualToString:operation]){
            
            double firstFactor = [self popOperandOffStack:stack];
            double secondFactor = [self popOperandOffStack:stack];
            result = firstFactor * secondFactor;
        }else if([@"/" isEqualToString:operation]){
            double denominator = [self popOperandOffStack:stack];
            double numerator= [self popOperandOffStack:stack];
            if(denominator!=0){
                result = numerator / denominator;
            }else{
                NSLog(@"division by zero");
            }
        }else if([@"-" isEqualToString:operation]){
            result = [self popOperandOffStack:stack] - [self popOperandOffStack:stack];
        }else if([@"sin" isEqualToString:operation]){
            result = sin([self popOperandOffStack:stack]);
        }else if([@"cos" isEqualToString:operation]){
            result = cos([self popOperandOffStack:stack]);
        }else if([@"sqrt" isEqualToString:operation]){
            result = sqrt([self popOperandOffStack:stack]);
        }
    }
    return result;
}

+(double) runProgram:(id)program{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

+(double) runProgram:(id)program usingVariableValues:(NSMutableDictionary*) dictionary{
    
    [[CalculatorBrain operandDictionary] setDictionary:dictionary];
    
    double result = [self runProgram:program];
    
    return result;
}

-(void) clear{
    [[self programStack] removeAllObjects];
}

+(NSSet *) variablesUsedInProgram:(id) program{
    NSArray *stack;
    if([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    NSMutableSet* setOfVariables  = [[NSMutableSet alloc] init];
    
    for(id x in stack){
        if([x isEqualToString:@"x"]
           || [x isEqualToString:@"a"]
           || [x isEqualToString:@"b"]){
            [setOfVariables addObject:x];
        }
    }
    return setOfVariables;
}

@end
