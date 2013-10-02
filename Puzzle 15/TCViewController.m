//
//  TCViewController.m
//  Puzzle 15
//
//  Created by Vladimir on 9/26/13.
//  Copyright (c) 2013 turing-complete. All rights reserved.
//

#import "TCViewController.h"
#import "TCPuzzle15.h"


@interface TCViewController ()

@property (strong, nonatomic) NSMutableArray *tiles;
@property (strong, nonatomic) TCPuzzle15 *game;
@property (nonatomic) NSInteger gameboardSize;
@property (strong, nonatomic) NSArray *btns;

@end

@implementation TCViewController


const NSInteger SHUFFLE_COUNT = 10;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _btns = @[_btn1,_btn2,_btn3,_btn4,_btn5,_btn6,_btn7,_btn8,_btn9,_btn10,_btn11,_btn12,_btn13,_btn14,_btn15,_btn16];
    
    for (NSInteger i = 0; i < _btns.count-1; i++)
    {
        NSString * title = [NSString stringWithFormat:@"%i",i+1];
        
        UIButton *button = [_btns objectAtIndex:i];
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 10;
        button.layer.borderColor = [_btn1.titleLabel.textColor CGColor];
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    // Put all gameboard buttons in array
    _tiles = [NSMutableArray arrayWithArray:_btns];

    // Create a new game
    _gameboardSize = 4;
    _game = [[TCPuzzle15 alloc]initWithSize:_gameboardSize];
    
    // Shuffle gameboard
    //
}

- (void)viewDidAppear:(BOOL)animated {
    [self shuffleGameBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

-(void)shuffleGameBoard
{
    for (NSInteger i = 0; i < SHUFFLE_COUNT; i++)
    {
        
        NSInteger blankId = [_game makeMoveWithTileId:[_game randomTileAroundBlank]];
        NSInteger tileId = _game.blank;
        
//        NSLog(@"random tile around blank: %i", blankId);
//        NSLog(@"blank: %i", tileId);
        
        // Swap buttons in the array
        UIButton *thisTile = [_tiles objectAtIndex:tileId];
        UIButton *blankTile = [_tiles objectAtIndex:blankId];
        
        [_tiles replaceObjectAtIndex:tileId withObject:blankTile];
        [_tiles replaceObjectAtIndex:blankId withObject:thisTile];
        
        // Swap buttons on the screen
        CGRect blankTileFrame = blankTile.frame;
        CGRect thisTileFrame = thisTile.frame;
        
        

        blankTile.frame = thisTileFrame;
        thisTile.frame = blankTileFrame;

        
        
        
    }
    
    
    
//    _tiles = [NSMutableArray array];
//
//    NSArray *indices = [_game shuffleTimes:SHUFFLE_COUNT];
//    for (NSInteger i = 0; i < _btns.count; i++)
//    {
//        NSUInteger index = [[indices objectAtIndex:i] integerValue];
//        
//        NSLog(@"%i", index);
//        
//        UIButton *btnOld = [_btns objectAtIndex:i];
//        UIButton *btnNew = [_btns objectAtIndex:index];
//        btnNew.frame = btnOld.frame;
//        
//        [_tiles addObject:btnNew];
//        
//        // swap frames
//        
//        
//        
//        //[[_tiles objectAtIndex:i]setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
//    }
    _txtfldCount.text = @"count: 0";
}

#pragma mark - Actions

- (IBAction)btnClick:(id)sender
{
    NSInteger thisTileId = [_tiles indexOfObject:sender];
    NSInteger blankTileId = [_game makeMoveWithTileId:thisTileId];
    
    if(blankTileId != -1)
    {
        // Swap buttons in the array
        UIButton *thisTile = sender;
        UIButton *blankTile = [_tiles objectAtIndex:blankTileId];
        
        [_tiles replaceObjectAtIndex:thisTileId withObject:blankTile];
        [_tiles replaceObjectAtIndex:blankTileId withObject:thisTile];
        
        // Swap buttons on the screen
        CGRect blankTileFrame = blankTile.frame;
        CGRect thisTileFrame = thisTile.frame;
        
        
        [UIView animateWithDuration:0.2
                         animations:^{
                             blankTile.frame = thisTileFrame;
                             thisTile.frame = blankTileFrame;
                         }];

        // Update move count
        self.txtfldCount.text = [NSString stringWithFormat:@"count: %i", _game.movesCount];
        
        // Check if solved
        if([_game isSolved])
        {
            NSString *msg = [NSString stringWithFormat:@"You solved it with %i moves", _game.movesCount];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!!!"
                                        message:msg
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
            [alert show];
        }
    }
}
- (IBAction)btnRulesClick:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/15_puzzle"]];
}

- (IBAction)btnShuffleClick:(id)sender
{
    [self shuffleGameBoard];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self shuffleGameBoard];
}


@end
