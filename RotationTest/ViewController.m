//
//  ViewController.m
//  LayerAnimation
//
//  Created by AAK on 2/19/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//


// This App demonstrates how to apply rotation to the layer of a grid and the balls
// that are placed in it.

#import "ViewController.h"

const int BORDER_WIDTH = 10;
const int TOP_MARGIN = 50;


@interface ViewController () {
    int _widthOfSubsquare;
    CGRect _gridFrame;
    BOOL gameStarted;
}

@property(nonatomic) CALayer *blueLayer;
@property(nonatomic) UIImageView *gridImageView;
@property (nonatomic) UITapGestureRecognizer *tapGest;
@property(nonatomic) int widthOfSubsquare;
@property(nonatomic) UIView *gridView;
@property(nonatomic) CALayer *ballLayer;
@property(nonatomic) UIView *backView;
@property(nonatomic) NSMutableArray *balls;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _widthOfSubsquare = 145;
    gameStarted = NO;
    
    _gridFrame = CGRectMake(50, 100, 145, 145);

    
    // As gridView animates, the coordinates of its grame rotates with it. So, for example, if it
    // rotates by 90 degrees, then its origin is no longer at (0, 0) with respect to its superview,
    // it is at (widthOfSubsquare, 0). So, after the rotation, the coordinates of the points that
    // you tap in the window, when located using:
    
    //     CGPoint p = [tapObject locationInView:self.gridView];

    // will be reported with respect to the new origin of gridView, which is no longer consistent
    // with the grid as it appears to the user. So, the tap  points have to get converted back to
    // the user's view point. To do that, I have created a backView. backView will contain the
    // gridView. After the gridView rotates, we get the location of taps in gridView and then
    // we ask for the location of the point to be converted to the coordiantes of the backView. Since
    // the backView doesn't rotate, its origin is consistent with what the user expects to see.

    self.backView = [[UIView alloc] initWithFrame:_gridFrame];
    self.gridView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 145, 145)];
    [self.backView addSubview:self.gridView];


    [self.gridView addGestureRecognizer:self.tapGest];
    
    self.gridImageView.frame = CGRectMake(0, 0, 145, 145);
    UIImage *image = [UIImage imageNamed:@"grid.png"];
    self.gridImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 145, 145)];
    [self.gridImageView setImage:image];
    [self.gridView addSubview:self.gridImageView];
    [self.gridView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.backView];
    _balls = [[NSMutableArray alloc] init];
}


-(UITapGestureRecognizer *) tapGest
{
    if( ! _tapGest ) {
        _tapGest = [[UITapGestureRecognizer alloc]
                    initWithTarget:self action:@selector(didTapTheView:)];
        
        [_tapGest setNumberOfTapsRequired:1];
        [_tapGest setNumberOfTouchesRequired:1];
    }
    return _tapGest;
}



-(void) didTapTheView: (UITapGestureRecognizer *) tapObject
{
    // p is the location of the tap in self.gridView. We convert it to the coordinates of the
    // self.backView, which is unchanged.
    
    gameStarted = YES;
    CGPoint bp = [tapObject locationInView:self.backView];

    NSLog(@"tapped at: %@", NSStringFromCGPoint(bp) );
    int squareWidth = _widthOfSubsquare / 3;
    // The board is divided into nine equally sized squares and thus width = height.
    UIImageView *iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redMarble.png"]];
    iView.frame = CGRectMake((int) (bp.x / squareWidth) * squareWidth,
                             (int) (bp.y / squareWidth) * squareWidth,
                             squareWidth,
                             squareWidth);
    
    
    self.ballLayer = [CALayer layer];
    [self.ballLayer addSublayer: iView.layer];
    self.ballLayer.frame = CGRectMake(0, 0, _widthOfSubsquare, _widthOfSubsquare);
    if( [self.balls count] > 0 )
        self.ballLayer.affineTransform = ((UIImageView *) self.balls[0]).layer.affineTransform;
    else
        self.ballLayer.affineTransform = CGAffineTransformIdentity;
    [self.gridView.layer addSublayer:self.ballLayer];
    [self.balls addObject:iView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
