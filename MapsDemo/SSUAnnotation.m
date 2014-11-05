//
//  SSUAnnotation.m
//  MapsDemo
//
//  Created by AAK on 4/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "SSUAnnotation.h"
#import <MapKit/MapKit.h>

@interface SSUAnnotation() {
    CLLocationCoordinate2D location;
}

@end

@implementation SSUAnnotation

-(id) init
{
	if( (self = [super init]) == nil )
		return nil;
	location.latitude = 38.340394;
	location.longitude = -122.675411;
	return self;
}


-(CLLocationCoordinate2D) coordinate
{
	return location;
}

-(NSString *) title
{
	return @"Sonoma State University";
}

-(NSString *) subtitle
{
	return @"The center of the universe!";
}

@end
