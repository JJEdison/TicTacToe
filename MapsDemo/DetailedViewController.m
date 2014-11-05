//
//  DetailedViewController.m
//  MapsDemo
//
//  Created by AAK on 4/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "DetailedViewController.h"

@implementation DetailedViewController

-(void) loadView
{
	[super loadView];
	[self.navigationController setNavigationBarHidden: NO];
	self.title  = @"San Francisco";
	NSURL *url = [NSURL URLWithString: @"http://kooshesh.cs.sonoma.edu/cs470/sf_pics/city_1.jpg"];
	NSData *data = [[NSData alloc] initWithContentsOfURL:url];
	UIImage *cityImage = [UIImage imageWithData: data];
	UIImageView *image = [[UIImageView alloc] initWithImage:cityImage];
	CGRect bounds = [image bounds];
	CGRect frame = [[UIScreen mainScreen] applicationFrame];
	CGRect imageFrame = CGRectMake( (frame.size.width - bounds.size.width) / 2,
								   (frame.size.height - bounds.size.height - frame.origin.y) / 2, bounds.size.width, bounds.size.height);
	image.frame = imageFrame;
	[self.view addSubview:image];
	[self.view setBackgroundColor: [UIColor blackColor]];
}

@end
