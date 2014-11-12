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
    NSLog(@"In function init");
    self.player1Turn=YES;
    if (self.boardArray == nil){
        self.boardArray = [[NSMutableArray alloc] initWithCapacity:3];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:0];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    }
}
-(void) printArrays
{
    NSLog(@"Quad 0");
    for(int i = 0; i < 3; i++)
        NSLog(@"%@ %@ %@", self.boardArray[i][0], self.boardArray[i][1], self.boardArray[i][2]);

}
//add the quadrant then fill in the array
-(BOOL) isValidTap:(NSValue *) point byPlayer:(int)player
{
    int col = (int) [point CGPointValue].x;
    int row = (int) [point CGPointValue].y;
    if ([self.boardArray[row][col] isEqual: @"0"]){
        [self printArrays];
        [self flipPlayer];
        if (player==1){
            self.boardArray[row][col] = @1;
        }
        if (player==2)
            self.boardArray[row][col] = @2;
        return true;
        }
    else{
        return FALSE;
    }

//    return true;
}

-(void) flipPlayer
{
    NSLog(@"Called flip player");
    self.player1Turn = !self.player1Turn;
}
-(int) isThereAWinner {
    int i=0; int j=0;
    int countToThree=0;
    //Horizantal
    for(i=0; i<3;i++){
        for(j=0; j<3; j++){
            if ([self.boardArray[i][j] isEqual: @1]){
                countToThree += 1;
            }
        }
    }
    return 0;
}


@end
