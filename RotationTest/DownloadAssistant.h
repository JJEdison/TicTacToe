//
//  DownloadAssistant.h
//  SharedServicesActivityReportingSystem
//
//  Created by Ali Kooshesh on 12/25/13.
//  Copyright (c) 2013 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicTacToeBrain.h"

@protocol WebDataReadyDelegate;

@interface DownloadAssistant : NSObject<NSURLConnectionDelegate>

@property (nonatomic) id<WebDataReadyDelegate> delegate;

-(void) downloadContentsOfURL: (NSURL *) url;
-(NSData *) downloadedData;
-(void) getBrain: (TicTacToeBrain *) b;
-(instancetype) initializeWithBrain: (TicTacToeBrain *) b;

@end

@protocol WebDataReadyDelegate<NSObject>

@required

-(void) acceptWebData: (NSData *) webData forURL: (NSURL *) url;


@end
