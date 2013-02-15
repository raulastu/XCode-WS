//
//  PlayingCard.h
//  iMatchismo
//
//  Created by Raul Ramirez on 2/14/13.
//  Copyright (c) 2013 Raul Ramirez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString * suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger) maxRank;
@end
