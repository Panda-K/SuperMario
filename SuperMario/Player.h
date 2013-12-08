//
//  Player.h
//  SuperMario
//
//  Created by jashon on 13-11-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "GameConfig.h"

@interface Player : GameObject {
    b2Fixture *p_topRightFixture;
    b2Fixture *p_topLeftFixture;
    BOOL isMarioStop_;
    BOOL isMarioMovingRight_;
    BOOL isMoveFast_;
    BOOL isJump_;
    BOOL readyToJump_;
    BOOL isFaceWall_;
    BOOL isFireing_;
    StickHeading stkHead_;
    MarioStatus p_mario_status;
}

@property (nonatomic, readwrite) b2Fixture *topRightFixture;
@property (nonatomic, readwrite) b2Fixture *topLeftFixture;
@property (nonatomic, readwrite) BOOL isMarioStop;
@property (nonatomic, readwrite) BOOL isMarioMovingRight;
@property (nonatomic, readwrite) BOOL isMoveFast;
@property (nonatomic, readwrite) BOOL isJump;
@property (nonatomic, readwrite) BOOL readyToJump;
@property (nonatomic, readwrite) BOOL isFaceWall;
@property (nonatomic, readwrite) BOOL isFireing;
@property (nonatomic, readwrite) StickHeading stkHead;
@property (nonatomic, readwrite) MarioStatus marioStatus;

- (void) moveRight;
- (void) moveLeft;
- (void) jump;
- (void) down;
- (void)createPhisicsBody:(b2World *)world 
                  postion:(CGPoint)pos 
                     size:(CGPoint)size 
                  dynamic:(BOOL)dy 
                 friction:(float)f 
                  density:(float)dens 
              restitution:(long)rest 
                    boxId:(int)id;
- (void) resizeBodyAtPositon:(CGPoint)pos 
                        size:(CGPoint)size
                    friction:(float)f 
                     density:(float)dens 
                 restitution:(float)rest;

@end
