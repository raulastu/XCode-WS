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
@property (readwrite, nonatomic) NSString *lastFlipDescription;
@property (nonatomic) int nCardsMatch;
@end

@implementation CardMatchingGame

-(NSString *) lastFlipDescription{
    if(!_lastFlipDescription)
        _lastFlipDescription=@"";
    return _lastFlipDescription;
}

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
    Card *anotherCard = nil;
    int matchScore = 0;
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            int nFacedUpCards = 0;
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    nFacedUpCards++;
                    anotherCard=otherCard;
                    int matchScoreForThisCard = [card match:@[otherCard]];
                    matchScore += matchScoreForThisCard;
                    if(matchScoreForThisCard){
                        card.unplayable = YES; 
                        otherCard.unplayable=YES;
                        self.score+=nFacedUpCards*matchScore * MATCH_BONUS;
                    }else{
                        otherCard.faceUp=NO;
                        self.score -=MISMATCH_PENALTY;
                    }
                    if(nFacedUpCards==2)
                        break;
//                    break;
                }
            }
            self.score-= FLIP_COST;
        }
        NSString *lastFlipDescription = @"x";
        if(anotherCard!=nil){
            if(matchScore){
                lastFlipDescription = [NSString stringWithFormat:@"Matched %@ & %@",[card contents],[anotherCard contents]];
            }else{
                lastFlipDescription = [NSString stringWithFormat:@"%@ and %@ don't match",[card contents],[anotherCard contents]];
            }
        }else{
            lastFlipDescription = [NSString stringWithFormat:@"Flipped up %@",[card contents]];
            
        }
        self.lastFlipDescription=[NSString stringWithFormat: @"%@", lastFlipDescription];
        
        card.faceUp = !card.faceUp;
    }
}

-(Card *) cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count])?self.cards[index]:nil;
}


@end
