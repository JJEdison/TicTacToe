//
//  SFAnnotation.m
//  MapsDemo
//
//  Created by AAK on 4/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "SFAnnotation.h"

@interface SFAnnotation() {
    CLLocationCoordinate2D location;
}

@end

@implementation SFAnnotation

-(id) init
{
	if( (self = [super init]) == nil )
		return nil;
	location.latitude = 37.786996;
    location.longitude = -122.419281;
	return self;
}

- (CLLocationCoordinate2D)coordinate;
{
    return location;
}

- (NSString *)title
{
    return @"San Francisco";
}

- (NSString *)subtitle
{
    return @"Founded: June 29, 1776";
}

@end
