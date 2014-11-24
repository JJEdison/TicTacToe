//
//  TicTacToeDataSource.h
//  Tic Tac Toe
//
//  Created by student on 11/12/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadAssistant.h"
#import "TicTacToeDataSource.h"

@protocol DataSourceReadyForUseDelegate;




@interface TicTacToeDataSource : NSObject<WebDataReadyDelegate>

@property (nonatomic) id<DataSourceReadyForUseDelegate> delegate;
@property (nonatomic) BOOL dataReadyForUse;

-(instancetype) initWithbArrayURLString: (NSString *) bURL;
-(instancetype) initializeWithBrain: (TicTacToeBrain *) b;
-(void) arrayURLString: (NSString *) bURL;
-(DownloadAssistant *) getDownloadAss;
-(void) getBrain: (TicTacToeBrain *) b;


@end

@protocol DataSourceReadyForUseDelegate <NSObject>

@optional

-(void) dataSourceReadyForUse: (TicTacToeDataSource *) dataSource;



@end
