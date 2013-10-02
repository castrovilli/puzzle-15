//
//  TCPuzzle15.m
//  Puzzle 15
//
//  Created by Vladimir on 9/26/13.
//  Copyright (c) 2013 turing-complete. All rights reserved.
//

#include <math.h>
#import "TCPuzzle15.h"

@implementation TCPuzzle15
{
    NSInteger _size;
    //NSInteger _blank;
    NSMutableArray *_gameboard;
}

const NSInteger DEFAULT_SIZE = 4;

-(id)init
{
    return [self initWithSize:DEFAULT_SIZE];
}

-(id)initWithSize:(NSInteger)size
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _size = size;
    
    NSInteger tilesCount = _size*_size;
    
    _movesCount = 0;
    _blank = tilesCount-1;
    
    _gameboard = [NSMutableArray arrayWithCapacity:tilesCount];
    for (NSInteger i = 0; i < tilesCount; i++)
    {
        [_gameboard addObject:@(i)];
    }
    
    return self;
}

-(NSInteger) makeMoveWithTileId:(NSInteger)tileId
{
    // Iterate over all tile ids adjasent to tileId
    for (NSNumber *adjTileId in [self adjacentTileIdsForTileId:tileId])
    {
        // If there is a blank tile around then swap it with tile with the specified tile id
        if([adjTileId integerValue] == _blank)
        {
            [self swapTile:[adjTileId integerValue] withTile:tileId] ;
            
            _blank = tileId;
            _movesCount++;
            
            return [adjTileId integerValue];
        }
    }
    return -1;
}

- (NSInteger)randomTileAroundBlank
{
    return [self randomAdjacentTileIdForTileId:_blank];
}


- (NSMutableArray *) adjacentTileIdsForTileId:(NSInteger) tileId
{
    NSMutableArray *adjacentTileIds = [NSMutableArray array];
    
    // check the tile below
    if(tileId + _size < _gameboard.count)
        [adjacentTileIds addObject:@(tileId + _size)];
    
    // check the tile above
    if(tileId - _size >= 0)
        [adjacentTileIds addObject:@(tileId - _size)];
    
    // check the tile on the left
    if(tileId % _size != 0)
        [adjacentTileIds addObject:@(tileId - 1)];
    
    // check the tile the right
    if((tileId + 1) % _size != 0)
        [adjacentTileIds addObject:@(tileId + 1)];
    
    return adjacentTileIds;
}

// Returns array of tile titles.
- (NSArray *) shuffleTimes:(NSInteger)count
{
    for (NSInteger i = 0; i < count; i++)
    {
        [self makeMoveWithTileId:[self randomAdjacentTileIdForTileId:_blank]];
    }
    _movesCount = 0;
    
    // Form and return titles
//    NSMutableArray* titles = [NSMutableArray array];
//    for (NSInteger i = 0; i < _gameboard.count; i++)
//    {
//        NSNumber *n = [_gameboard objectAtIndex:i];
//        NSString *title = [n isEqualToNumber:@(_size*_size)] ? @"" : [n stringValue];
//        [titles addObject:title];
//    }
//
//    return titles;
    
    return _gameboard;
}

- (BOOL) isSolved
{
    for(NSInteger i = 0; i < _gameboard.count; i++)
    {
        if (![[_gameboard objectAtIndex:i] isEqualToNumber:@(i)])
        {
            return NO;
        }
    }
    return YES;
}

- (void) swapTile:(NSInteger)tileId1 withTile:(NSInteger)tileId2
{
    id tile1 = [_gameboard objectAtIndex:tileId1];
    id tile2 = [_gameboard objectAtIndex:tileId2];
    
    [_gameboard  replaceObjectAtIndex:tileId1 withObject:tile2];
    [_gameboard replaceObjectAtIndex:tileId2 withObject:tile1];
}

-(NSInteger)randomAdjacentTileIdForTileId:(NSInteger)tileId
{
    NSArray * adjacentTileIds = [self adjacentTileIdsForTileId:tileId];
    NSInteger randomNumber = rand() % adjacentTileIds.count;
    
    return [[adjacentTileIds objectAtIndex:randomNumber]integerValue];
}

@end
