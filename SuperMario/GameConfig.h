//
//  Header.h
//  SuperMario
//
//  Created by jashon on 13-11-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#ifndef SuperMario_Header_h
#define SuperMario_Header_h

#define kGameOrientationPortrait 1
#define kGameOrientationLandScape 2

#define GAME_ORIENTATION kGameOrientationLandScape

#define PTM_RATIO 32.0

#define BIAS_IMPULSE 3.0

#define IS_PLAYER(x, y) (x.type == kGameObjectPlayer || y.type == kGameObjectPlayer)
#define IS_BRICK(x, y) (x.type == kGameObjectBrick || y.type == kGameObjectBrick)
#define IS_MUSHROOM(x, y) (x.type == kGameObjectMushRoom || y.type == kGameObjectMushRoom)
#define IS_GOLDBRICK(x, y) (x.type == kGameObjectGoldBrick || y.type == kGameObjectGoldBrick)
#define IS_MUSHBRICK(x, y) (x.type == kGameObjectMushBrick || y.type == kGameObjectMushBrick)
#define IS_IRONBRICK(x, y) (x.type == kGameObjectIronBrick || y.type == kGameObjectIronBrick)

typedef enum {
    kGameObjectNone,
    kGameObjectPlayer,
    kGameObjectEnemy,
    kGameObjectMushRoom,
    kGameObjectFlower,
    kGameObjectBrick,
    kGameObjectIronBrick,
    kGameObjectGoldBrick,
    kGameObjectMushBrick,
    kGameObjectPipe,
    kGameObjectRock,
    kGameObjectPlatform
} GameObjectType;

typedef enum {
    kMarioSmall,
    kMarioLarge,
    kMarioCanFire
} MarioStatus;

typedef enum {
    kStickHeadingZero,
    kStickHeadingRight,
    kStickHeadingLeft,
    kStickHeadingUp,
    kStickHeadingDown
} StickHeading;
#endif
