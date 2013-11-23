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

#define PTM_RATIO 32

typedef enum {
    kGameObjectNone,
    kGameObjectPlayer,
    kGameObjectEnemy,
    kGameObjectBrick,
    kGameobjectGoldBrick,
    kGameobjectMushBrick,
    kGameObjectPlatform
} GameObjectType;

typedef enum {
    kMarioSmall,
    kMarioLarge,
    kMarioCanFire
} MarioStatus;
#endif
