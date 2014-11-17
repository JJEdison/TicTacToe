//
//  TicTacToeBrain.h
//  Tic Tac Toe
//
//  Created by student on 11/10/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicTacToeBrain : NSObject
@property (nonatomic) BOOL player1Turn;

@property(nonatomic) NSMutableArray* boardArray;
- (void) initialize;
-(BOOL) isValidTap:(NSValue *) point byPlayer:(int)player;
-(void) sendData;
-(void) setOpponentArrayString: (NSString *) string;
-(void) setNewBoard;

@end
