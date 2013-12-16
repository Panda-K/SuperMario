//
//  MainGameLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "MainGameLayer.h"
#import "AppDelegate.h"

@implementation MainGameLayer
using namespace std;
@synthesize hud = hud_;

- (void) reset {

}

- (CCSpriteFrame *) getFrameByName: (NSString *)name {
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name];
    return frame;
}

- (id) getSpriteByName: (NSString *)name {
    GameObject *sprite = [GameObject spriteWithSpriteFrame:[self getFrameByName:name]];
    return sprite;
}

- (id) getFixedObjByName: (NSString *)name {
    PipeAndRock *sprite = [PipeAndRock spriteWithSpriteFrame:[self getFrameByName:name]];
    return sprite;
}

- (id) getMoveObjByName: (NSString *)name {
    MoveRectObject *sprite = [MoveRectObject spriteWithSpriteFrame:[self getFrameByName:name]];
    return sprite;
}

- (id) getPlayerByName: (NSString *)name {
    Player * player = [Player spriteWithSpriteFrame:[self getFrameByName:name]];
    return player;
}

- (id) createFrameActionByName:(NSString *)name frameNum:(int)num interval:(float)dt repeat:(int)times {
    NSMutableArray *frame = [NSMutableArray array];
    for (int i = 0; i < num; i++) {
        [frame addObject:[self getFrameByName:[NSString stringWithFormat:name, i+1]]];
    }
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frame delay:dt];
    CCActionInterval *animate = [CCAnimate actionWithAnimation:animation];
    CCAction *repeat = nil;
    if (times <= 0) {
        repeat = [CCRepeatForever actionWithAction:animate];
    }
    else {
        repeat = [CCRepeat actionWithAction:animate times:times];
    }
    return repeat;
}

- (void) setHudLabelScore:(int) score {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    delegate.curScore += score;
    [hud_.score setString:[NSString stringWithFormat:@"%06d", delegate.curScore]];
}

- (void) setHudLabelCoin:(int) coinNum {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    delegate.curCoinNum += coinNum;
    [hud_.coinNum setString:[NSString stringWithFormat:@"x %02d", delegate.curCoinNum]];
}

- (void) showGameInfoScene {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    delegate.marioStatus = player_.marioStatus;
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    
    [delegate loadGameInfoScene];
}

- (id) starMarioRunAnimateOne:(CCAction *)walk1 two:(CCAction *)walk2 three:(CCAction *)walk3 interval:(float)dt {
    return [CCRepeatForever actionWithAction:
             [CCSequence actions:[[walk1 copy] autorelease], 
                                  [CCDelayTime actionWithDuration:dt], 
                                  [[walk2 copy] autorelease], 
                                  [CCDelayTime actionWithDuration:dt], 
                                  [[walk3 copy] autorelease],
                                  [CCDelayTime actionWithDuration:dt], 
                                  nil]];
}

- (void)generateAction {
    
    
    flashMarioL_WalkR1 = [[self createFrameActionByName:@"starl%d_walkr1.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    flashMarioL_WalkR2 = [[self createFrameActionByName:@"starl%d_walkr2.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    flashMarioL_WalkR3 = [[self createFrameActionByName:@"starl%d_walkr3.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    
    flashMarioL_WalkL1 = [[self createFrameActionByName:@"starl%d_walkl1.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    flashMarioL_WalkL2 = [[self createFrameActionByName:@"starl%d_walkl2.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    flashMarioL_WalkL3 = [[self createFrameActionByName:@"starl%d_walkl3.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    
    starMarioL_standR = [[self createFrameActionByName:@"starl%d_standr.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioL_standL = [[self createFrameActionByName:@"starl%d_standl.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioL_jumpR = [[self createFrameActionByName:@"starl%d_jumpr.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioL_jumpL = [[self createFrameActionByName:@"starl%d_jumpl.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioL_stopL = [[self createFrameActionByName:@"starl%d_stopl.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioL_stopR = [[self createFrameActionByName:@"starl%d_stopr.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    
    
    starMarioL_runSlowR = [[self starMarioRunAnimateOne:flashMarioL_WalkR1 
                                                   two:flashMarioL_WalkR2 
                                                 three:flashMarioL_WalkR3 
                                              interval:2.0/60] retain];
    
    starMarioL_runMediumR = [[self starMarioRunAnimateOne:flashMarioL_WalkR1 
                                                     two:flashMarioL_WalkR2 
                                                   three:flashMarioL_WalkR3 
                                                interval:1.0/60] retain];
    
    starMarioL_runFastR = [[self starMarioRunAnimateOne:flashMarioL_WalkR1 
                                                   two:flashMarioL_WalkR2 
                                                 three:flashMarioL_WalkR3 
                                              interval:0] retain];
    
    starMarioL_runSlowL = [[self starMarioRunAnimateOne:flashMarioL_WalkL1 
                                                    two:flashMarioL_WalkL2 
                                                  three:flashMarioL_WalkL3 
                                               interval:2.0/60] retain];
    
    starMarioL_runMediumL = [[self starMarioRunAnimateOne:flashMarioL_WalkL1 
                                                      two:flashMarioL_WalkL2 
                                                    three:flashMarioL_WalkL3 
                                                 interval:1.0/60] retain];
    starMarioL_runFastL = [[self starMarioRunAnimateOne:flashMarioL_WalkL1 
                                                    two:flashMarioL_WalkL2 
                                                  three:flashMarioL_WalkL3 
                                               interval:0] retain];
    
    flashMarioS_WalkR1 = [[self createFrameActionByName:@"stars%d_walkr1.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    flashMarioS_WalkR2 = [[self createFrameActionByName:@"stars%d_walkr2.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    flashMarioS_WalkR3 = [[self createFrameActionByName:@"stars%d_walkr3.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    
    flashMarioS_WalkL1 = [[self createFrameActionByName:@"stars%d_walkl1.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    flashMarioS_WalkL2 = [[self createFrameActionByName:@"stars%d_walkl2.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    flashMarioS_WalkL3 = [[self createFrameActionByName:@"stars%d_walkl3.png" frameNum:3 interval:1.0/60 repeat:1] retain];
    
    starMarioS_standR = [[self createFrameActionByName:@"stars%d_standr.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioS_standL = [[self createFrameActionByName:@"stars%d_standl.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioS_jumpR = [[self createFrameActionByName:@"stars%d_jumpr.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioS_jumpL = [[self createFrameActionByName:@"stars%d_jumpl.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioS_stopL = [[self createFrameActionByName:@"stars%d_stopl.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    starMarioS_stopR = [[self createFrameActionByName:@"stars%d_stopr.png" frameNum:3 interval:1.0/60 repeat:0] retain];
    
    
    starMarioS_runSlowR = [[self starMarioRunAnimateOne:flashMarioS_WalkR1 
                                                    two:flashMarioS_WalkR2 
                                                  three:flashMarioS_WalkR3 
                                               interval:2.0/60] retain];
    
    starMarioS_runMediumR = [[self starMarioRunAnimateOne:flashMarioS_WalkR1 
                                                      two:flashMarioS_WalkR2 
                                                    three:flashMarioS_WalkR3 
                                                 interval:1.0/60] retain];
    
    starMarioS_runFastR = [[self starMarioRunAnimateOne:flashMarioS_WalkR1 
                                                    two:flashMarioS_WalkR2 
                                                  three:flashMarioS_WalkR3 
                                               interval:0] retain];
    
    starMarioS_runSlowL = [[self starMarioRunAnimateOne:flashMarioS_WalkL1 
                                                    two:flashMarioS_WalkL2 
                                                  three:flashMarioS_WalkL3 
                                               interval:2.0/60] retain];
    
    starMarioS_runMediumL = [[self starMarioRunAnimateOne:flashMarioS_WalkL1 
                                                      two:flashMarioS_WalkL2 
                                                    three:flashMarioS_WalkL3 
                                                 interval:1.0/60] retain];
    
    starMarioS_runFastL = [[self starMarioRunAnimateOne:flashMarioS_WalkL1 
                                                    two:flashMarioS_WalkL2 
                                                  three:flashMarioS_WalkL3 
                                               interval:0] retain];
    
    marios_runFastL = [[self createFrameActionByName:@"marios_walkl%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    marios_runFastR = [[self createFrameActionByName:@"marios_walkr%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    marios_runMediumL = [[self createFrameActionByName:@"marios_walkl%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    marios_runMediumR = [[self createFrameActionByName:@"marios_walkr%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    marios_runSlowL = [[self createFrameActionByName:@"marios_walkl%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    marios_runSlowR = [[self createFrameActionByName:@"marios_walkr%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    
    marios_standL = [[self getFrameByName:@"marios_standl.png"] retain];
    marios_standR = [[self getFrameByName:@"marios_standr.png"] retain];
    marios_stopL = [[self getFrameByName:@"marios_stopl.png"] retain];
    marios_stopR = [[self getFrameByName:@"marios_stopr.png"] retain];
    marios_jumpL = [[self getFrameByName:@"marios_jumpl.png"] retain];
    marios_jumpR = [[self getFrameByName:@"marios_jumpr.png"] retain];

    mariom_runFastL = [[self createFrameActionByName:@"mariom_walkl%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    mariom_runFastR = [[self createFrameActionByName:@"mariom_walkr%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    mariom_runMediumL = [[self createFrameActionByName:@"mariom_walkl%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    mariom_runMediumR = [[self createFrameActionByName:@"mariom_walkr%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    mariom_runSlowL = [[self createFrameActionByName:@"mariom_walkl%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    mariom_runSlowR = [[self createFrameActionByName:@"mariom_walkr%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    
    mariom_standL = [[self getFrameByName:@"mariom_standl.png"] retain];
    mariom_standR = [[self getFrameByName:@"mariom_standr.png"] retain];
    mariom_stopL = [[self getFrameByName:@"mariom_stopl.png"] retain];
    mariom_stopR = [[self getFrameByName:@"mariom_stopr.png"] retain];
    mariom_jumpL = [[self getFrameByName:@"mariom_jumpl.png"] retain];
    mariom_jumpR = [[self getFrameByName:@"mariom_jumpr.png"] retain];
    
    mariol_runFastL = [[self createFrameActionByName:@"mariol_walkl%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    mariol_runFastR = [[self createFrameActionByName:@"mariol_walkr%d.png" frameNum:3 interval:0.03 repeat:0] retain];
    mariol_runMediumL = [[self createFrameActionByName:@"mariol_walkl%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    mariol_runMediumR = [[self createFrameActionByName:@"mariol_walkr%d.png" frameNum:3 interval:0.05 repeat:0] retain];
    mariol_runSlowL = [[self createFrameActionByName:@"mariol_walkl%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    mariol_runSlowR = [[self createFrameActionByName:@"mariol_walkr%d.png" frameNum:3 interval:0.08 repeat:0] retain];
    
    mariol_standL = [[self getFrameByName:@"mariol_standl.png"] retain];
    mariol_standR = [[self getFrameByName:@"mariol_standr.png"] retain];
    mariol_stopL = [[self getFrameByName:@"mariol_stopl.png"] retain];
    mariol_stopR = [[self getFrameByName:@"mariol_stopr.png"] retain];
    mariol_jumpL = [[self getFrameByName:@"mariol_jumpl.png"] retain];
    mariol_jumpR = [[self getFrameByName:@"mariol_jumpr.png"] retain];
    
    mariol_fireL = [[self createFrameActionByName:@"mariol_firel%d.png" frameNum:2 interval:0.1 repeat:1] retain];
    mariol_fireR = [[self createFrameActionByName:@"mariol_firer%d.png" frameNum:2 interval:0.1 repeat:1] retain];
    
    ironBrick_ = [[self getFrameByName:@"iron1.png"] retain];
    
    goldBrickFlash_ = [[self createFrameActionByName:@"goldBrick1_%d.png" frameNum:10 interval:0.1 repeat:0] retain];
    flowerFlash_ = [[self createFrameActionByName:@"flower%d.png" frameNum:4 interval:0.1 repeat:0] retain];
    coinUp_ = [[self createFrameActionByName:@"coinUp%d.png" frameNum:4 interval:0.02 repeat:10] retain];
    fireBallRotate_ = [[self createFrameActionByName:@"fireBall%d.png" frameNum:4 interval:0.1 repeat:0] retain];
    fireBallExplode_ = [[self createFrameActionByName:@"fireBallBlow%d.png" frameNum:3 interval:0.1 repeat:1] retain];
    starFlash_ = [[self createFrameActionByName:@"star%d.png" frameNum:4 interval:0.1 repeat:0] retain];
    
    enemy1_walk = [[self createFrameActionByName:@"enemy1_%d.png" frameNum:2 interval:0.2 repeat:0] retain];
}

- (void) setViewPointCenter:(CGPoint)pos {
    int x = MAX(pos.x, winSize.width/2);
    int y = MAX(pos.y, winSize.height/2);
    x = MIN(x, tileMap_.mapSize.width*tileMap_.tileSize.width-winSize.width/2);
    y = MIN(y, tileMap_.mapSize.height*tileMap_.tileSize.height-winSize.height/2);
    CGPoint actualPos = ccp(x, y);
    CGPoint center = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(center, actualPos);
    CGPoint zero = ccp(0, 0);
    zero = [self convertToNodeSpace:zero];
    if (actualPos.x - zero.x < winSize.width/2) {
        return;
    }
    self.position = viewPoint;
}

- (void) drawCollideObject {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    CCTMXObjectGroup *objects = [tileMap_ objectGroupNamed:@"sprite"];
    NSMutableDictionary *objPoint;
    
    float x, y, w, h;
    for (objPoint in [objects objects]) {
        x = [[objPoint valueForKey:@"x"] intValue];
        y = [[objPoint valueForKey:@"y"] intValue];
        w = [[objPoint valueForKey:@"width"] intValue];
        h = [[objPoint valueForKey:@"height"] intValue];
        NSString *objType = [objPoint valueForKey:@"type"];
        CGPoint _point = ccp(x+w/2, y+h/2);
        CGPoint _size = ccp(w, h);
        
        GameObject *sprite = nil;
        BOOL isDynamic;
        
        if (objType && [objType compare:@"hero"] == NSOrderedSame) {
            if (delegate.marioStatus == kMarioSmall) {
                _point = ccp(x, y+10.0);
                player_ = [self getPlayerByName:@"marios_standr.png"];
                player_.position = _point;
                player_.type = kGameObjectPlayer;
                [spriteSheet_ addChild:player_];
                [player_ createPhisicsBody:world_ 
                                   postion:_point 
                                      size:_size 
                                   dynamic:YES 
                                  friction:1 
                                   density:5.6 
                               restitution:0 
                                     boxId:-1];
            }
            else if (delegate.marioStatus == kMarioLarge) {
                player_ = [self getPlayerByName:@"mariom_standr.png"];
                _point = ccp(x+8.0, y+26.0);
                _size = ccp(mariom_standR.originalSize.width-2.0, mariom_standR.originalSize.height);
                player_.position = _point;
                player_.type = kGameObjectPlayer;
                [spriteSheet_ addChild:player_];
                [player_ createPhisicsBody:world_ 
                                   postion:_point 
                                      size:_size 
                                   dynamic:YES 
                                  friction:1 
                                   density:3.8 
                               restitution:0 
                                     boxId:-1];
            }
            else {
                player_ = [self getPlayerByName:@"mariol_standr.png"];
                _point = ccp(x+8.0, y+26.0);
                _size = ccp(mariol_standR.originalSize.width-2.0, mariol_standR.originalSize.height);
                player_.position = _point;
                player_.type = kGameObjectPlayer;
                [spriteSheet_ addChild:player_];
                [player_ createPhisicsBody:world_ 
                                   postion:_point 
                                      size:_size 
                                   dynamic:YES 
                                  friction:1 
                                   density:3.8 
                               restitution:0 
                                     boxId:-1];
            }
        }
        else if (objType && [objType compare:@"ground"] == NSOrderedSame) {
            PipeAndRock *ground = [self getFixedObjByName:@"other.png"];
            ground.position = _point;
            ground.size = _size;
            ground.type = kGameObjectPlatform;
            [spriteSheet_ addChild:ground];
            [ground createPhisicsBody:world_ 
                            postion:_point 
                               size:_size 
                            dynamic:NO 
                           friction:1 
                            density:5.0 
                        restitution:0 
                              boxId:-1];
        }
        else if (objType && 
                 ([objType compare:@"brick"] == NSOrderedSame || 
                  [objType compare:@"multiCoinBrick1"] == NSOrderedSame || 
                  [objType compare:@"starBrick1"] == NSOrderedSame)) {
            sprite = [self getSpriteByName:@"brick1.png"];
            sprite.position = _point;
            isDynamic = NO;
            
             if ([objType compare:@"brick"] == NSOrderedSame) {
                 sprite.type = kGameObjectBrick;
             }
             if ([objType compare:@"multiCoinBrick1"] == NSOrderedSame) {
                 sprite.type = kGameObjectMultiCoinBrick;
             }
             if ([objType compare:@"starBrick1"] == NSOrderedSame) {
                 sprite.type = kGameObjectStarBrick;
             }
            [spriteSheet_ addChild:sprite];
        }
        else if (objType && ([objType compare:@"goldBrick"] == NSOrderedSame)) {
                     
            sprite = [self getSpriteByName:@"goldBrick1_1.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameObjectGoldBrick;
             
            [spriteSheet_ addChild:sprite];
            [sprite runAction:[[goldBrickFlash_ copy] autorelease]];
        }
        else if (objType && [objType compare:@"mushBrick"] == NSOrderedSame) {
            sprite = [self getSpriteByName:@"goldBrick1_1.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameObjectMushBrick;
            [spriteSheet_ addChild:sprite z:2];
            [sprite runAction:[[goldBrickFlash_ copy] autorelease]];
        }
        else if (objType && [objType compare:@"pipe"] == NSOrderedSame) {
            PipeAndRock *pipe = [self getFixedObjByName:@"other.png"];
            pipe.position = _point;
            pipe.type = kGameObjectPipe;
            pipe.size = _size;
            [spriteSheet_ addChild:pipe z:2];
            [pipe createPhisicsBody:world_ 
                            postion:_point 
                               size:_size 
                            dynamic:NO 
                           friction:1 
                            density:0 
                        restitution:0 
                              boxId:-1];
        }
        else if (objType && [objType compare:@"rock"] == NSOrderedSame) {
            PipeAndRock *rock = [self getFixedObjByName:@"other.png"];
            rock.position = _point;
            rock.size = _size;
            rock.type = kGameObjectRock;
            [spriteSheet_ addChild:rock z:1];
            [rock createPhisicsBody:world_ 
                            postion:_point 
                               size:_size 
                            dynamic:NO 
                           friction:1 
                            density:0 
                        restitution:0 
                              boxId:-1];
        }
        else if (objType && [objType compare:@"enemy1"] == NSOrderedSame) {
            MoveRectObject *enemy1 = [self getMoveObjByName:@"enemy1_1.png"];
            enemy1.position = _point;
            enemy1.size = _size;
            enemy1.type = kGameObjectEnemy1;
            enemy1.isMoving = NO;
            [spriteSheet_ addChild:enemy1];
            [enemy1 createPhisicsBody:world_ 
                              postion:_point 
                                 size:_size 
                              dynamic:YES 
                             friction:0 
                              density:0 
                          restitution:0 
                                boxId:-1];
            enemy1.topFixture->SetRestitution(0.5);
            enemy1.bottomFixture->SetRestitution(0);
        }
        
        if (sprite != nil) {
            sprite.size = _size;
            [sprite createPhisicsBody:world_ 
                              postion:_point 
                                 size:_size 
                              dynamic:isDynamic 
                             friction:1
                              density:5.0
                          restitution:0 
                                boxId:-1];
        }
    }
}

- (void) setPhysicsWorld {
    b2Vec2 gravity = b2Vec2(0.0, -30.0);
    world_ = new b2World(gravity);
    world_->SetAllowSleeping(YES);
    world_->SetContinuousPhysics(true);
    contactListener_ = new MarioContactListener();
    world_->SetContactListener(contactListener_);
    m_debugDraw = new GLESDebugDraw(PTM_RATIO);
    world_->SetDebugDraw(m_debugDraw);
    uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    m_debugDraw->SetFlags(flags);
}

//- (void) draw {
//    [super draw];
//    ccGLEnableVertexAttribs(kCCVertexAttrib_Position);
//    kmGLPushMatrix();
//    world_->DrawDebugData();
//    kmGLPopMatrix();
//}

- (void) brickRunPushUpAction: (GameObject *)obj height: (float)height {
    [obj runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.1 position:ccp(0, height)], 
                    [CCMoveTo actionWithDuration:0.1 position:ccp(obj.body->GetPosition().x*PTM_RATIO, 
                                                                  obj.body->GetPosition().y*PTM_RATIO)], 
                    nil]];
}

- (void) destroySprite: (id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    for (CCSprite *obj in self.children) {
        if (obj == sprite) {
            [self removeChild:sprite cleanup:YES];
            return;
        }
    }
    
    for (CCSprite *obj in spriteSheet_.children) {
        if (obj == sprite) {
            [spriteSheet_ removeChild:sprite cleanup:YES];
            return;
        }
    }
    
}

- (void) callBackSpawnScore: (id) sender {
    CCSprite *coin = (CCSprite *)sender;
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:@"200" fontName:@"Marker Felt" fontSize:10];
    scoreLabel.position = ccp(coin.position.x, coin.position.y);
    scoreLabel.color = ccc3(255, 255, 255);
    [self addChild:scoreLabel];
    [scoreLabel runAction:[CCSequence actions:[CCMoveBy actionWithDuration:1.0f position:ccp(0, (25.0/320)*winSize.height)], 
                           [CCCallFuncN actionWithTarget:self selector:@selector(destroySprite:)], nil]];
}

- (void) coinFlyUp:(CCSprite *)coin {
    [coin runAction:[CCSequence actions:
                     [CCMoveBy actionWithDuration:0.3 position:ccp(0, (50.0/320)*winSize.height)], 
                     [CCMoveBy actionWithDuration:0.1 position:ccp(0, -(25.0/320)*winSize.height)], 
                     [CCCallFuncN actionWithTarget:self selector:@selector(destroySprite:)], 
                     [CCCallFuncN actionWithTarget:self selector:@selector(callBackSpawnScore:)], nil]];
    [coin runAction:[[coinUp_ copy] autorelease]];
}

- (void) bounceUpScore:(NSString *)score atPos:(CGPoint)pos {
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:score fontName:@"Marker Felt" fontSize:10];
    scoreLabel.position = pos;
    scoreLabel.color = ccc3(255, 255, 255);
    [self addChild:scoreLabel];
    [scoreLabel runAction:[CCSequence actions:[CCMoveBy actionWithDuration:1.0f position:ccp(0, (25.0/320)*winSize.height)], 
                                              [CCCallFuncN actionWithTarget:self selector:@selector(destroySprite:)], nil]];
}

- (void) objRunDieAction:(GameObject *)obj toPos:(CGPoint)pos jumpHeight:(float)height {
    [obj runAction:[CCSequence actions:[CCJumpTo actionWithDuration:0.6f position:pos height:height jumps:1], 
                                        [CCCallFuncN actionWithTarget:self selector:@selector(destroySprite:)], 
                                        nil]];
}

- (void) destroyBody: (b2Body *)body alsoSprite:(BOOL)value {
    if (body->GetUserData() != NULL && value == YES) {
        GameObject *sprite = (GameObject *) body->GetUserData();
        [spriteSheet_ removeChild:sprite cleanup:YES];
    }
    world_->DestroyBody(body);
}

- (void) smallBrickMoveAfterBigBrick: (GameObject *)obj1 {
    GameObject *smallBrick1 = [self getSpriteByName:@"brick1_s.png"];
    smallBrick1.position = ccp(obj1.position.x-5, obj1.position.y+10);
    
    GameObject *smallBrick2 = [self getSpriteByName:@"brick1_s.png"];
    smallBrick2.position = ccp(obj1.position.x+5, obj1.position.y+10);
    smallBrick2.flipX = YES;
    
    GameObject *smallBrick3 = [self getSpriteByName:@"brick1_s.png"];
    smallBrick3.position = ccp(obj1.position.x-5, obj1.position.y+5);
    smallBrick3.flipY = YES;
    
    GameObject *smallBrick4 = [self getSpriteByName:@"brick1_s.png"];
    smallBrick4.position = ccp(obj1.position.x+5, obj1.position.y+5);
    smallBrick4.flipX = YES;
    smallBrick4.flipY = YES;
    
    [spriteSheet_ addChild:smallBrick1];
    [spriteSheet_ addChild:smallBrick2];
    [spriteSheet_ addChild:smallBrick3];
    [spriteSheet_ addChild:smallBrick4];
    [self objRunDieAction:smallBrick1 toPos:ccp(obj1.position.x-40, -10) jumpHeight:100];
    [self objRunDieAction:smallBrick2 toPos:ccp(obj1.position.x+40, -10) jumpHeight:100];
    [self objRunDieAction:smallBrick3 toPos:ccp(obj1.position.x-20, -10) jumpHeight:70];
    [self objRunDieAction:smallBrick4 toPos:ccp(obj1.position.x+20, -10) jumpHeight:70];
}

- (void) updateOtherObjPosition {
    CGPoint zero = CGPointMake(0, 0);
    CGPoint rightEdge = CGPointMake(winSize.width, 0);
    zero = [self convertToNodeSpace:zero];
    rightEdge = [self convertToNodeSpace:rightEdge];
    
    NSMutableArray *objToDelete = [NSMutableArray array];
    
    for (GameObject *obj in spriteSheet_.children) {
        
        if (obj.type == kGameObjectMushRoom && obj.body != NULL) {
            obj.position = ccp(obj.body->GetPosition().x*PTM_RATIO, 
                               obj.body->GetPosition().y*PTM_RATIO);
        }
        
        if (obj.type == kGameObjectFireBall && obj.body != NULL) {
            obj.position = ccp(obj.body->GetPosition().x*PTM_RATIO,
                               obj.body->GetPosition().y*PTM_RATIO);
                    
            if (obj.position.x > rightEdge.x+obj.contentSize.width/2 || 
                obj.position.x < zero.x-obj.contentSize.width/2 || 
                obj.position.y < zero.y-obj.contentSize.height/2) {
                [objToDelete addObject:obj];
            }
        }
        
        if (obj.type == kGameObjectEnemy1 && obj.body != NULL) {
            MoveRectObject *enemy1 = (MoveRectObject *)obj;
            if (enemy1.position.x - player_.position.x < winSize.width/2+(20.0/480)*winSize.width && 
                enemy1.isMoving == NO) {
                [enemy1 runAction:[[enemy1_walk copy] autorelease]];
                enemy1.body->SetLinearVelocity(b2Vec2(-1.0, 0));
                enemy1.isMoving = YES;
            }
            enemy1.position = ccp(enemy1.body->GetPosition().x*PTM_RATIO, 
                                  enemy1.body->GetPosition().y*PTM_RATIO);
            
            if (enemy1.position.x < zero.x-enemy1.contentSize.width/2 || 
                enemy1.position.y < zero.y-enemy1.contentSize.height/2) {
                [objToDelete addObject:obj];
            }
        }
        
        if (obj.type == kGameObjectStar && obj.body != NULL) {
            obj.position = ccp(obj.body->GetPosition().x*PTM_RATIO, 
                               obj.body->GetPosition().y*PTM_RATIO);
            if (obj.position.x > rightEdge.x+obj.contentSize.width/2 || 
                obj.position.x < zero.x-obj.contentSize.width/2 || 
                obj.position.y < zero.y-obj.contentSize.height/2) {
                [objToDelete addObject:obj];
            }
        }
    }
    
    for (GameObject *obj in objToDelete) {
        if (obj.body != NULL) {
            world_->DestroyBody(obj.body);
            [spriteSheet_ removeChild:obj cleanup:YES];
        }
        [objToDelete removeObject:obj];
    }
}

- (void) generateBodyOfSprite:(id)sender {
    GameObject *obj = (GameObject *)sender;
    
    if (obj.type == kGameObjectMushRoom) {
        [obj createPhisicsBody:world_ 
                       postion:obj.position 
                          size:ccp(obj.contentSize.width, obj.contentSize.height) 
                       dynamic:YES 
                      friction:0 
                       density:0 
                   restitution:0 
                         boxId:-1];
        obj.rightFixture->SetRestitution(1.0);
        obj.leftFixture->SetRestitution(1.0);
        obj.body->SetLinearVelocity(b2Vec2(2.0, 0));
    }
    
    if (obj.type == kGameObjectFlower) {
        [obj createPhisicsBody:world_ 
                       postion:obj.position 
                          size:ccp(obj.contentSize.width, obj.contentSize.height) 
                       dynamic:NO 
                      friction:0 
                       density:5 
                   restitution:0 
                         boxId:-1];
    }
    
    if (obj.type == kGameObjectStar) {
        [obj createPhisicsBody:world_ 
                       postion:obj.position 
                          size:ccp(obj.contentSize.width, obj.contentSize.height) 
                       dynamic:YES 
                      friction:0 
                       density:0 
                   restitution:0 
                         boxId:-1];
        obj.body->SetLinearVelocity(b2Vec2(3.0, 5.0));
    }
}

- (void) coinBrickToIronBrick:(GameObject *)coinB {
    coinB.type = kGameObjectIronBrick;
    [coinB stopAllActions];
    [coinB setDisplayFrame:ironBrick_];
}

- (void) setPlayerUnCollidable {
    player_.isCollidable = NO;
    b2Filter filter;
    filter.categoryBits = 0x0004;
    filter.maskBits = 0x0003;
    filter.groupIndex = 0;

    for (b2Fixture *f = player_.body->GetFixtureList(); f; f = f->GetNext()) {
        f->SetFilterData(filter);
    }
}

- (void) setPlayerCollidable {
    player_.isCollidable = YES;
    b2Filter filter;
    filter.categoryBits = 0x0001;
    filter.maskBits = 0x0003;
    filter.groupIndex = 0;
    
    for (b2Fixture *f = player_.body->GetFixtureList(); f; f = f->GetNext()) {
        f->SetFilterData(filter);
    }
}

- (void) marioGoDie {
    Player *deadMario = [self getPlayerByName:@"marios_die.png"];
    deadMario.position = ccp(player_.position.x, player_.position.y);
    [spriteSheet_ addChild:deadMario];
    [deadMario runAction:[CCSequence actions:[CCJumpTo actionWithDuration:1 
                                                                 position:ccp(player_.position.x, -(16.0/320)*winSize.height) 
                                                                   height:(80.0/320)*winSize.height 
                                                                    jumps:1], 
                                             [CCCallFunc actionWithTarget:self 
                                                                 selector:@selector(showGameInfoScene)], 
                                             nil]];
}

- (void) enemyGoDie:(GameObject *)enemy {
    [enemy setFlipY:YES];
    [self objRunDieAction:enemy 
                    toPos:ccp(enemy.position.x, -(16.0/320)*winSize.height) 
               jumpHeight:(80.0/320)*winSize.height];
}

- (void) updateCollision {
    
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    vector<b2Body *>toDestroy;
    vector<MyContact>::iterator pos;
    BOOL marioWillLarger = NO;
    BOOL marioWillSmaller = NO;
    int marioCollideEnemyTimes = 0;
    int fireBallCollisionTimes = 0;
    int marioCollideStarTimes = 0;
    int marioCollideFlowerTimes = 0;
    
    for (b2ContactEdge *ce = player_.body->GetContactList(); ce; ce = ce->next) {
        if (ce->contact->GetFixtureA() != player_.leftFixture && 
            ce->contact->GetFixtureA() != player_.rightFixture && 
            ce->contact->GetFixtureB() != player_.leftFixture && 
            ce->contact->GetFixtureB() != player_.rightFixture) {
            player_.isFaceWall = NO;
        }
    }
    
    int onGround = 0;
    for (pos = contactListener_->contacts_.begin(); 
         pos != contactListener_->contacts_.end(); 
         ++pos) {
        MyContact contact = *pos;
        
        b2Body *body1 = contact.fixtureA->GetBody();
        b2Body *body2 = contact.fixtureB->GetBody();
        
        GameObject *obj1 = (GameObject *)body1->GetUserData();
        GameObject *obj2 = (GameObject *)body2->GetUserData();
        
        //判断Mario是否站在地上或其他物体上,上升的过程中碰到底边时仍旧在跳跃的过程中
        if ((contact.fixtureA == player_.bottomFixture) || 
            (contact.fixtureB == player_.bottomFixture) || 
            (contact.fixtureA == player_.polygonFixture && 
             contact.fixtureB == obj2.topFixture && player_.body->GetLinearVelocity().y <= 0) || 
            (contact.fixtureB == player_.polygonFixture && 
             contact.fixtureA == obj1.topFixture && player_.body->GetLinearVelocity().y <= 0)) {
            player_.isJump = NO;
            pushUpTimes_ = 0;
            onGround++;
        }
        
        //判断Mario是否被阻挡
        if (contact.fixtureA == player_.leftFixture || 
            contact.fixtureA == player_.rightFixture || 
            contact.fixtureB == player_.leftFixture ||
            contact.fixtureB == player_.rightFixture) {
            
            player_.isFaceWall = YES;

        }
        
        //判断Mario是否跳起并碰撞到其他物体
        if ((contact.fixtureA == player_.topRightFixture || 
             contact.fixtureA == player_.topLeftFixture || 
             contact.fixtureB == player_.topLeftFixture || 
             contact.fixtureB == player_.topRightFixture) && player_.isJump == YES) {
            player_.body->SetLinearVelocity(b2Vec2(0, player_.body->GetLinearVelocity().y));
        }
        
        //判断Mario是否和蘑菇碰撞
        if (IS_PLAYER(obj1, obj2) && IS_MUSHROOM(obj1, obj2)) {
            if (player_.marioStatus == kMarioSmall) {

                if (obj1.type == kGameObjectPlayer) {
                    if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                        toDestroy.push_back(body2);
                    }
                    marioWillLarger = YES;

                }
                if (obj2.type == kGameObjectPlayer) {
                    if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                        toDestroy.push_back(body1);
                    }
                    marioWillLarger = YES;

                }
                [self bounceUpScore:@"1000" atPos:ccp(player_.position.x, 
                                                      player_.position.y+(32.0/320)*winSize.height)];
                [self setHudLabelScore:1000];
                player_.marioStatus = kMarioLarge;
            }
        }
        
        //判断Mario是否和花相撞
        if (IS_PLAYER(obj1, obj2) && IS_FLOWER(obj1, obj2) && marioCollideFlowerTimes == 0) {
            
            if (player_.marioStatus == kMarioSmall) {
                if (obj1.type == kGameObjectPlayer) {
                    if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                        toDestroy.push_back(body2);
                    }
                    marioWillLarger = YES;
                    
                }
                if (obj2.type == kGameObjectPlayer) {
                    if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                        toDestroy.push_back(body1);
                    }
                    marioWillLarger = YES;
                    
                }
                player_.marioStatus = kMarioLarge;
            }
            if (player_.marioStatus == kMarioLarge) {
                
                [player_ setDisplayFrame:mariol_standR];
                player_.marioStatus = kMarioCanFire;
                
                if (obj1.type == kGameObjectPlayer) {
                    if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                        toDestroy.push_back(body2);
                    }
                }
                if (obj2.type == kGameObjectPlayer) {
                    if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                        toDestroy.push_back(body1);
                    }                   
                }
            }
            if (player_.marioStatus == kMarioCanFire) {
                if (obj1.type == kGameObjectPlayer) {
                    if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                        toDestroy.push_back(body2);
                    }                    
                }
                if (obj2.type == kGameObjectPlayer) {
                    if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                        toDestroy.push_back(body1);
                    }
                }
            }
            [self bounceUpScore:@"1000" atPos:ccp(player_.position.x, 
                                                  player_.position.y+(32.0/320)*winSize.height)];
            [self setHudLabelScore:1000];
            marioCollideFlowerTimes++;
        }
        
        //判断火球是否和敌人碰撞
        if (IS_FIREBALL(obj1, obj2) && IS_ENEMY1(obj1, obj2) && fireBallCollisionTimes == 0) {
            if (obj1.type == kGameObjectFireBall) {
                if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                    toDestroy.push_back(body1);
                }
                MoveRectObject *fireBall = [self getMoveObjByName:@"fireBallBlow1.png"];
                fireBall.position = ccp(obj1.position.x, obj1.position.y);
                [spriteSheet_ addChild:fireBall];
                [fireBall runAction:[CCSequence actions:[[fireBallExplode_ copy] autorelease], 
                                     [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(destroySprite:)], 
                                     nil]];
                
                if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                    toDestroy.push_back(body2);
                }
                MoveRectObject *deadEnemy = nil;
                
                switch (obj2.type) {
                    case kGameObjectEnemy1:
                        deadEnemy = [self getMoveObjByName:@"enemy1_1.png"];
                        break;
                    case kGameObjectEnemy2:
                        deadEnemy = [self getMoveObjByName:@"enemy2_s1.png"];
                        break;
                    default:
                        break;
                }
                deadEnemy.position = ccp(obj2.position.x, obj2.position.y);
                [spriteSheet_ addChild:deadEnemy];
                
                [self enemyGoDie:deadEnemy];
                [self bounceUpScore:@"200" 
                              atPos:ccp(obj2.position.x, obj2.position.y+(32.0/320)*winSize.height)];
                [self setHudLabelScore:200];
            }
            
            if (obj2.type == kGameObjectFireBall) {
                if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                    toDestroy.push_back(body2);
                }
                MoveRectObject *fireBall = [self getMoveObjByName:@"fireBallBlow1.png"];
                fireBall.position = ccp(obj2.position.x, obj2.position.y);
                [spriteSheet_ addChild:fireBall];
                [fireBall runAction:[CCSequence actions:[[fireBallExplode_ copy] autorelease], 
                                     [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(destroySprite:)], 
                                     nil]];
                
                if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                    toDestroy.push_back(body1);
                }
                MoveRectObject *deadEnemy = nil;
                
                switch (obj1.type) {
                    case kGameObjectEnemy1:
                        deadEnemy = [self getMoveObjByName:@"enemy1_1.png"];
                        break;
                    case kGameObjectEnemy2:
                        deadEnemy = [self getMoveObjByName:@"enemy2_s1.png"];
                        break;
                    default:
                        break;
                }
                deadEnemy.position = ccp(obj1.position.x, obj1.position.y);
                [spriteSheet_ addChild:deadEnemy];
                
                [self enemyGoDie:deadEnemy];
                [self bounceUpScore:@"200" 
                              atPos:ccp(obj1.position.x, obj1.position.y+(32.0/320)*winSize.height)];
                [self setHudLabelScore:200];
            }
            
            fireBallCollisionTimes++;
        }
        
        //判断火球是否碰撞
        if (IS_FIREBALL(obj1, obj2)) {
            if (obj1.type == kGameObjectFireBall) { 
                if(obj1.leftFixture == contact.fixtureA || 
                   obj1.rightFixture == contact.fixtureA || 
                   obj1.topFixture == contact.fixtureA) {
                    if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                        toDestroy.push_back(body1);
                    }
                    MoveRectObject *fireBall = [self getMoveObjByName:@"fireBallBlow1.png"];
                    fireBall.position = ccp(obj1.position.x, obj1.position.y);
                    [spriteSheet_ addChild:fireBall];
                    [fireBall runAction:[CCSequence actions:[[fireBallExplode_ copy] autorelease], 
                                                            [CCCallFuncN actionWithTarget:self 
                                                                                 selector:@selector(destroySprite:)], 
                                                            nil]];
                }
                if (obj1.bottomFixture == contact.fixtureA) {
                    if (obj1.body->GetLinearVelocity().x > 0) {
                        obj1.body->SetLinearVelocity(b2Vec2(8.0, 5.5));
                    }
                    else {
                        obj1.body->SetLinearVelocity(b2Vec2(-8.0, 5.5));
                    }
                }
                

            }
            if (obj2.type == kGameObjectFireBall) { 
                if(obj2.leftFixture == contact.fixtureB || 
                   obj2.rightFixture == contact.fixtureB || 
                   obj2.topFixture == contact.fixtureB) {
                    if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                        toDestroy.push_back(body2);
                    }
                    MoveRectObject *fireBall = [self getMoveObjByName:@"fireBallBlow1.png"];
                    fireBall.position = ccp(obj2.position.x, obj2.position.y);
                    [spriteSheet_ addChild:fireBall];
                    [fireBall runAction:[CCSequence actions:[[fireBallExplode_ copy] autorelease], 
                                                             [CCCallFuncN actionWithTarget:self 
                                                                                  selector:@selector(destroySprite:)], 
                                                             nil]];
                }
                if (obj2.bottomFixture == contact.fixtureB) {
                    if (obj2.body->GetLinearVelocity().x > 0) {
                        obj2.body->SetLinearVelocity(b2Vec2(8.0, 6.5));
                    }
                    else {
                        obj2.body->SetLinearVelocity(b2Vec2(-8.0, 6.5));
                    }
                }

            }
            
        }
        
        //判断敌人的左右边是否撞到障碍物，改变速度方向
        if (IS_ENEMY1(obj1, obj2)) {
            if (obj1.type == kGameObjectEnemy1) {
                if (obj1.rightFixture == contact.fixtureA) {
                    obj1.body->SetLinearVelocity(b2Vec2(-1, 0));
                }
                if (obj1.leftFixture == contact.fixtureA) {
                    obj1.body->SetLinearVelocity(b2Vec2(1, 0));
                }
            }
            
            if (obj2.type == kGameObjectEnemy1) {
                if (obj2.rightFixture == contact.fixtureB) {
                    obj2.body->SetLinearVelocity(b2Vec2(-1, 0));
                }
                if (obj2.leftFixture == contact.fixtureB) {
                    obj2.body->SetLinearVelocity(b2Vec2(1, 0));
                }
            }
        }
        
        //Mario和enemy1碰撞检测
        if (IS_ENEMY1(obj1, obj2) && IS_PLAYER(obj1, obj2)) {
            if (obj1.type == kGameObjectPlayer) {
                
                if (marioCollideEnemyTimes == 0) {
                    CCLOG(@"<==The distance between player and enemy is : %f ==>", obj1.position.y-obj2.position.y);
                    
                    if (player_.isInvincible == YES) {
                        if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                            toDestroy.push_back(body2);
                        }
                        MoveRectObject *deadEnemy = nil;
                        
                        switch (obj2.type) {
                            case kGameObjectEnemy1:
                                deadEnemy = [self getMoveObjByName:@"enemy1_1.png"];
                                break;
                            case kGameObjectEnemy2:
                                deadEnemy = [self getMoveObjByName:@"enemy2_s1.png"];
                                break;
                            default:
                                break;
                        }
                        deadEnemy.position = ccp(obj2.position.x, obj2.position.y);
                        [spriteSheet_ addChild:deadEnemy];
                        
                        [self enemyGoDie:deadEnemy];
                        [self bounceUpScore:@"200" 
                                      atPos:ccp(obj2.position.x, obj2.position.y+(32.0/320)*winSize.height)];
                        [self setHudLabelScore:200];
                    }
                    else {
                        if (obj1.position.y-obj2.position.y <= obj1.contentSize.height/2+obj2.contentSize.height/2+0.5 && 
                            obj1.position.y-obj2.position.y >= obj1.contentSize.height/2+obj2.contentSize.height/2-4.5) {
                            if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                                toDestroy.push_back(body2);
                            }
                            MoveRectObject *deadEnemy1 = [self getMoveObjByName:@"enemy1_die.png"];
                            deadEnemy1.position = ccp(obj2.position.x, 
                                                      obj2.position.y-(obj2.contentSize.height/2-deadEnemy1.contentSize.height/2));
                            [spriteSheet_ addChild:deadEnemy1];
                            [deadEnemy1 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], 
                                                   [CCCallFuncN actionWithTarget:self 
                                                                        selector:@selector(destroySprite:)], 
                                                   nil]];
                            obj1.body->SetLinearVelocity(b2Vec2(obj1.body->GetLinearVelocity().x, 5.0));
                            [self bounceUpScore:@"100" atPos:ccp(deadEnemy1.position.x, 
                                                                 deadEnemy1.position.y+(32.0/320)*winSize.height)];
                            [self setHudLabelScore:100];
                            
                        }
                        else {                        
                            if (player_.marioStatus == kMarioSmall) {
                                [self pauseSchedulerAndActions];
                                [player_ setVisible:NO];
                                delegate.curLives--;
                                [self marioGoDie];
                            }
                            if (player_.marioStatus == kMarioLarge || player_.marioStatus == kMarioCanFire) {
                                marioWillSmaller = YES;
                                player_.marioStatus = kMarioSmall;
                            }
                            
                        }
                    }
                    marioCollideEnemyTimes++;
                }
            }
            
            if (obj2.type == kGameObjectPlayer) {
                if (marioCollideEnemyTimes == 0) {
                    CCLOG(@"<==The distance between player and enemy is : %f ==>", obj2.position.y-obj1.position.y);
                    
                    if (player_.isInvincible == YES) {
                        if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                            toDestroy.push_back(body1);
                        }
                        MoveRectObject *deadEnemy = nil;
                        
                        switch (obj1.type) {
                            case kGameObjectEnemy1:
                                deadEnemy = [self getMoveObjByName:@"enemy1_1.png"];
                                break;
                            case kGameObjectEnemy2:
                                deadEnemy = [self getMoveObjByName:@"enemy2_s1.png"];
                                break;
                            default:
                                break;
                        }
                        deadEnemy.position = ccp(obj1.position.x, obj1.position.y);
                        [spriteSheet_ addChild:deadEnemy];
                        
                        [self enemyGoDie:deadEnemy];
                        [self bounceUpScore:@"200" 
                                      atPos:ccp(obj1.position.x, obj1.position.y+(32.0/320)*winSize.height)];
                        [self setHudLabelScore:200];
                    }
                    else {
                        if (obj2.position.y-obj1.position.y <= obj1.contentSize.height/2+obj2.contentSize.height/2+0.5 && 
                            obj2.position.y-obj1.position.y >= obj1.contentSize.height/2+obj2.contentSize.height/2-4.5) {
                            if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                                toDestroy.push_back(body1);
                            }
                            MoveRectObject *deadEnemy1 = [self getMoveObjByName:@"enemy1_die.png"];
                            deadEnemy1.position = ccp(obj1.position.x, 
                                                      obj1.position.y-(obj1.contentSize.height/2-deadEnemy1.contentSize.height/2));
                            [spriteSheet_ addChild:deadEnemy1];
                            [deadEnemy1 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], 
                                                   [CCCallFuncN actionWithTarget:self 
                                                                        selector:@selector(destroySprite:)], 
                                                   nil]];
                            obj2.body->SetLinearVelocity(b2Vec2(obj2.body->GetLinearVelocity().x, 5.0));
                            [self bounceUpScore:@"100" atPos:ccp(deadEnemy1.position.x, 
                                                                 deadEnemy1.position.y+(32.0/320)*winSize.height)];
                            [self setHudLabelScore:100];
                            
                        }
                        else {                        
                            if (player_.marioStatus == kMarioSmall) {
                                [player_ setVisible:NO];
                                delegate.curLives--;
                                [self marioGoDie];
                            }
                            if (player_.marioStatus == kMarioLarge || player_.marioStatus == kMarioCanFire) {
                                marioWillSmaller = YES;
                                player_.isCollidable = NO;
                                player_.marioStatus = kMarioSmall;
                            }
                        }
                    }
                    marioCollideEnemyTimes++;
                }
            }
        }
        
        //star碰撞
        if (IS_STAR(obj1, obj2)) {
            if (obj1.type == kGameObjectStar) {
                if (contact.fixtureA == obj1.bottomFixture) {
                    obj1.body->SetLinearVelocity(b2Vec2(3.5, 8.0));
                }
                if (contact.fixtureA == obj1.leftFixture) {
                    obj1.body->SetLinearVelocity(b2Vec2(3.5, obj1.body->GetLinearVelocity().y));
                }
                if (contact.fixtureA == obj1.rightFixture) {
                    obj1.body->SetLinearVelocity(b2Vec2(-3.5, obj1.body->GetLinearVelocity().y));
                }
                
                if (obj2.type == kGameObjectPlayer && marioCollideStarTimes == 0) {
                    Player *mario = (Player *)obj2;
                    if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                        toDestroy.push_back(body1);
                    }
                    mario.isInvincible = YES;
                    starMarioStart_ = [[NSDate date] retain];
                    
                    marioCollideStarTimes++;
                }
            }
            
            if (obj2.type == kGameObjectStar) {
                if (contact.fixtureB == obj2.bottomFixture) {
                    obj2.body->SetLinearVelocity(b2Vec2(3.5, 8.0));
                }
                if (contact.fixtureB == obj2.leftFixture) {
                    obj2.body->SetLinearVelocity(b2Vec2(3.5, obj2.body->GetLinearVelocity().y));
                }
                if (contact.fixtureB == obj2.rightFixture) {
                    obj2.body->SetLinearVelocity(b2Vec2(-3.5, obj2.body->GetLinearVelocity().y));
                }
                
                if (obj1.type == kGameObjectPlayer && marioCollideStarTimes == 0) {
                    Player *mario = (Player *)obj1;
                    if (find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                        toDestroy.push_back(body2);
                    }
                    mario.isInvincible = YES;
                    starMarioStart_ = [[NSDate date] retain];
                    
                    marioCollideStarTimes++;
                }
            }
        }
        
        //判断Mario是否跳起和砖块们碰撞
        if (pushUpTimes_ == 0) {
            if (obj1.type == kGameObjectBrick && 
                obj1.bottomFixture == contact.fixtureA && 
                obj1.position.y-obj1.contentSize.height/2 >= obj2.position.y+obj2.contentSize.height/2 && //防止M侧面碰到砖块底部时
                obj2.type == kGameObjectPlayer) {                                                         //也会使砖块碎掉
                if (player_.marioStatus == kMarioSmall) {
                    [self brickRunPushUpAction:obj1 height:(10.0/320)*winSize.height];
                    
                }
                else {
                    if (find(toDestroy.begin(), toDestroy.end(), body1) == toDestroy.end()) {
                        toDestroy.push_back(body1);
                    }
                    [self brickRunPushUpAction:obj1 height:(10.0/320)*winSize.height];
                    [self smallBrickMoveAfterBigBrick:obj1];
                }
                pushUpTimes_++;
            }
            
            else if (obj2.type == kGameObjectBrick && 
                     obj2.bottomFixture == contact.fixtureB && 
                     obj2.position.y-obj2.contentSize.height/2 >= obj1.position.y+obj1.contentSize.height/2 && 
                     obj1.type == kGameObjectPlayer) {
                if (player_.marioStatus == kMarioSmall) {
                    [self brickRunPushUpAction:obj2 height:(10.0/320)*winSize.height];
                    
                }
                else {
                    if (std::find(toDestroy.begin(), toDestroy.end(), body2) == toDestroy.end()) {
                        toDestroy.push_back(body2);
                    }
                    [self brickRunPushUpAction:obj2 height:(10.0/320)*winSize.height];
                    [self smallBrickMoveAfterBigBrick:obj2];
                }
                pushUpTimes_++;
            }
            
            else if (obj1.type == kGameObjectGoldBrick && 
                     obj1.bottomFixture == contact.fixtureA && 
                     obj1.position.y-obj1.contentSize.height/2 >= obj2.position.y+obj2.contentSize.height/2 && 
                     obj2.type == kGameObjectPlayer) {
                
                [self coinBrickToIronBrick:obj1];
                [self brickRunPushUpAction:obj1 height:(10.0/320)*winSize.height];
                CCSprite *coin = [self getSpriteByName:@"coinUp1.png"];
                coin.position = ccp(obj1.position.x, obj1.position.y+obj1.contentSize.height/2+coin.contentSize.height/2);
                [spriteSheet_ addChild:coin z:1];
                [self coinFlyUp:coin];
                
                [self setHudLabelCoin:1];
                [self setHudLabelScore:200];
                pushUpTimes_++;
            }
            
            else if (obj2.type == kGameObjectGoldBrick && 
                     obj2.bottomFixture == contact.fixtureB && 
                     obj2.position.y-obj2.contentSize.height/2 >= obj1.position.y+obj1.contentSize.height/2 && 
                     obj1.type == kGameObjectPlayer) {
                
                [self coinBrickToIronBrick:obj2];
                [self brickRunPushUpAction:obj2 height:(10.0/320)*winSize.height];
                CCSprite *coin = [self getSpriteByName:@"coinUp1.png"];
                coin.position = ccp(obj2.position.x, obj2.position.y+obj2.contentSize.height/2+coin.contentSize.height/2);
                [spriteSheet_ addChild:coin z:1];
                [self coinFlyUp:coin];
                
                [self setHudLabelCoin:1];
                [self setHudLabelScore:200];
                pushUpTimes_++;
            }
            
            else if (obj1.type == kGameObjectMushBrick && 
                     obj1.bottomFixture == contact.fixtureA && 
                     obj1.position.y-obj1.contentSize.height/2 >= obj2.position.y+obj2.contentSize.height/2 && 
                     obj2.type == kGameObjectPlayer) {
                
                [self coinBrickToIronBrick:obj1];
                [self brickRunPushUpAction:obj1 height:(10.0/320)*winSize.height];
                
                if (player_.marioStatus == kMarioSmall) {
                    PipeAndRock *mushRoom = [self getFixedObjByName:@"mushRoom.png"];
                    mushRoom.position = ccp(obj1.position.x, obj1.position.y+(10.0/320)*winSize.height);
                    mushRoom.type = kGameObjectMushRoom;
                    [spriteSheet_ addChild:mushRoom z:1];
                    [mushRoom runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, (8.0/320)*winSize.height)], 
                                                            [CCCallFuncN actionWithTarget:self 
                                                                                 selector:@selector(generateBodyOfSprite:)], 
                                                            nil]];
                    
                }
                else {
                    PipeAndRock *flower = [self getFixedObjByName:@"flower1.png"];
                    flower.position = ccp(obj1.position.x, obj1.position.y+(10.0/320)*winSize.height);
                    flower.type = kGameObjectFlower;
                    [spriteSheet_ addChild:flower z:1];
                    [flower runAction:[[flowerFlash_ copy] autorelease]];
                    [flower runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, (6.0/320)*winSize.height)], 
                                                            [CCCallFuncN actionWithTarget:self 
                                                                                selector:@selector(generateBodyOfSprite:)], 
                                                            nil]];
                    
                }
                pushUpTimes_++;
            }
            
            else if (obj2.type == kGameObjectMushBrick && 
                     obj2.bottomFixture == contact.fixtureA && 
                     obj2.position.y-obj2.contentSize.height/2 >= obj1.position.y+obj1.contentSize.height/2 && 
                     obj1.type == kGameObjectPlayer) {
                
                [self coinBrickToIronBrick:obj2];
                [self brickRunPushUpAction:obj2 height:(10.0/320)*winSize.height];
                
                if (player_.marioStatus == kMarioSmall) {
                    PipeAndRock *mushRoom = [self getFixedObjByName:@"mushRoom.png"];
                    mushRoom.position = ccp(obj2.position.x, obj2.position.y+(10.0/320)*winSize.height);
                    mushRoom.type = kGameObjectMushRoom;
                    [spriteSheet_ addChild:mushRoom z:1];
                    [mushRoom runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, (8.0/320)*winSize.height)], 
                                         [CCCallFuncN actionWithTarget:self 
                                                              selector:@selector(generateBodyOfSprite:)], 
                                         nil]];
                    
                }
                else {
                    PipeAndRock *flower = [self getFixedObjByName:@"flower1.png"];
                    flower.position = ccp(obj2.position.x, obj2.position.y+10);
                    flower.type = kGameObjectFlower;
                    [spriteSheet_ addChild:flower z:1];
                    [flower runAction:[[flowerFlash_ copy] autorelease]];
                    [flower runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, (6.0/320)*winSize.height)], 
                                       [CCCallFuncN actionWithTarget:self 
                                                            selector:@selector(generateBodyOfSprite:)], 
                                       nil]];
                    
                }
                pushUpTimes_++;
            }
            
            else if (obj1.type == kGameObjectMultiCoinBrick && 
                     obj1.bottomFixture == contact.fixtureA && 
                     obj1.position.y-obj1.contentSize.height/2 >= obj2.position.y+obj2.contentSize.height/2 && 
                     obj2.type == kGameObjectPlayer) {
                
                if (multiCoinBrickPushUpTimes_ == 0) {
                    multiCoinBrickStart_ = [[NSDate date] retain];
                }
                double multiPersistentTimeInterval = [[NSDate date] timeIntervalSinceDate:multiCoinBrickStart_];
                
                [self brickRunPushUpAction:obj1 height:(10.0/320)*winSize.height];
                CCSprite *coin = [self getSpriteByName:@"coinUp1.png"];
                coin.position = ccp(obj1.position.x, obj1.position.y+obj1.contentSize.height/2+coin.contentSize.height/2);
                [spriteSheet_ addChild:coin z:1];
                [self coinFlyUp:coin];                
                [self setHudLabelCoin:1];
                [self setHudLabelScore:200];
                
                if (multiPersistentTimeInterval > 4) {
                    [self coinBrickToIronBrick:obj1];
                    multiCoinBrickPushUpTimes_ = 0;
                    [multiCoinBrickStart_ release];
                }
                multiCoinBrickPushUpTimes_++;
                pushUpTimes_++;
            }
            
            else if (obj2.type == kGameObjectMultiCoinBrick && 
                     obj2.bottomFixture == contact.fixtureB && 
                     obj2.position.y-obj2.contentSize.height/2 >= obj1.position.y+obj1.contentSize.height/2 && 
                     obj1.type == kGameObjectPlayer) {
                
                if (multiCoinBrickPushUpTimes_ == 0) {
                    multiCoinBrickStart_ = [[NSDate date] retain];
                }
                double multiPersistentTimeInterval = [[NSDate date] timeIntervalSinceDate:multiCoinBrickStart_];
                
                [self brickRunPushUpAction:obj2 height:(10.0/320)*winSize.height];
                CCSprite *coin = [self getSpriteByName:@"coinUp1.png"];
                coin.position = ccp(obj2.position.x, obj2.position.y+obj2.contentSize.height/2+coin.contentSize.height/2);
                [spriteSheet_ addChild:coin z:1];
                [self coinFlyUp:coin];
                [self setHudLabelCoin:1];
                [self setHudLabelScore:200];
                
                if (multiPersistentTimeInterval > 4) {
                    [self coinBrickToIronBrick:obj2];
                    multiCoinBrickPushUpTimes_ = 0;
                    [multiCoinBrickStart_ release];
                }
                multiCoinBrickPushUpTimes_++;
                pushUpTimes_++;
            }
            
            else if (obj1.type == kGameObjectStarBrick && 
                     obj1.bottomFixture == contact.fixtureA && 
                     obj1.position.y-obj1.contentSize.height/2 >= obj2.position.y+obj2.contentSize.height/2 && 
                     obj2.type == kGameObjectPlayer) {
                
                [self coinBrickToIronBrick:obj1];
                [self brickRunPushUpAction:obj1 height:(10.0/320)*winSize.height];
                MoveRectObject *star = [self getMoveObjByName:@"star1.png"];
                star.position = ccp(obj1.position.x, obj1.position.y+(10.0/320)*winSize.height);
                star.type = kGameObjectStar;
                [spriteSheet_ addChild:star z:1];
                [star runAction:[[starFlash_ copy] autorelease]];
                [star runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, (8.0/320)*winSize.height)], 
                                                     [CCCallFuncN actionWithTarget:self 
                                                                          selector:@selector(generateBodyOfSprite:)], 
                                                     nil]];
                
                pushUpTimes_++;
            }
            
            else if (obj2.type == kGameObjectStarBrick && 
                     obj2.bottomFixture == contact.fixtureB && 
                     obj2.position.y-obj2.contentSize.height/2 >= obj1.position.y+obj1.contentSize.height/2 && 
                     obj1.type == kGameObjectPlayer) {
                
                [self coinBrickToIronBrick:obj2];
                [self brickRunPushUpAction:obj2 height:(10.0/320)*winSize.height];
                MoveRectObject *star = [self getMoveObjByName:@"star1.png"];
                star.position = ccp(obj2.position.x, obj2.position.y+(10.0/320)*winSize.height);
                star.type = kGameObjectStar;
                [spriteSheet_ addChild:star z:1];
                [star runAction:[[starFlash_ copy] autorelease]];
                [star runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0, (8.0/320)*winSize.height)], 
                                 [CCCallFuncN actionWithTarget:self 
                                                      selector:@selector(generateBodyOfSprite:)], 
                                 nil]];
                
                pushUpTimes_++;
            }
        }
        
    }
    if (onGround == 0) {
        player_.isJump = YES;
        [self playerStopAllMoveAction];
        
        if (player_.isInvincible) {
            
        }
        
        player_.isMarioStop = NO;
        faceWallTimes_ = 0;
    }
    
    //mario贴墙的时候，方便处理动画
    if (player_.stkHead == kStickHeadingZero) {
        player_.isFaceWall = NO;
    }
    
    if (marioWillLarger) {
        CGPoint _pos = ccp(player_.position.x, player_.position.y);
        
        [player_ resizeBodyAtPositon:ccp(_pos.x, _pos.y+(8.0/320)*winSize.height) 
                                size:ccp(mariom_standR.originalSize.width-2.0, mariom_standR.originalSize.height) 
                            friction:1.0 
                             density:3.8 
                         restitution:0];
        [player_ setDisplayFrame:mariom_standR];
    }
    
    if (marioWillSmaller) {
        CGPoint _pos = ccp(player_.position.x, player_.position.y);
        [player_ resizeBodyAtPositon:_pos 
                                size:ccp(marios_standR.originalSize.width-2.0, marios_standR.originalSize.height) 
                            friction:1.0 
                             density:5.6 
                         restitution:0];
        [player_ setDisplayFrame:marios_standR];
        [player_ runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(setPlayerUnCollidable)], 
                                                [CCFadeTo actionWithDuration:0.01 opacity:100], 
                                                [CCDelayTime actionWithDuration:3.0],
                                                [CCFadeTo actionWithDuration:0.01 opacity:255], 
                                                [CCCallFunc actionWithTarget:self selector:@selector(setPlayerCollidable)], 
                                                nil]];
    }
    
    vector<b2Body *>::iterator pos1;
    for (pos1 = toDestroy.begin(); pos1 != toDestroy.end(); ++pos1) {
        b2Body *body = *pos1;
        if (body->GetUserData() != NULL) {
            GameObject *sprite = (GameObject *) body->GetUserData();
            if (sprite != NULL) {
                for (GameObject *obj in self.children) {
                    if (obj == sprite) {
                        [self removeChild:sprite cleanup:YES];
                        break;
                    }
                }
                for (GameObject *obj in spriteSheet_.children) {
                    if (obj == sprite) {
                        [spriteSheet_ removeChild:sprite cleanup:YES];
                        break;
                    }
                }
            }
        }
        world_->DestroyBody(body);
    }
}

- (void) playerRunAction:(CCAction *)action1 second:(CCAction *)action2 third:(CCAction *)action3 tag:(int)tag {
    if (player_.marioStatus == kMarioSmall) {
        CCAction *tmpAction = [[action1 copy] autorelease];
        tmpAction.tag = tag;
        [player_ runAction:tmpAction];
    }
    else if (player_.marioStatus == kMarioLarge) {
        CCAction *tmpAction = [[action2 copy] autorelease];
        tmpAction.tag = tag;
        [player_ runAction:tmpAction];
    }
    else {
        CCAction *tmpAction = [[action3 copy] autorelease];
        tmpAction.tag = tag;
        [player_ runAction:tmpAction];
    }
}

- (void) playerSetActionFrameOne:(CCSpriteFrame *)frame1 two:(CCSpriteFrame *)frame2 three:(CCSpriteFrame *)frame3 {
    if (player_.marioStatus == kMarioSmall) {
        [player_ setDisplayFrame:frame1];
    }
    else if (player_.marioStatus == kMarioLarge) {
        [player_ setDisplayFrame:frame2];
    }
    else {
        [player_ setDisplayFrame:frame3];
    }
}

- (void) playerStopAllMoveAction {
    while ([player_ getActionByTag:MARIO_RUNACTION_TAG]) {
        [player_ stopActionByTag:MARIO_RUNACTION_TAG];
    }
    while ([player_ getActionByTag:STARMARIO_STOPACTION_TAG]) {
        [player_ stopActionByTag:STARMARIO_STOPACTION_TAG];
    }
    while ([player_ getActionByTag:STARMARIO_STANDACTION_TAG]) {
        [player_ stopActionByTag:STARMARIO_STANDACTION_TAG];
    }
    while ([player_ getActionByTag:STARMARIO_JUMPACTION_TAG]) {
        [player_ stopActionByTag:STARMARIO_JUMPACTION_TAG];
    }
}

- (void) checkoutJump:(ccTime) dt {
    if (player_.isJump == NO) {
        if (hud_.btnB.active == YES) {
            totalPressTime_ += dt;
            player_.readyToJump = YES;
            if (totalPressTime_ > 0.1) {
                totalPressTime_ = 0.1;
                player_.body->ApplyLinearImpulse(b2Vec2(0, (300.0+2000*totalPressTime_)/PTM_RATIO), 
                                                 player_.body->GetWorldCenter());
                [self playerStopAllMoveAction];
                
                if (player_.isMarioMovingRight) {
                    
                    if (player_.isInvincible == NO) {
                        [self playerSetActionFrameOne:marios_jumpR two:mariom_jumpR three:mariol_jumpR];
                    }
                    else {
                        [self playerRunAction:starMarioS_jumpR second:starMarioL_jumpR third:starMarioL_jumpR tag:STARMARIO_JUMPACTION_TAG];
                    }
                }
                else {
                    
                    if (player_.isInvincible == NO) {
                        [self playerSetActionFrameOne:marios_jumpL two:mariom_jumpL three:mariol_jumpL];
                    }
                    else {
                        [self playerRunAction:starMarioS_jumpL second:starMarioL_jumpL third:starMarioL_jumpL tag:STARMARIO_JUMPACTION_TAG];
                    }
                }
                totalPressTime_ = 0;
                player_.readyToJump = NO;
            }
        }
        else if (player_.readyToJump) {
            player_.body->ApplyLinearImpulse(b2Vec2(0, (300+2000*(totalPressTime_))/PTM_RATIO), 
                                             player_.body->GetWorldCenter());
            [self playerStopAllMoveAction];
            
            if (player_.isMarioMovingRight) {
                
                if (player_.isInvincible == NO) {
                    [self playerSetActionFrameOne:marios_jumpR two:mariom_jumpR three:mariol_jumpR];
                }
                else {
                    [self playerRunAction:starMarioS_jumpR second:starMarioL_jumpR third:starMarioL_jumpR tag:STARMARIO_JUMPACTION_TAG];
                }
            }
            else {
                
                if (player_.isInvincible == NO) {
                    [self playerSetActionFrameOne:marios_jumpL two:mariom_jumpL three:mariol_jumpL];
                }
                else {
                    [self playerRunAction:starMarioS_jumpL second:starMarioL_jumpL third:starMarioL_jumpL tag:STARMARIO_JUMPACTION_TAG];
                }
            }
            player_.readyToJump = NO;
            totalPressTime_ = 0;
        }
    }
}

- (void) updateWorldStep:(ccTime)dt {
    int32 velocityIterations = 8;
    int32 positionIterations = 3;
    world_->Step(dt, velocityIterations, positionIterations);
}

- (void) stopFire {
    player_.isFireing = NO;
}

- (void) updatePlayerFire:(ccTime)dt {
    if (player_.marioStatus == kMarioCanFire) {
        if (hud_.btnA.active == YES) {
            totalPressTimeA_ += dt;
            if (totalPressTimeA_ > fireDelta_) {
                fireDelta_ += 0.5;
                player_.isFireing = YES;
                if (player_.isJump == NO) {                    
                    if (player_.isMarioMovingRight == YES) {
                        [player_ runAction:[CCSequence actions:[[mariol_fireR copy] autorelease], 
                                                               [CCCallFunc actionWithTarget:self 
                                                                                   selector:@selector(stopFire)], 
                                                                nil]];
                    }
                    else {
                        [player_ runAction:[CCSequence actions:[[mariol_fireL copy] autorelease], 
                                                                [CCCallFunc actionWithTarget:self 
                                                                                    selector:@selector(stopFire)], 
                                                                nil]];
                    }
                }
                else {
                    [self stopFire];
                }
                
                MoveRectObject *fireBall = [self getMoveObjByName:@"fireBall1.png"];
                fireBall.type = kGameObjectFireBall;
                if (player_.isMarioMovingRight) {
                    fireBall.position = ccp(player_.position.x+(15.0/480)*winSize.width, 
                                            player_.position.y);
                }
                else {
                    fireBall.position = ccp(player_.position.x-(15.0/480)*winSize.width, 
                                            player_.position.y);
                }
                [spriteSheet_ addChild:fireBall];
                [fireBall runAction:[[fireBallRotate_ copy] autorelease]];
                [fireBall createPhisicsBody:world_ 
                                    postion:fireBall.position 
                                       size:ccp(fireBall.contentSize.width, fireBall.contentSize.height) 
                                    dynamic:YES 
                                   friction:0 
                                    density:0 
                                restitution:1 
                                      boxId:-1];
                if (player_.isMarioMovingRight) {
                    fireBall.body->ApplyLinearImpulse(b2Vec2(250.0/PTM_RATIO, -80.0/PTM_RATIO), 
                                                      fireBall.body->GetWorldCenter());
                }
                else {
                    fireBall.body->ApplyLinearImpulse(b2Vec2(-250.0/PTM_RATIO, -80.0/PTM_RATIO), 
                                                      fireBall.body->GetWorldCenter());
                }
            }
        }
        if (hud_.btnA.active == NO) {
            fireDelta_ = 0;
            totalPressTimeA_ = 0;
        }
    }
}

- (void) updatePlayerPositon:(ccTime)dt {
    
    CGPoint stkPos = hud_.stick.stickPosition;
    
    double starMarioPersistence = 0;
    if (starMarioStart_) {
        starMarioPersistence = [[NSDate date] timeIntervalSinceDate:starMarioStart_];
    }
    
    if (starMarioPersistence > 10) {
        player_.isInvincible = NO;
        [starMarioStart_ release];
        starMarioStart_ = nil;
    }
    
    if (player_.isJump) {
        player_.isMoveFast = NO;
    }
    
    if (stkPos.x > 0 && abs(stkPos.x) > abs(stkPos.y)) {
        player_.stkHead = kStickHeadingRight;
    }
    if (stkPos.x < 0 && abs(stkPos.x) > abs(stkPos.y)) {
        player_.stkHead = kStickHeadingLeft;
    }
    if (stkPos.y < 0 && abs(stkPos.y) > abs(stkPos.x)) {
        player_.stkHead = kStickHeadingDown;
    }
    if (stkPos.y > 0 && abs(stkPos.y) > abs(stkPos.x)) {
        player_.stkHead = kStickHeadingUp;
    }
    if (stkPos.x == 0 && stkPos.y == 0) {
        player_.stkHead = kStickHeadingZero;
    }
    
    if (player_.stkHead == kStickHeadingRight && player_.isJump == NO) {
        
        if (player_.isFaceWall && faceWallTimes_ == 0) {
            
            [self playerStopAllMoveAction];
            if (player_.isInvincible == NO) {
                [self playerRunAction:marios_runSlowR second:mariom_runSlowR third:mariol_runSlowR tag:MARIO_RUNACTION_TAG];
            }
            else {
                [self playerRunAction:starMarioS_runSlowR second:starMarioL_runSlowR third:starMarioL_runSlowR tag:MARIO_RUNACTION_TAG];
            }
            faceWallTimes_++;
        }
        
        if (hud_.btnA.active == YES) {
            player_.body->ApplyForceToCenter(b2Vec2((2000)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if ((player_.isMarioStop == YES || player_.isMarioMovingRight == NO) && 
                player_.isFaceWall == NO) {
                
                [self playerStopAllMoveAction];
                if (player_.isInvincible == NO) {
                    [self playerRunAction:marios_runFastR second:mariom_runFastR third:mariol_runFastR tag:MARIO_RUNACTION_TAG];
                }
                else {
                    [self playerRunAction:starMarioS_runFastR second:starMarioL_runFastR third:starMarioL_runFastR tag:MARIO_RUNACTION_TAG];
                }
                player_.isMarioStop = NO;
                player_.isMarioMovingRight = YES;
            }
            
            if (player_.body->GetLinearVelocity().x > 8) {
                player_.body->SetLinearVelocity(b2Vec2(8.0, player_.body->GetLinearVelocity().y));
            }
        }
        else {
            player_.body->ApplyForceToCenter(b2Vec2((1500)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            if ((player_.isMarioStop == YES || player_.isMarioMovingRight == NO || player_.isMoveFast == NO) && 
                player_.isFaceWall == NO) {
                
                [self playerStopAllMoveAction];
                if (player_.body->GetLinearVelocity().x >= 0 && player_.body->GetLinearVelocity().x <= 1) {
                    if (player_.isInvincible == NO) {
                        [self playerRunAction:marios_runSlowR second:mariom_runSlowR third:mariol_runSlowR tag:MARIO_RUNACTION_TAG];
                    }
                    else {
                        [self playerRunAction:starMarioS_runSlowR second:starMarioL_runSlowR third:starMarioL_runSlowR tag:MARIO_RUNACTION_TAG];
                    }
                    
                    player_.isMoveFast = NO;
                }
                else if (player_.body->GetLinearVelocity().x > 1 && player_.body->GetLinearVelocity().x <= 5) {
                    if (player_.isInvincible == NO) {
                        [self playerRunAction:marios_runMediumR second:mariom_runMediumR third:mariol_runMediumR tag:MARIO_RUNACTION_TAG];
                    }
                    else {
                        [self playerRunAction:starMarioS_runMediumR second:starMarioL_runMediumR third:starMarioL_runMediumR tag:MARIO_RUNACTION_TAG];
                    }
                    player_.isMoveFast = YES;
                }
                player_.isMarioStop = NO;
                player_.isMarioMovingRight = YES;
            }
            
            if (player_.body->GetLinearVelocity().x > 4) {
                player_.body->SetLinearVelocity(b2Vec2(4.0, player_.body->GetLinearVelocity().y));
            }
        }
        
        if (player_.body->GetLinearVelocity().x < -2) {
            
            if (player_.isInvincible == NO) {
            
                [self playerSetActionFrameOne:marios_stopR two:mariom_stopR three:mariol_stopR];
            }
            else {
                [self playerRunAction:starMarioS_stopR second:starMarioL_stopR third:starMarioL_stopR tag:STARMARIO_STOPACTION_TAG];
            }
        }
        
    }
    else if (player_.stkHead == kStickHeadingLeft && player_.isJump == NO) {
        
        if (player_.isFaceWall && faceWallTimes_ == 0) {
            
            [self playerStopAllMoveAction];
            if (player_.isInvincible == NO) {
                [self playerRunAction:marios_runSlowL second:mariom_runSlowL third:mariol_runSlowL tag:MARIO_RUNACTION_TAG];
            }
            else {
                [self playerRunAction:starMarioS_runSlowL second:starMarioL_runSlowL third:starMarioL_runSlowL tag:MARIO_RUNACTION_TAG];
            }
            faceWallTimes_++;
        }
        
        if (hud_.btnA.active == YES) {
            player_.body->ApplyForceToCenter(b2Vec2(-(2000)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if ((player_.isMarioStop == YES || player_.isMarioMovingRight == YES) && 
                player_.isFaceWall == NO) {
                
                [self playerStopAllMoveAction];
                
                if (player_.isInvincible == NO) {
                    [self playerRunAction:marios_runFastL second:mariom_runFastL third:mariol_runFastL tag:MARIO_RUNACTION_TAG];
                }
                else {
                    [self playerRunAction:starMarioS_runFastL second:starMarioL_runFastL third:starMarioL_runFastL tag:MARIO_RUNACTION_TAG];
                }
                
                player_.isMarioStop = NO;
                player_.isMarioMovingRight = NO;
            }
            
            if (player_.body->GetLinearVelocity().x < -8) {
                player_.body->SetLinearVelocity(b2Vec2(-8.0, player_.body->GetLinearVelocity().y));
            }
        }
        else {
            player_.body->ApplyForceToCenter(b2Vec2(-(1500)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if ((player_.isMarioStop == YES || player_.isMarioMovingRight == YES || player_.isMoveFast == NO) && 
                player_.isFaceWall == NO) {      
                
                [self playerStopAllMoveAction];
                if (player_.body->GetLinearVelocity().x <= 0 && player_.body->GetLinearVelocity().x >= -1) {
                    if (player_.isInvincible == NO) {
                        [self playerRunAction:marios_runSlowL second:mariom_runSlowL third:mariol_runSlowL tag:MARIO_RUNACTION_TAG];
                    }
                    else {
                        [self playerRunAction:starMarioS_runSlowL second:starMarioL_runSlowL third:starMarioL_runSlowL tag:MARIO_RUNACTION_TAG];
                    }
                    player_.isMoveFast = NO;
                }
                else if (player_.body->GetLinearVelocity().x < -1 && player_.body->GetLinearVelocity().x >= -5) {
                    if (player_.isInvincible == NO) {
                        [self playerRunAction:marios_runMediumL second:mariom_runMediumL third:mariol_runMediumL tag:MARIO_RUNACTION_TAG];
                    }
                    else {
                        [self playerRunAction:starMarioS_runMediumL second:starMarioL_runMediumL third:starMarioL_runMediumL tag:MARIO_RUNACTION_TAG];
                    }
                    player_.isMoveFast = YES;
                }
                player_.isMarioStop = NO;
                player_.isMarioMovingRight = NO;
                
            }
            
            if (player_.body->GetLinearVelocity().x < -4) {
                player_.body->SetLinearVelocity(b2Vec2(-4.0, player_.body->GetLinearVelocity().y));
            }
        }
        
        if (player_.body->GetLinearVelocity().x > 2) {
            
            if (player_.isInvincible == NO) {

                [self playerSetActionFrameOne:marios_stopL two:mariom_stopL three:mariol_stopL];
            }
            else {
                [self playerRunAction:starMarioS_stopL second:starMarioL_stopL third:starMarioL_stopL tag:STARMARIO_STOPACTION_TAG];
            }
        }
        
    }
    
    //COMMENTS:
    //判断条件是mario的底边和任何物体有接触时，isJump = NO
    //当弹跳达到最高点时，竖直方向的速度也是0，所以不能用这个来判断mario是否在弹跳过程中
    
    if (abs(player_.body->GetLinearVelocity().x) < 0.3 && 
        abs(player_.body->GetLinearVelocity().y) < 0.3 && 
        player_.isJump == NO) {
        
        if (player_.stkHead != kStickHeadingLeft && 
            player_.stkHead != kStickHeadingRight && 
            //player_.stkHead != kStickHeadingDown && 
            player_.isFireing == NO && 
            player_.isMarioStop == NO) {
            
            faceWallTimes_ = 0;
            [self playerStopAllMoveAction];
            
            if (player_.isMarioMovingRight) {
                
                if (player_.isInvincible == NO) {

                    [self playerSetActionFrameOne:marios_standR two:mariom_standR three:mariol_standR];
                }
                else {
                    [self playerRunAction:starMarioS_standR second:starMarioL_standR third:starMarioL_standR tag:STARMARIO_STANDACTION_TAG];
                }
            }
            else {
                if (player_.isInvincible == NO) {
                    
                    [self playerSetActionFrameOne:marios_standL two:mariom_standL three:mariol_standL];
                }
                else {
                    [self playerRunAction:starMarioS_standL second:starMarioL_standL third:starMarioL_standL tag:STARMARIO_STANDACTION_TAG];
                }
            }
        }
        player_.isMarioStop = YES;
        player_.isMoveFast = NO;
        
        if (player_.isFaceWall) {
            player_.isMarioStop = NO;
        }
    }
    
    player_.position = CGPointMake(player_.body->GetPosition().x*PTM_RATIO, 
                                   player_.body->GetPosition().y*PTM_RATIO);
    
    CGPoint zero = CGPointMake(0, 0);
    zero = [self convertToNodeSpace:zero];
    if (player_.position.x-player_.contentSize.width/2 < zero.x) {
        player_.body->SetTransform(b2Vec2((zero.x+player_.contentSize.width/2)/PTM_RATIO, 
                                          player_.body->GetPosition().y), 
                                   player_.body->GetAngle());
    }
    
    [self setViewPointCenter:player_.position];
    
    if (player_.position.y < zero.y-player_.contentSize.height/2) {

        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
        delegate.curLives--;
        [self showGameInfoScene];
    }
}



- (id)init {
    if (self = [super init]) {
        
        winSize = [[CCDirector sharedDirector] winSize];
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
        totalPressTime_ = 0;
        totalPressTimeA_ = 0;
        fireDelta_ = 0;
        multiCoinBrickPushUpTimes_ = 0;
        starMarioStart_ = NULL;
        
        player_.marioStatus = delegate.marioStatus;
        
        tileMap_ = [CCTMXTiledMap node];
        tileMap_ = delegate.currentLevel.p_bg;
        tileMap_.anchorPoint = ccp(0, 0);

        [self addChild:tileMap_];
                
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mario.plist"];
        spriteSheet_ = [[CCSpriteBatchNode batchNodeWithFile:@"mario.png"] retain];
        [tileMap_ addChild:spriteSheet_];
        
        [self generateAction];
        [self setPhysicsWorld];
                
        [self drawCollideObject];
        
        [self schedule:@selector(updateWorldStep:)];
        
        [self schedule:@selector(updateCollision)];
        [self schedule:@selector(checkoutJump:) interval:0.05];
        [self schedule:@selector(updatePlayerPositon:)];
        [self schedule:@selector(updatePlayerFire:)];
        [self schedule:@selector(updateOtherObjPosition)];
    }
    return self;
}

-(void)onExit {
    [spriteSheet_ removeAllChildrenWithCleanup:YES];
}

- (void)dealloc {
    delete world_;
    delete m_debugDraw;
    delete contactListener_;
    [spriteSheet_ release];
    [marios_runSlowR release];
    [marios_runSlowL release];
    [marios_runFastR release];
    [marios_runFastL release];
    [marios_standL release];
    [marios_standR release];
    [marios_stopL release];
    [marios_stopR release];
    [marios_jumpL release];
    [marios_jumpR release];
    
    [mariom_runSlowR release];
    [mariom_runSlowL release];
    [mariom_runFastR release];
    [mariom_runFastL release];
    [mariom_standL release];
    [mariom_standR release];
    [mariom_stopL release];
    [mariom_stopR release];
    [mariom_jumpL release];
    [mariom_jumpR release];
    
    [mariol_runSlowR release];
    [mariol_runSlowL release];
    [mariol_runFastR release];
    [mariol_runFastL release];
    [mariol_standL release];
    [mariol_standR release];
    [mariol_stopL release];
    [mariol_stopR release];
    [mariol_jumpL release];
    [mariol_jumpR release];
    
    [flashMarioS_WalkR1 release];
    [flashMarioS_WalkR2 release];
    [flashMarioS_WalkR3 release];
    
    [flashMarioS_WalkL1 release];
    [flashMarioS_WalkL2 release];
    [flashMarioS_WalkL3 release];
    
    [flashMarioL_WalkR1 release];
    [flashMarioL_WalkR2 release];
    [flashMarioL_WalkR3 release];
    
    [flashMarioL_WalkL1 release];
    [flashMarioL_WalkL2 release];
    [flashMarioL_WalkL3 release];
    
    [starMarioL_standR release];
    [starMarioL_standL release];
    [starMarioL_stopR release];
    [starMarioL_stopL release];
    [starMarioL_jumpR release];
    [starMarioL_jumpL release];
    [starMarioL_runFastL release];
    [starMarioL_runFastR release];
    [starMarioL_runMediumR release];
    [starMarioL_runMediumL release];
    [starMarioL_runSlowR release];
    [starMarioL_runSlowL release];
    
    [starMarioS_standR release];
    [starMarioS_standL release];
    [starMarioS_stopR release];
    [starMarioS_stopL release];
    [starMarioS_jumpR release];
    [starMarioS_jumpL release];
    [starMarioS_runFastL release];
    [starMarioS_runFastR release];
    [starMarioS_runMediumR release];
    [starMarioS_runMediumL release];
    [starMarioS_runSlowR release];
    [starMarioS_runSlowL release];
    
    [ironBrick_ release];
    [goldBrickFlash_ release];
    [flowerFlash_ release];
    [coinUp_ release];
    [fireBallRotate_ release];
    [fireBallExplode_ release];
    [starFlash_ release];
    
    [mariol_fireR release];
    [mariol_fireL release];
    
    [enemy1_walk release];
    [super dealloc];
}

@end


@implementation MainGameScene
@synthesize gameLayer = gameLayer_, hudLayer = hudLayer_;

+ (id)scene {
    MainGameScene *scene = [MainGameScene node];
    scene.gameLayer = [MainGameLayer node];
    [scene addChild:scene.gameLayer z:-1];
    scene.hudLayer = [HudStickLayer node];
    [scene.hudLayer setStickVisible:YES];
    [scene addChild:scene.hudLayer z:0];
    scene.gameLayer.hud = scene.hudLayer;
    return scene;
}

-(void)dealloc {
    [super dealloc];
    self.gameLayer = nil;
}

@end