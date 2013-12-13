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
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipDescLabel;
@property (nonatomic) int score;
@property (nonatomic) NSString *lastFlipDesc;

@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController

-(CardMatchingGame *) game{
    if(!_game)_game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}

-(void) setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void) updateUI{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable)?.3:1;
    }
    self.score=[self.game score];
//    NSLog([NSString stringWithFormat:@" %@", [self.game lastFlipDescription]]);
//    NSL
    self.lastFlipDesc=[self.game lastFlipDescription];
}
-(void) setLastFlipDesc:(NSString *)lastFlipDesc {
    _lastFlipDesc=lastFlipDesc;
    self.lastFlipDescLabel.text=[NSString stringWithFormat:@"%@",self.lastFlipDesc];
}

-(NSString *) getLastFlipDesc{
    if(!_lastFlipDesc)
        _lastFlipDesc=@"";
    return _lastFlipDesc;
}
- (void) setScore:(int) score{
    _score=score;
    self.scoreLabel.text=[NSString stringWithFormat:@"Score: %d", self.score];
}

- (void) setFlipCount:(int) flipCount{
    _flipCount=flipCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
//    NSLog(@"Y");
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)deal:(id)sender {
    _game = nil;
//    [self init];
    [self updateUI];
}

@end
