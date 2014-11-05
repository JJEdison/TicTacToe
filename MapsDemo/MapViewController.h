//
//  MapViewController.h
//  MapsDemo
//
//  Created by AAK on 4/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>

@interface MapViewController: UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>
/**
 Make a segmented control to control the map
 
 */
-(UISegmentedControl *) makeSegmentedControl: (NSArray *) labels withY: (NSInteger) yValue;

@end
