//
//  SantaRosaAnnotation.m
//  MapsDemo
//
//  Created by AAK on 4/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "SantaRosaAnnotation.h"

@interface SantaRosaAnnotation() {
    CLLocationCoordinate2D location;
}

@end


@implementation SantaRosaAnnotation

-(id) init
{
	if( (self = [super init]) == nil )
		return nil;
    
	location.latitude  = 38.446329;
	location.longitude = -122.714882;
	return self;
}


-(CLLocationCoordinate2D) coordinate
{
	return location;
}

-(NSString *) title
{
	return @"Santa Rosa, CA";
}

-(NSString *) subtitle
{
	return @"Population: 175,000";
}

@end
