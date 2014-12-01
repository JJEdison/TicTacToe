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
@property(nonatomic) NSTimer *timer2;

@end
@implementation TicTacToeBrain

-(void) initialize
{
    /*
     Each player starts polling for a blank board, each can make a move. Whoever goes first starts the game. Second player stops initial polling and starts polling as usual for difference. WIP
     */
//    self.LOOK UP
    
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
    [self.dataSource arrayURLString:@"http://cs.sonoma.edu/~ppfeffer/TicTacToe/dbInterface.py?bArray=000000000"];
    self.arrayString = @"000000000";
    self.timer2 = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(checkStart) userInfo:nil repeats: YES];
    self.p = 0;
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
    if(!self.player1Turn)
        return false;
    
    if (self.p == 0)
        self.p = 1;
    
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
        if (self.p==1){
            self.boardArray[row][col] = @1;
        }
        if (self.p==2)
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
-(bool) checkStart
{
//    if (self.player1Turn)
//        return false;
    
    NSLog(@"================================================");
    NSString *temp = @"http://cs.sonoma.edu/~ppfeffer/TicTacToe/dbInterface.py";
    //self.dataSource = [[TicTacToeDataSource alloc] initWithbArrayURLString:temp];
    [self.dataSource arrayURLString:temp];
    
    return true;
}
-(int) isThereAWinner {
    NSLog(@"Called check for win");
//    int i=0; int j=0;
//    int countToThree1=0;
//    //Horizantal
//    for(i=0; i<3;i++){
//        for(j=0; j<3; j++){
//            if ([self.boardArray[i][j] isEqual: @1]){
//                countToThree1 += 1;
//            }
//        }
//    }
//    if (countToThree1 >= 3){
//        return 1;
//    }
//   
//    for(i=0; i<3;i++){
//        countToThree1=0;
//        for(j=0; j<3; j++){
//            if ([self.boardArray[j][i] isEqual: @1]){
//                countToThree1 += 1;
//            }
//        }
//    }
//    
//    if (countToThree1 >= 3){
//        return 1;
//    }
//    return 0;
    
    // Vertical
    if (([self.boardArray[0][0] isEqual: @1] && [self.boardArray[1][0] isEqual: @1] && [self.boardArray[2][0] isEqual: @1]) ||
        ([self.boardArray[0][1] isEqual: @1] && [self.boardArray[1][1] isEqual: @1] && [self.boardArray[2][1] isEqual: @1]) ||
        ([self.boardArray[0][2] isEqual: @1] && [self.boardArray[1][2] isEqual: @1] && [self.boardArray[2][2] isEqual: @1]) ||
        
        ([self.boardArray[0][0] isEqual: @1] && [self.boardArray[0][1] isEqual: @1] && [self.boardArray[0][2] isEqual: @1]) ||
        ([self.boardArray[1][0] isEqual: @1] && [self.boardArray[1][1] isEqual: @1] && [self.boardArray[1][2] isEqual: @1]) ||
        ([self.boardArray[2][0] isEqual: @1] && [self.boardArray[2][1] isEqual: @1] && [self.boardArray[2][2] isEqual: @1]) ||
        
        ([self.boardArray[0][0] isEqual: @1] && [self.boardArray[1][1] isEqual: @1] && [self.boardArray[2][2] isEqual: @1]) ||
        ([self.boardArray[0][2] isEqual: @1] && [self.boardArray[1][1] isEqual: @1] && [self.boardArray[2][0] isEqual: @1])) {
        NSLog(@"PLAYER 1 WINS");
        return 1;
    } else if (([self.boardArray[0][0] isEqual: @2] && [self.boardArray[1][0] isEqual: @2] && [self.boardArray[2][0] isEqual: @2]) ||
        ([self.boardArray[0][1] isEqual: @2] && [self.boardArray[1][1] isEqual: @2] && [self.boardArray[2][1] isEqual: @2]) ||
        ([self.boardArray[0][2] isEqual: @2] && [self.boardArray[1][2] isEqual: @2] && [self.boardArray[2][2] isEqual: @2]) ||
        
        ([self.boardArray[0][0] isEqual: @2] && [self.boardArray[0][1] isEqual: @2] && [self.boardArray[0][2] isEqual: @2]) ||
        ([self.boardArray[1][0] isEqual: @2] && [self.boardArray[1][1] isEqual: @2] && [self.boardArray[1][2] isEqual: @2]) ||
        ([self.boardArray[2][0] isEqual: @2] && [self.boardArray[2][1] isEqual: @2] && [self.boardArray[2][2] isEqual: @2]) ||
        
        ([self.boardArray[0][0] isEqual: @2] && [self.boardArray[1][1] isEqual: @2] && [self.boardArray[2][2] isEqual: @2]) ||
        ([self.boardArray[0][2] isEqual: @2] && [self.boardArray[1][1] isEqual: @2] && [self.boardArray[2][0] isEqual: @2])) {
        NSLog(@"PLAYER 2 WINS");
        return 1;
    } else if ([self.arrayString rangeOfString:@"0"].location == NSNotFound){
        NSLog(@"Cats game");
        return 3;
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
        if (self.p == 0)
            self.p = 2;
        _player1Turn = true;
        [self setNewBoard];
        [self.timer2 invalidate];
    }
}

-(void) setNewBoard
{
    // Set boardArray based on opponentArrayString
    NSLog(@"SET NEW BOARD");
    int count = 0;
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
//            NSLog(@"Char: %d", (int)[_opponentArrayString characterAtIndex:count]-48);
            self.boardArray[i][j] = @((int)[_opponentArrayString characterAtIndex:count]-48);
            [_vc setBoardBasedOnArray];
            count += 1;
        }
    }
    [self printArrays];
    [self isThereAWinner];
}


@end
