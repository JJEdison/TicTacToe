//
//  RandomSpot.m
//  MapsDemo
//
//  Created by student on 10/29/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "RandomSpot.h"
#import <MapKit/MapKit.h>
#import "stdlib.h"
@interface RandomSpot(){
    CLLocationCoordinate2D location;
}
@end

@implementation RandomSpot

-(id) init
{
//    if( (self = [super init]) == nil )
//        return nil;
    //Set to random values
    int n = -90 + arc4random() % (90+90);
    int w = -180 + arc4random() % (180+180);
    location.latitude = n;
    location.longitude = w;
    NSLog(@"%d", n);
    NSLog(@"%d", w);
    return self;
}
-(CLLocationCoordinate2D) coordinate
{
    return location;
}

-(NSString *) title
{
    return @"Some Random Place";
}

-(NSString *) subtitle
{
    return @"Where are we?";
}
@end
