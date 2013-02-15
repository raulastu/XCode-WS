//
//  CardMatchingGame.m
//  iMatchismo
//
//  Created by Raul Ramirez on 2/15/13.
//  Copyright (c) 2013 Raul Ramirez. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame()
    @property (readwrite, nonatomic) int score;
    @property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray*) cards{
    if(!_cards)_cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    if(self) {
        for (int i = 0;i<count; i++) {
            Card *card = [deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            }else{
                self.cards =  nil;
                self = nil;
            }
        }
    }
    return self;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1


- (void) flipCardAtIndex:(NSUInteger)index{
    NSLog(@"X");
    Card * card = [self cardAtIndex:index];
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        card.unplayable = YES;
                        otherCard.unplayable=YES;
                        self.score+=matchScore * MATCH_BONUS;
                    }else{
                        otherCard.faceUp=NO;
                        self.score -=MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score-= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}

-(Card *) cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count])?self.cards[index]:nil;
}


@end
