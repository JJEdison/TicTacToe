//
//  TicTacToeDataSource.m
//  Tic Tac Toe
//
//  Created by student on 11/12/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//


#import "TicTacToeDataSource.h"

@interface TicTacToeDataSource()

@property( nonatomic) NSString * bArrayURLString;
@property( nonatomic)NSData * bArrayData;
@property(nonatomic) DownloadAssistant *downloadAssitant;

@end

@implementation TicTacToeDataSource


-(instancetype) initWithbArrayURLString:(NSString *)bURL
{
    if( (self = [super init] ) == nil ){
        return nil;
    }
    
    self.bArrayURLString = bURL;
    _downloadAssitant = [[DownloadAssistant alloc] init];
    
    [self.downloadAssitant setDelegate:self];
    self.dataReadyForUse = NO;
    
    NSURL *url = [NSURL URLWithString: self.bArrayURLString];
    [self.downloadAssitant downloadContentsOfURL:url];
    return self;
}


@end
