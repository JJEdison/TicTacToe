//
//  TicTacToeBrain.m
//  Tic Tac Toe
//
//  Created by student on 11/10/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "TicTacToeBrain.h"
#import "TicTacToeDataSource.h"
#import "ViewController.h"

@interface TicTacToeBrain ();
@property(nonatomic) TicTacToeDataSource *dataSource;
@property(nonatomic) ViewController *vc;
@property(nonatomic) NSString *opponentArrayString;
@property(nonatomic) NSTimer *timer;

@end
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
    self.vc = [[ViewController alloc] init];
    self.dataSource = [[TicTacToeDataSource alloc] initializeWithBrain: self];

}

-(void) initializeWithVC: (ViewController *) v
{
    self.player1Turn=YES;
    if (self.boardArray == nil){
        self.boardArray = [[NSMutableArray alloc] initWithCapacity:3];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:0];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
        [self.boardArray insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    }
    self.vc = v;
    self.dataSource = [[TicTacToeDataSource alloc] initializeWithBrain: self];
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
    if (player==1){
        NSLog(@"Player1 turn");
    }
    if (player==2)
        NSLog(@"Player2 turn");
    
    int col = (int) [point CGPointValue].x;
    int row = (int) [point CGPointValue].y;
    [self printArrays];
    NSLog(@"%@", @[self.boardArray[row][col]]);
    if ([self.boardArray[row][col] isEqual: @"0"] || [self.boardArray[row][col] isEqual: @0] ) {
        NSLog(@"Yuppeee");

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
}

-(void) sendData
{
    //[self.dataSource getBrain: self];
    self.arrayString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@", self.boardArray[0][0], self.boardArray[0][1], self.boardArray[0][2],self.boardArray[1][0], self.boardArray[1][1], self.boardArray[1][2],self.boardArray[2][0], self.boardArray[2][1], self.boardArray[2][2]];
    NSLog(@"arrayString in sendData: %@,", self.arrayString);

    NSString * baseString = @"http://cs.sonoma.edu/~ppfeffer/TicTacToe/dbInterface.py?bArray=";
    NSString * ticTacToeString = ([NSString stringWithFormat:@"%@%@", baseString, self.arrayString]);

//    self.dataSource = [[TicTacToeDataSource alloc] initWithbArrayURLString:ticTacToeString];
    [self.dataSource arrayURLString:ticTacToeString];
    
}
-(void) flipPlayer
{
    NSLog(@"Called flip player");
    self.player1Turn = !self.player1Turn;
    
    if (!self.player1Turn)
        _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(checkOpponentActivity) userInfo:nil repeats: YES];
}

-(bool) checkOpponentActivity
{
    if (self.player1Turn)
        return false;
    
    NSLog(@"================================================");
    NSString *temp = @"http://cs.sonoma.edu/~ppfeffer/TicTacToe/dbInterface.py";
    //self.dataSource = [[TicTacToeDataSource alloc] initWithbArrayURLString:temp];
    [self.dataSource arrayURLString:temp];

    return true;
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

-(void) setOpponentArrayString: (NSString *) string
{
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    _opponentArrayString = string;
    
    NSLog(@"Opponent String: ->%@<-", self.opponentArrayString);
    NSLog(@"arrayString : ->%@<-", self.arrayString);
    if (![self.arrayString isEqualToString: self.opponentArrayString]) {
        NSLog(@"DIFFERENT BOARDS");
        _player1Turn = true;
        [self setNewBoard];
    }
}

-(void) setNewBoard
{
    // Set boardArray based on opponentArrayString
    NSLog(@"SET NEW BOARD");
    int count = 0;
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            NSLog(@"Char: %hu", (int)[_opponentArrayString characterAtIndex:count]-48);
            self.boardArray[i][j] = @((int)[_opponentArrayString characterAtIndex:count]-48);
            [_vc setBoardBasedOnArray];
            count += 1;
        }
    }
    [self printArrays];
}


@end
