//
//  CalixAnnotation.m
//  MapsDemo
//
//  Created by student on 10/27/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "CalixAnnotation.h"
#import <MapKit/MapKit.h>

@interface CalixAnnotation(){
    CLLocationCoordinate2D location;
}

@end

@implementation CalixAnnotation
-(id) init
{
    if( (self = [super init]) == nil )
        return nil;
    location.latitude = 38.265762;
    location.longitude = -122.658922;
    return self;
}
-(CLLocationCoordinate2D) coordinate
{
    return location;
}
-(NSString *) title
{
    return @"Calix";
}

-(NSString *) subtitle
{
    return @"My Work";
}

@end
