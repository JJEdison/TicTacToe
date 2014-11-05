//
//  MapViewController.m
//  MapsDemo
//
//  Created by AAK on 4/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "DetailedViewController.h"
#import "MapViewController.h"
#import "MapViewController.h"
#import "SSUAnnotation.h"
#import "SFAnnotation.h"
#import "SantaRosaAnnotation.h"
#import "CalixAnnotation.h"
#import "RandomSpot.h"


@interface MapViewController()

@property (nonatomic) NSMutableArray *mapAnnotations;
@property (nonatomic) UISegmentedControl *mapTypeSegCtl;
@property (nonatomic) UISegmentedControl *mapLocationSegCtl;
@property (nonatomic) MKMapView *mapView;
@property (nonatomic) DetailedViewController *detailViewController;

-(void) setMapType: (id) sender;
-(void) setMapLocation: (id) sender;
-(UISegmentedControl *) makeSegmentedControl: (NSArray *) labels withY: (NSInteger) yValue;

@end


enum
{
    kSSUAnnotationIndex = 0,
    kSFAnnotationIndex,
	kSantaRosaAnnotationIndex,
    kCalixAnnotationIndex,
    kRandomSpot
};

@implementation MapViewController


-(void) viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setToolbarHidden:YES];
	[self.navigationController setNavigationBarHidden: YES];
	CGRect bounds = [[UIScreen mainScreen] applicationFrame];
	self.mapView = [[ MKMapView alloc] initWithFrame: CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
	self.mapView.delegate = self;
	[self.view insertSubview: self.mapView atIndex:0 ];
    //	mapView.showsUserLocation = YES;  // If set, it will track the location of the device.
	self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity: 4]; // 3 coordinates initially
    
	SSUAnnotation *ssuAnnotation = [[SSUAnnotation alloc] init];
	[self.mapAnnotations insertObject: ssuAnnotation atIndex: kSSUAnnotationIndex];
	
	SFAnnotation *sfAnnotation = [[SFAnnotation alloc] init];
	[self.mapAnnotations insertObject: sfAnnotation atIndex: kSFAnnotationIndex];
	
	SantaRosaAnnotation *srAnnotation = [[SantaRosaAnnotation alloc] init];
	[self.mapAnnotations insertObject: srAnnotation atIndex: kSantaRosaAnnotationIndex];
    
    CalixAnnotation * cAnnotation = [[CalixAnnotation alloc] init];
    [self.mapAnnotations insertObject:cAnnotation atIndex:kCalixAnnotationIndex];
    
    RandomSpot * rAnnotation = [[RandomSpot alloc] init];
    [self.mapAnnotations insertObject:rAnnotation atIndex:kRandomSpot];
    
	self.mapView.mapType = MKMapTypeHybrid;
//    self.mapView.zoomEnabled = FALSE;
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = 38.340394;   // Set to SSU location...
	newRegion.center.longitude = -122.675411;
    //Changes the zoom level
    newRegion.span.latitudeDelta = 0.000394;
    newRegion.span.longitudeDelta = 0.005411;
	
	[self.mapView setRegion:newRegion animated: YES];
}

/**
 Make a segmented control to control the map
 */
-(UISegmentedControl *) makeSegmentedControl: (NSArray *) labels withY: (NSInteger) yValue
{
	if( [labels count] == 0 )
		return nil;
	
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems: labels];
	UIColor *tintColor = [[UIColor alloc] initWithRed:0.7 green:0.5 blue:.0 alpha:1.0];
    tintColor = [UIColor blackColor];
//	segmentedControl.tintColor = tintColor;
	segmentedControl.momentary = YES;
	segmentedControl.alpha = 0.7;
    //	CGRect segBounds = segmentedControl.bounds;
//	CGRect screenBounds = [[UIScreen mainScreen] applicationFrame];

    segmentedControl.apportionsSegmentWidthsByContent = YES;
    [segmentedControl sizeToFit];
    segmentedControl.center = CGPointMake(self.view.frame.size.width/2, yValue);
    
    segmentedControl.layer.borderColor = [UIColor blueColor].CGColor;
    segmentedControl.layer.borderWidth = 1.0f;
    segmentedControl.layer.cornerRadius = 5.0f;
    
	return segmentedControl;
}

// Gets called before viewdidload gets called
-(void) loadView
{
	[super loadView];
	//Creating aray for 2 segmented controls that we are displaying IE the stuff you can clig
    //Configured in viewdidload
	NSArray *segStrings = [NSArray arrayWithObjects:@"Standard", @"Satellite", @"Hybrid", nil];
	self.mapTypeSegCtl = [self makeSegmentedControl: segStrings withY: 520];
	[self.mapTypeSegCtl addTarget:self action:@selector(setMapType:) forControlEvents:UIControlEventValueChanged];
    [self.mapTypeSegCtl setBackgroundColor:[UIColor whiteColor]];
    NSArray *locationStrings = [NSArray arrayWithObjects:@"SSU", @"San Francisco", @"Santa Rosa", @"Calix", @"?", nil];
	self.mapLocationSegCtl = [self makeSegmentedControl: locationStrings withY: 550];
	[self.mapLocationSegCtl addTarget:self action:@selector(setMapLocation:) forControlEvents:UIControlEventValueChanged];
    [self.mapLocationSegCtl setBackgroundColor:[UIColor whiteColor]];

	[self.view addSubview: self.mapTypeSegCtl];
	[self.view addSubview: self.mapLocationSegCtl];
}


-(void) setMapType: (UISegmentedControl *) sender
{
	[self.mapView removeAnnotations:self.mapView.annotations];
	UISegmentedControl *control = (UISegmentedControl *) sender;
	if( control.selectedSegmentIndex == 0 )
		self.mapView.mapType = MKMapTypeStandard;
	else if( control.selectedSegmentIndex == 1 )
		self.mapView.mapType = MKMapTypeSatellite;
	else
		self.mapView.mapType = MKMapTypeHybrid;
}

-(void) setMapLocation: (id) sender
{
	UISegmentedControl *control = (UISegmentedControl *) sender;
	[self.mapView removeAnnotations:self.mapView.annotations];  // remove all existing annotations
    id annotation;
	if( control.selectedSegmentIndex == 0 ) {
        annotation = [self.mapAnnotations objectAtIndex:kSSUAnnotationIndex];
	} else if( control.selectedSegmentIndex == 1 ) {
        annotation = [self.mapAnnotations objectAtIndex:kSFAnnotationIndex];
	}
    else if(control.selectedSegmentIndex == 2){
        annotation = [self.mapAnnotations objectAtIndex:kSantaRosaAnnotationIndex];
    }
    else if(control.selectedSegmentIndex == 3){
        annotation = [self.mapAnnotations objectAtIndex:kCalixAnnotationIndex];
    }
    else{
        RandomSpot * rAnnotation = [[RandomSpot alloc] init];
        [self.mapAnnotations insertObject:rAnnotation atIndex:kRandomSpot];
        annotation = [self.mapAnnotations objectAtIndex:kRandomSpot];
    }
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([annotation coordinate], 50000, 50000);
    [self.mapView addAnnotation: annotation];
    //This is where you zoom  / center the map
    [self.mapView setRegion:region];
}

-(void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.navigationController setNavigationBarHidden:YES];
}

#pragma mark MKMapViewDelegate

-(void)mapView:(MKMapView *) mapV didAddAnnotationViews: (NSArray *) views {
	MKAnnotationView *annView = [views objectAtIndex: 0];  // We are adding one annotation at this time...
	id<MKAnnotation> mp = [annView annotation];
	MKCoordinateRegion region;
	// For SF, 5 Kilometers east-west and north-south
	if( [mp isKindOfClass: [SFAnnotation class] ] )
		region = MKCoordinateRegionMakeWithDistance([mp coordinate], 5000, 5000);
	else if( [mp isKindOfClass: [SSUAnnotation class] ] )  // more detailed map for SSU
		region = MKCoordinateRegionMakeWithDistance([mp coordinate], 500, 500);
    else if( [mp isKindOfClass:[SantaRosaAnnotation class] ])
        region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1000, 1000);
    else if( [mp isKindOfClass:[CalixAnnotation class] ])
        region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1000, 1000);
    else if ( [mp isKindOfClass:[RandomSpot class] ])
        region = MKCoordinateRegionMakeWithDistance([mp coordinate], 5000, 5000);
	else
		region = MKCoordinateRegionMakeWithDistance([mp coordinate], 5000, 5000);
	[mapV setRegion:region animated: YES];
    [mapV selectAnnotation:mp animated:YES];
}

- (void)showDetails:(id)sender
{
	self.detailViewController = [[DetailedViewController alloc] init];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
	static int i = 0;
	NSString *reuseID = [NSString stringWithFormat: @"pinAnnotation%d", i];
	i++;
	MKPinAnnotationView* pinView = (MKPinAnnotationView *)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier: reuseID];
	
	if( ! pinView ) {
		pinView = [[MKPinAnnotationView alloc]
                   initWithAnnotation:annotation reuseIdentifier: reuseID];
		if( [annotation isKindOfClass:[SSUAnnotation class]] )
			pinView.pinColor = MKPinAnnotationColorPurple;
		else
			pinView.pinColor = MKPinAnnotationColorRed;
		pinView.animatesDrop = YES;
		pinView.canShowCallout = YES;
		if( [annotation isKindOfClass: [SFAnnotation class]] ) {  // add a detailed view for SF
			UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            pinView.rightCalloutAccessoryView = rightButton;
			
		}
	} else {
		pinView.annotation = annotation;
	}
	return pinView;
}


@end
