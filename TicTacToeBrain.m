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
        //[self printArrays];
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
    if (([self.boardArray[0][0] isEqual: @1] && [self.boardArray[1][0] isEqual: @1] && [self.boardArray[2][0] isEqual: @1]) ||
        ([self.boardArray[0][1] isEqual: @1] && [self.boardArray[1][1] isEqual: @1] && [self.boardArray[2][1] isEqual: @1]) ||
        ([self.boardArray[0][2] isEqual: @1] && [self.boardArray[1][2] isEqual: @1] && [self.boardArray[2][2] isEqual: @1]) ||
        
        ([self.boardArray[0][0] isEqual: @1] && [self.boardArray[0][1] isEqual: @1] && [self.boardArray[0][2] isEqual: @1]) ||
        ([self.boardArray[1][0] isEqual: @1] && [self.boardArray[1][1] isEqual: @1] && [self.boardArray[1][2] isEqual: @1]) ||
        ([self.boardArray[2][0] isEqual: @1] && [self.boardArray[2][1] isEqual: @1] && [self.boardArray[2][2] isEqual: @1]) ||
        
        ([self.boardArray[0][0] isEqual: @1] && [self.boardArray[1][1] isEqual: @1] && [self.boardArray[2][2] isEqual: @1]) ||
        ([self.boardArray[2][0] isEqual: @1] && [self.boardArray[1][1] isEqual: @1] && [self.boardArray[0][2] isEqual: @1]) )
        return 1;
    
    if (([self.boardArray[0][0] isEqual: @2] && [self.boardArray[1][0] isEqual: @2] && [self.boardArray[2][0] isEqual: @2]) ||
        ([self.boardArray[0][1] isEqual: @2] && [self.boardArray[1][1] isEqual: @2] && [self.boardArray[2][1] isEqual: @2]) ||
        ([self.boardArray[0][2] isEqual: @2] && [self.boardArray[1][2] isEqual: @2] && [self.boardArray[2][2] isEqual: @2]) ||
        
        ([self.boardArray[0][0] isEqual: @2] && [self.boardArray[0][1] isEqual: @2] && [self.boardArray[0][2] isEqual: @2]) ||
        ([self.boardArray[1][0] isEqual: @2] && [self.boardArray[1][1] isEqual: @2] && [self.boardArray[1][2] isEqual: @2]) ||
        ([self.boardArray[2][0] isEqual: @2] && [self.boardArray[2][1] isEqual: @2] && [self.boardArray[2][2] isEqual: @2]) ||
        
        ([self.boardArray[0][0] isEqual: @2] && [self.boardArray[1][1] isEqual: @2] && [self.boardArray[2][2] isEqual: @2]) ||
        ([self.boardArray[2][0] isEqual: @2] && [self.boardArray[1][1] isEqual: @2] && [self.boardArray[0][2] isEqual: @2]) )
        return 2;

    
    
     /*int countToThree;
     
    //Vertical
    for (int i = 0; i < 3; i++) {
        countToThree = 0;
        for (int j = 0; j < 3; j++) {
            if ([self.boardArray[i][j] isEqual: @1])
                countToThree += 1;
            else if ([self.boardArray[i][j] isEqual: @2])
                countToThree -= 1;
        }
        
        if (countToThree == 3 || countToThree == -3)
            return [self checkWin:countToThree];
    }
    
    //Horizontal
    for (int i = 0; i < 3; i++) {
        countToThree = 0;
        for (int j = 0; j < 3; j++) {
            if ([self.boardArray[j][i] isEqual: @1])
                countToThree += 1;
            else if ([self.boardArray[j][i] isEqual: @2])
                countToThree -= 1;
        }
        
        if (countToThree == 3 || countToThree == -3)
            return [self checkWin:countToThree];
    }
    
    //DiagonalR
    countToThree = 0;
    for (int i = 0; i < 3; i++) {
        if ([self.boardArray[i][i] isEqual: @1])
            countToThree += 1;
        else if ([self.boardArray[i][i] isEqual: @2])
            countToThree -= 1;
            
        if (countToThree == 3 || countToThree == -3)
            return [self checkWin:countToThree];
    }
        
    //DiagonalL
    for (int i = 0; i < 3; i++) {
        countToThree = 0;
        for (int j = 2; j > -1; j--) {
            if ([self.boardArray[i][j] isEqual: @1])
                countToThree += 1;
            else if ([self.boardArray[i][j] isEqual: @2])
                countToThree -= 1;
        }
            
        if (countToThree == 3 || countToThree == -3)
            return [self checkWin:countToThree];
    }*/
    
    return 0;
}

-(int) checkWin: (int) value;
{
    if (value == 3) {
        NSLog(@"PLAYER 1 WIN");
        return 1;
    }
    
    if (value == -3) {
        NSLog(@"PLAYER 2 WIN");
        return 2;
    }
    
    return 0;
}


@end
