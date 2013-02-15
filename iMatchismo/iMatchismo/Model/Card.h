//
//  Card.h
//  iMatchismo
//
//  Created by Raul Ramirez on 2/14/13.
//  Copyright (c) 2013 Raul Ramirez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;

@property (nonatomic, getter=isUnplayable) BOOL unplayable;

-(int)match:(NSArray *) otherCards;

@end
