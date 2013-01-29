    //
//  CalculatorViewController.m
//  Calculator
//
//  Created by Raul Ramirez on 4/1/12.
//  Copyright (c) 2012 FIS. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize brain=_brain;
-(CalculatorBrain *)brain
{
    if(!_brain)_brain = [[CalculatorBrain alloc] init];
    return _brain;
}


@synthesize display = _display;
@synthesize stackView=_stackView;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize button = _button;
@synthesize variableDisplay = _variableDisplay;


@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;

- (IBAction)digitPress:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if([digit isEqualToString:@"."] && [[self.display text] rangeOfString:@"."].location != NSNotFound){
            return;
        }
        self.display.text = [self.display.text stringByAppendingString:digit];
    }else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}



- (IBAction)enterPressed:(UIButton *)sender {
    
    
    NSString * valueToPush = self.display.text;

    NSNumber *constantValue = [CalculatorBrain getConstantRegistered:sender.currentTitle];
    if(constantValue!=nil){
        valueToPush = sender.currentTitle;
    };
    
    [self.brain pushOperand:valueToPush];
    
    
    [self updateStackViewWithResult:@"0"];

    
    self.userIsInTheMiddleOfEnteringANumber = NO;
//    [self updateStackView];
}

- (NSString *) validateOperand:(NSString*) operand {
    if([operand hasPrefix:@"."]){
        operand = [NSString stringWithFormat:@"%@%@",@"0",operand];
    }
    if([operand hasSuffix:@"."]){
        operand = [NSString stringWithFormat:@"%@%@",operand,@"0"];
    }
    return operand;
}


- (IBAction)operationPressed:(UIButton *)sender
{
    
    if(self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed:sender];
    }
    [self.brain pushOperand:sender.currentTitle];
    
    double result = [CalculatorBrain runProgram:self.brain.program];
    NSString *resultString = [NSString stringWithFormat:@"%g",result];
    
    [self updateStackViewWithResult:resultString];
    
}

- (void) updateStackViewWithResult:(NSString *)result withVariableValues:(NSMutableDictionary *)dictionary{
        
    
    NSSet* set = [CalculatorBrain variablesUsedInProgram:[self.brain program]];
    
    NSString * varAndVals = @"";
    for (NSString * var in set) {
        NSNumber * val = [dictionary objectForKey:var];
        varAndVals = [NSString stringWithFormat:@"%@ %@=%@",varAndVals,var,val];
        
    }
    self.variableDisplay.text = varAndVals;

    
    self.display.text = result;
    
    //update stack views
    NSString * val = [NSString stringWithFormat:@"%@",[self.brain program]];
    self.stackView.text =val;
    self.descriptionLabel.text = [CalculatorBrain descriptionOfProgram:[self.brain program] usingVariableValues:dictionary];
}

- (void) updateStackViewWithResult:(NSString *)result{
    //update result
    //backwards compatibility performOperation

    self.display.text = result;
    
    //update stack views
    NSString * val = [NSString stringWithFormat:@"%@",[self.brain program]];
    self.stackView.text =val;
    self.descriptionLabel.text = [CalculatorBrain descriptionOfProgram:[self.brain program]];

    
}

- (IBAction)backspace:(id)sender {
    if([self.display.text length]>0){
        self.display.text = [self.display.text substringToIndex:self.display.text.length-1];
        
    }
}

- (IBAction)clear:(UIButton *)sender{
    self.display.text = @"";
    self.stackView.text = @"";
    [self.brain clear];
    self.descriptionLabel.text=@"";
}

- (IBAction)changeSign:(id)sender {
    if([self.display.text doubleValue] == 0){
        return;
    }
    if([self.display.text hasPrefix:@"-"]){
        self.display.text = [self.display.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }else{
        self.display.text = [NSString stringWithFormat:@"-%@", self.display.text];
    }
    [self updateStackViewWithResult:self.display.text];
}


//test cases

- (IBAction)test1:(id)sender {
    NSMutableDictionary * test1Dictionary = [[NSMutableDictionary alloc] init];
    [test1Dictionary setObject:[NSNumber numberWithInt:5] forKey:@"x"]; 
    [test1Dictionary setObject:[NSNumber numberWithDouble:2] forKey:@"a"];
    [test1Dictionary setObject:[NSNumber numberWithDouble:0] forKey:@"b"];
    
    
    double result = [CalculatorBrain runProgram:self.brain.program usingVariableValues:test1Dictionary];
    
    NSString *resultString = [NSString stringWithFormat:@"%g",result];
    
    [self updateStackViewWithResult:resultString withVariableValues:test1Dictionary];
}

- (IBAction)test2:(id)sender {
}

//

- (void)viewDidUnload {
    [self setStackView:nil];
    [self setDescriptionLabel:nil];
    [self setButton:nil];
    [self setVariableDisplay:nil];
    [super viewDidUnload];
}
@end
