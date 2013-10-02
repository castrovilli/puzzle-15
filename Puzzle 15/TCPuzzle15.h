//
//  TCPuzzle15.h
//  Puzzle 15
//
//  Created by Vladimir on 9/26/13.
//  Copyright (c) 2013 turing-complete. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCPuzzle15 : NSObject

@property (readonly, nonatomic) NSInteger movesCount;
@property (readonly, nonatomic) NSInteger blank;
- (id)init;
- (id)initWithSize:(NSInteger)size;
- (NSInteger)makeMoveWithTileId:(NSInteger)tileId;
- (NSInteger)randomTileAroundBlank;
- (NSArray *)shuffleTimes:(NSInteger)count;
- (BOOL)isSolved;

@end
