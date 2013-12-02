//
//  MainGameLayer.h
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//
#import "HudStickLayer.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Player.h"
#import "PipeAndRock.h"
#import "MarioContactListener.h"
#import <vector>
#import <algorithm>

@interface MainGameLayer : CCLayer {
    CGSize winSize;
    CCTMXTiledMap *tileMap_;
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
    
    CCAction *goldBrickFlash_;
    CCAction *flowerFlash_;
    int pushUpTimes_;
    int faceWallTimes_;
    
    float totalPressTime_;
    MarioStatus mario_status;
}

@property (nonatomic, retain) HudStickLayer *hud;

- (void) reset;
@end


@interface MainGameScene : CCScene {
    HudStickLayer *hudLayer_;
    MainGameLayer *gameLayer_;
}

@property (nonatomic, retain) HudStickLayer *hudLayer;
@property (nonatomic, retain) MainGameLayer *gameLayer;

+ (id) scene;

@end