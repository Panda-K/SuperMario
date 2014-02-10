//
//  DownWorldLayer.h
//  SuperMario
//
//  Created by jashon on 14-1-8.
//  Copyright (c) 2014年 __xuzhaojia__. All rights reserved.
//
#import "HudStickLayer.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Player.h"
#import "PipeAndRock.h"
#import "MoveRectObject.h"
#import "MarioContactListener.h"
#import <vector>
#import <algorithm>

@interface DownWorldLayer : CCLayer {
    CGSize winSize;
    CCTMXTiledMap *tileMap_;
    CCTMXTiledMap *downWorldTiledMap_;
    b2World *world_;
    GLESDebugDraw *m_debugDraw;
    Player *player_;
    CCSpriteBatchNode *spriteSheet_;
    HudStickLayer *hud_;
    MarioContactListener *contactListener_;
    
    CCAction *marios_runFastL;
    CCAction *marios_runFastR;
    CCAction *marios_runMediumR;
    CCAction *marios_runMediumL;
    CCAction *marios_runSlowL;
    CCAction *marios_runSlowR;
    
    CCSpriteFrame *marios_standR;
    CCSpriteFrame *marios_standL;
    CCSpriteFrame *marios_stopR;
    CCSpriteFrame *marios_stopL;
    CCSpriteFrame *marios_jumpR;
    CCSpriteFrame *marios_jumpL;
    
    CCAction *mariom_runFastL;
    CCAction *mariom_runFastR;
    CCAction *mariom_runMediumR;
    CCAction *mariom_runMediumL;
    CCAction *mariom_runSlowL;
    CCAction *mariom_runSlowR;
    
    CCSpriteFrame *mariom_standR;
    CCSpriteFrame *mariom_standL;
    CCSpriteFrame *mariom_stopR;
    CCSpriteFrame *mariom_stopL;
    CCSpriteFrame *mariom_jumpR;
    CCSpriteFrame *mariom_jumpL;
    
    CCAction *mariol_runFastL;
    CCAction *mariol_runFastR;
    CCAction *mariol_runMediumR;
    CCAction *mariol_runMediumL;
    CCAction *mariol_runSlowL;
    CCAction *mariol_runSlowR;
    
    CCSpriteFrame *mariol_standR;
    CCSpriteFrame *mariol_standL;
    CCSpriteFrame *mariol_stopR;
    CCSpriteFrame *mariol_stopL;
    CCSpriteFrame *mariol_jumpR;
    CCSpriteFrame *mariol_jumpL;
    CCSpriteFrame *ironBrick_;
    
    CCAction *mariol_fireL;
    CCAction *mariol_fireR;
    
    CCAction *flashMarioS_WalkR1;
    CCAction *flashMarioS_WalkR2;
    CCAction *flashMarioS_WalkR3;
    
    CCAction *flashMarioS_WalkL1;
    CCAction *flashMarioS_WalkL2;
    CCAction *flashMarioS_WalkL3;
    
    CCAction *flashMarioL_WalkR1;
    CCAction *flashMarioL_WalkR2;
    CCAction *flashMarioL_WalkR3;
    
    CCAction *flashMarioL_WalkL1;
    CCAction *flashMarioL_WalkL2;
    CCAction *flashMarioL_WalkL3;
    
    CCAction *starMarioL_standR;
    CCAction *starMarioL_standL;
    CCAction *starMarioL_stopR;
    CCAction *starMarioL_stopL;
    CCAction *starMarioL_jumpR;
    CCAction *starMarioL_jumpL;
    CCAction *starMarioL_runFastL;
    CCAction *starMarioL_runFastR;
    CCAction *starMarioL_runMediumR;
    CCAction *starMarioL_runMediumL;
    CCAction *starMarioL_runSlowR;
    CCAction *starMarioL_runSlowL;
    
    CCAction *starMarioS_standR;
    CCAction *starMarioS_standL;
    CCAction *starMarioS_stopR;
    CCAction *starMarioS_stopL;
    CCAction *starMarioS_jumpR;
    CCAction *starMarioS_jumpL;
    CCAction *starMarioS_runFastL;
    CCAction *starMarioS_runFastR;
    CCAction *starMarioS_runMediumR;
    CCAction *starMarioS_runMediumL;
    CCAction *starMarioS_runSlowR;
    CCAction *starMarioS_runSlowL;
    
    CCAction *goldBrickFlash_;
    CCAction *flowerFlash_;
    CCAction *coinUp_;
    CCAction *fireBallRotate_;
    CCAction *fireBallExplode_;
    CCAction *starFlash_;
    CCAction *coinFlash_;
    
    CCAction *enemy1_walk;
    
    int pushUpTimes_;
    int faceWallTimes_;
    int jumpTimes_;
    
    float totalPressTime_;
    
    float totalPressTimeA_;
    float fireDelta_;
    
    NSDate *multiCoinBrickStart_;
    int multiCoinBrickPushUpTimes_;
    NSDate *starMarioStart_;
    NSMutableArray *coinArray_;
}
@property (nonatomic, retain) HudStickLayer *hud;

@end

@interface DownWorldScene : CCScene {
    DownWorldLayer *downWorldLayer_;
    HudStickLayer *hudLayer_;
}
@property (nonatomic, retain) DownWorldLayer *downWorldLayer;
@property (nonatomic, retain) HudStickLayer *hudLayer;

+ (id) scene;
@end