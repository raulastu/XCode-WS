//
//  CardGameViewController.m
//  iMatchismo
//
//  Created by Raul Ramirez on 2/14/13.
//  Copyright (c) 2013 Raul Ramirez. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController

-(CardMatchingGame *) game{
    if(!_game)_game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[PlayingCardDeck alloc]];
    return _game;
}

-(void) setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void) updateUI{
    
}

- (void) setFlipCount:(int) flipCount{
    _flipCount=flipCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

@end
