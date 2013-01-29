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
@property (nonatomic, strong) NSString *stackString;

@end

@implementation CalculatorViewController

@synthesize brain=_brain;
-(CalculatorBrain *)brain
{
    if(!_brain)_brain = [[CalculatorBrain alloc] init];
    return _brain;
}


@synthesize display = _display;
@synthesize stackView = _stackView;
@synthesize stackString = _stackString;

-(NSString *)stackString{
    if(!_stackString)
        _stackString=@"";
    return _stackString;
}

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



- (IBAction)enterPressed {
    [self addToStackView:[self validateOperand:self.display.text]];

    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
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
        [self enterPressed];
    }
    //print in stackView
    [self addToStackView:sender.titleLabel.text];
    self.stackView.text= [NSString stringWithFormat:@"%@ %@",self.stackString,@"=" ];
    
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g",result];
    self.display.text = resultString;
}

- (IBAction)clean:(UIButton *)sender{
    self.display.text = @"0";
    self.stackString = @"";
    [self.brain clear];
    [self updateStackView];
}

- (void) addToStackView:(NSString *)valuePressed{
    if([self.stackString length]>0){
        valuePressed = [NSString stringWithFormat:@" %@",valuePressed];
    }
    NSString *newString= [self.stackString stringByAppendingString:valuePressed];
    self.stackString = newString;
    [self updateStackView];
}

-(void) updateStackView{
    self.stackView.text = [self stackString];
}

- (IBAction)backspace:(id)sender {
    if([self.display.text length]>0){
        self.display.text = [self.display.text substringToIndex:self.display.text.length-1];
        
    }
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
    [self updateStackView];
}

- (void)viewDidUnload {
    [self setStackView:nil];
    [super viewDidUnload];
}
@end
