//
//  TicTacToeBrain.h
//  Tic Tac Toe
//
//  Created by student on 11/10/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface TicTacToeBrain : NSObject
@property (nonatomic) BOOL player1Turn;
@property(nonatomic) NSString *arrayString;
@property(nonatomic) NSMutableArray* boardArray;
@property(nonatomic) int p;
- (void) initialize;
-(void) initializeWithVC: (ViewController *) v;
-(BOOL) isValidTap:(NSValue *) point byPlayer:(int)player;
-(void) sendData;
-(void) printArrays;
-(void) setOpponentArrayString: (NSString *) string;
-(void) setNewBoard;
//-(int) isThereAWinner;

@end
