//
//  TicTacToeBrain.m
//  Tic Tac Toe
//
//  Created by student on 11/10/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "TicTacToeBrain.h"

@implementation TicTacToeBrain
-(void) initialize
{
    self.player1Turn=YES;
    if (self.boardArray == nil){
        self.boardArray = [[NSMutableArray alloc] initWithCapacity:3];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:0];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    }
}
@end
