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
#import "TicTacToeBrain.h"
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

@property (nonatomic, strong) TicTacToeBrain *tBrain;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tBrain = [[TicTacToeBrain alloc] init];
    [self.tBrain initialize];
    
    gameStarted = NO;
    
    CGRect screenBounds = [[ UIScreen mainScreen] bounds];
    
    _widthOfSubsquare = screenBounds.size.width;
    _gridFrame = CGRectMake(0, screenBounds.size.height / 2 - screenBounds.size.width / 2, screenBounds.size.width, screenBounds.size.width);
    
    int size = screenBounds.size.width;

    self.backView = [[UIView alloc] initWithFrame:_gridFrame];
    self.gridView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, size, size)];
    [self.backView addSubview:self.gridView];


    [self.gridView addGestureRecognizer:self.tapGest];
    
    self.gridImageView.frame = CGRectMake(0, 0, size, size);
    UIImage *image = [UIImage imageNamed:@"grid2.png"];
    self.gridImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, size, size)];
    [self.gridImageView setImage:image];
    [self.gridView addSubview:self.gridImageView];
    [self.gridView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.backView];
    _balls = [[NSMutableArray alloc] init];
}


-(UITapGestureRecognizer *) tapGest
{
    NSLog(@"Did tap");
    
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
    gameStarted = YES;
    CGPoint bp = [tapObject locationInView:self.backView];
    int squareWidth = _widthOfSubsquare / 3;
    int player=0;
    if (self.tBrain.player1Turn){
        player=1;
    }
    else
    {
     player=2;
    }
    CGPoint tapInGrid = CGPointMake(bp.x/squareWidth, bp.y/squareWidth);
    if(![self.tBrain isValidTap:[NSValue valueWithCGPoint:tapInGrid] byPlayer:player]){
        NSLog(@"Invalid tap");
        return;
    }

    NSLog(@"Valid tap at: %@\n\n", NSStringFromCGPoint(bp) );
    // The board is divided into nine equally sized squares and thus width = height.
    UIImageView *iView;
    if (player == 1)
        iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redMarble.png"]];
    else
        iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenMarble.png"]];
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
    
    [self.tBrain isThereAWinner];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
