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

- (void)generateAction {
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
    
    goldBrickFlash_ = [[self createFrameActionByName:@"goldBrick1_%d.png" frameNum:10 interval:0.1 repeat:0] retain];
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
            if (mario_status == kMarioSmall) {
                sprite = [self getSpriteByName:@"marios_standr.png"];
            }
            else if (mario_status == kMarioLarge) {
                sprite = [self getSpriteByName:@"mariom_standr.png"];
            }
            else {
                sprite = [self getSpriteByName:@"mariol_standr.png"];
            }
            sprite.position = _point;
            player_ = (Player *)sprite;
            isDynamic = YES;
            player_.type = kGameObjectPlayer;
            [spriteSheet_ addChild:player_];
        }
        else if (objType && [objType compare:@"ground"] == NSOrderedSame) {
            sprite = [self getSpriteByName:@"other.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameObjectPlatform;
            [spriteSheet_ addChild:sprite];
        }
        else if (objType && [objType compare:@"brick"] == NSOrderedSame) {
            sprite = [self getSpriteByName:@"brick1.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameObjectBrick;
            [spriteSheet_ addChild:sprite];
        }
        else if (objType && [objType compare:@"goldBrick"] == NSOrderedSame) {
            sprite = [self getSpriteByName:@"goldBrick1_1.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameobjectGoldBrick;
            [spriteSheet_ addChild:sprite];
            [sprite runAction:[[goldBrickFlash_ copy] autorelease]];
        }
        else if (objType && [objType compare:@"mushBrick"] == NSOrderedSame) {
            sprite = [self getSpriteByName:@"goldBrick1_1.png"];
            sprite.position = _point;
            isDynamic = NO;
            sprite.type = kGameobjectMushBrick;
            [spriteSheet_ addChild:sprite];
            [sprite runAction:[[goldBrickFlash_ copy] autorelease]];
        }
        
        if (sprite != nil) {
            [sprite createPhisicsBody:world_ 
                              postion:_point 
                                 size:_size 
                              dynamic:isDynamic 
                             friction:1.0
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
    m_debugDraw = new GLESDebugDraw(PTM_RATIO);
    world_->SetDebugDraw(m_debugDraw);
    uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    m_debugDraw->SetFlags(flags);
}

- (void) draw {
    [super draw];
    ccGLEnableVertexAttribs(kCCVertexAttrib_Position);
    kmGLPushMatrix();
    world_->DrawDebugData();
    kmGLPopMatrix();
}

- (void) updatePositon:(ccTime)dt {
    int32 velocityIterations = 8;
    int32 positionIterations = 3;
    world_->Step(dt, velocityIterations, positionIterations);

    if (hud_.stick.velocity.x > 0 && isJump_ == NO) {
        
        if (hud_.btnA.active == YES) {
            player_.body->ApplyForceToCenter(b2Vec2((2000)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if (isMarioStop_ == YES || isMarioMovingRight_ == NO) {
                [player_ stopAllActions];
                if (mario_status == kMarioSmall) {
                    [player_ runAction:[[marios_runFastR copy] autorelease]];
                }
                else if (mario_status == kMarioLarge) {
                    [player_ runAction:[[mariom_runFastR copy] autorelease]];
                }
                else {
                    [player_ runAction:[[mariol_runFastR copy] autorelease]];
                }
                isMarioStop_ = NO;
                isMarioMovingRight_ = YES;
            }
            
            if (player_.body->GetLinearVelocity().x > 8) {
                player_.body->SetLinearVelocity(b2Vec2(8.0, 0));
            }
        }
        else {
            player_.body->ApplyForceToCenter(b2Vec2((1500)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if (isMarioStop_ == YES || isMarioMovingRight_ == NO || isMoveFast_ == NO) {
                [player_ stopAllActions];
                if (player_.body->GetLinearVelocity().x > 0 && player_.body->GetLinearVelocity().x <= 1) {
                    if (mario_status == kMarioSmall) {
                        [player_ runAction:[[marios_runSlowR copy] autorelease]];
                    }
                    else if (mario_status == kMarioLarge) {
                        [player_ runAction:[[mariom_runSlowR copy] autorelease]];
                    }
                    else {
                        [player_ runAction:[[mariom_runSlowR copy] autorelease]];
                    }
                    isMoveFast_ = NO;
                }
                else if (player_.body->GetLinearVelocity().x > 1 && player_.body->GetLinearVelocity().x <= 5) {
                    if (mario_status == kMarioSmall) {
                        [player_ runAction:[[marios_runMediumR copy] autorelease]];
                    }
                    else if (mario_status == kMarioLarge) {
                        [player_ runAction:[[mariom_runMediumR copy] autorelease]];
                    }
                    else {
                        [player_ runAction:[[mariom_runMediumR copy] autorelease]];
                    }
                    isMoveFast_ = YES;
                }
                isMarioStop_ = NO;
                isMarioMovingRight_ = YES;
            }
            
            if (player_.body->GetLinearVelocity().x > 4) {
                player_.body->SetLinearVelocity(b2Vec2(4.0, 0));
            }
        }
        
        if (player_.body->GetLinearVelocity().x < -2) {
            
            if (mario_status == kMarioSmall) {
                [player_ setDisplayFrame:marios_stopR];
            }
            else if (mario_status == kMarioLarge) {
                [player_ setDisplayFrame:mariom_stopR];
            }
            else {
                [player_ setDisplayFrame:mariol_stopR];
            }
        }
        
    }
    else if (hud_.stick.velocity.x < 0 && isJump_ == NO) {
        
        if (hud_.btnA.active == YES) {
            player_.body->ApplyForceToCenter(b2Vec2((2000)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if (isMarioStop_ == YES || isMarioMovingRight_ == YES) {
                [player_ stopAllActions];
                
                if (mario_status == kMarioSmall) {
                    [player_ runAction:[[marios_runFastL copy] autorelease]];
                }
                else if (mario_status == kMarioLarge) {
                    [player_ runAction:[[mariom_runFastL copy] autorelease]];
                }
                else {
                    [player_ runAction:[[mariol_runFastL copy] autorelease]];
                }
                isMarioStop_ = NO;
                isMarioMovingRight_ = NO;
            }
            
            if (player_.body->GetLinearVelocity().x < -8) {
                player_.body->SetLinearVelocity(b2Vec2(-8.0, 0));
            }
        }
        else {
            player_.body->ApplyForceToCenter(b2Vec2(-(1500)/PTM_RATIO, 0));
            player_.body->SetLinearDamping(0.5);
            
            if (isMarioStop_ == YES || isMarioMovingRight_ == YES || isMoveFast_ == NO) {      
                [player_ stopAllActions];
                if (player_.body->GetLinearVelocity().x < 0 && player_.body->GetLinearVelocity().x >= -1) {
                    if (mario_status == kMarioSmall) {
                        [player_ runAction:[[marios_runSlowL copy] autorelease]];
                    }
                    else if (mario_status == kMarioLarge) {
                        [player_ runAction:[[mariom_runSlowL copy] autorelease]];
                    }
                    else {
                        [player_ runAction:[[mariol_runSlowL copy] autorelease]];
                    }
                    isMoveFast_ = NO;
                }
                else if (player_.body->GetLinearVelocity().x < -1 && player_.body->GetLinearVelocity().x >= -5) {
                    if (mario_status == kMarioSmall) {
                        [player_ runAction:[[marios_runMediumL copy] autorelease]];
                    }
                    else if (mario_status == kMarioLarge) {
                        [player_ runAction:[[mariom_runMediumL copy] autorelease]];
                    }
                    else {
                        [player_ runAction:[[mariol_runMediumL copy] autorelease]];
                    }
                    isMoveFast_ = YES;
                }
                isMarioStop_ = NO;
                isMarioMovingRight_ = NO;
            }
            
            if (player_.body->GetLinearVelocity().x < -4) {
                player_.body->SetLinearVelocity(b2Vec2(-4.0, 0));
            }
        }
        
        if (player_.body->GetLinearVelocity().x > 2) {
            
            if (mario_status == kMarioSmall) {
                [player_ setDisplayFrame:marios_stopL];
            }
            else if (mario_status == kMarioLarge) {
                [player_ setDisplayFrame:mariom_stopL];
            }
            else {
                [player_ setDisplayFrame:mariol_stopL];
            }
        }
        
    }
    
    player_.position = CGPointMake(player_.body->GetPosition().x*PTM_RATIO, 
                                   player_.body->GetPosition().y*PTM_RATIO);
    
    if (isJump_ == NO) {
        if (hud_.btnB.active == YES) {
            totalPressTime_ += dt;
            readyToJump_ = YES;
            if (totalPressTime_ > 0.1) {
                totalPressTime_ = 0.1;
                player_.body->ApplyLinearImpulse(b2Vec2(0, (300+2000*(totalPressTime_))/PTM_RATIO), 
                                                 player_.body->GetWorldCenter());
                [player_ stopAllActions];
                if (isMarioMovingRight_) {
                    
                    if (mario_status == kMarioSmall) {
                        [player_ setDisplayFrame:marios_jumpR];
                    }
                    else if (mario_status == kMarioLarge) {
                        [player_ setDisplayFrame:mariom_jumpR];
                    }
                    else {
                        [player_ setDisplayFrame:mariol_jumpR];
                    }
                }
                else {
                    
                    if (mario_status == kMarioSmall) {
                        [player_ setDisplayFrame:marios_jumpL];
                    }
                    else if (mario_status == kMarioLarge) {
                        [player_ setDisplayFrame:mariom_jumpL];
                    }
                    else {
                        [player_ setDisplayFrame:mariol_jumpL];
                    }
                }
                isJump_ = YES;
                totalPressTime_ = 0;
                readyToJump_ = NO;
            }
        }
        else if (readyToJump_) {
            player_.body->ApplyLinearImpulse(b2Vec2(0, (300+2000*(totalPressTime_))/PTM_RATIO), 
                                             player_.body->GetWorldCenter());
            [player_ stopAllActions];
            if (isMarioMovingRight_) {
                
                if (mario_status == kMarioSmall) {
                    [player_ setDisplayFrame:marios_jumpR];
                }
                else if (mario_status == kMarioLarge) {
                    [player_ setDisplayFrame:mariom_jumpR];
                }
                else {
                    [player_ setDisplayFrame:mariol_jumpR];
                }
            }
            else {
                
                if (mario_status == kMarioSmall) {
                    [player_ setDisplayFrame:marios_jumpL];
                }
                else if (mario_status == kMarioLarge) {
                    [player_ setDisplayFrame:mariom_jumpL];
                }
                else {
                    [player_ setDisplayFrame:mariol_jumpL];
                }
            }
            isJump_ = YES;
            readyToJump_ = NO;
            totalPressTime_ = 0;
        }
    }
    //COMMENTS:
    //判断条件是mario的底边和任何物体有接触时，isJump = NO
    //当弹跳达到最高点时，竖直方向的速度也是0，所以不能用这个来判断mario是否在弹跳过程中
    if (player_.body->GetLinearVelocity().y == 0) {
        isJump_ = NO;
    }
    
    if (abs(player_.body->GetLinearVelocity().x) < 0.1 && abs(player_.body->GetLinearVelocity().y) < 0.1) {
        isMarioStop_ = YES;
        isMoveFast_ = NO;
        [player_ stopAllActions];
        if (isMarioMovingRight_) {
            
            if (mario_status == kMarioSmall) {
                [player_ setDisplayFrame:marios_standR];
            }
            else if (mario_status == kMarioLarge) {
                [player_ setDisplayFrame:mariom_standR];
            }
            else {
                [player_ setDisplayFrame:mariol_standR];
            }
        }
        else {
            
            if (mario_status == kMarioSmall) {
                [player_ setDisplayFrame:marios_standL];
            }
            else if (mario_status == kMarioLarge) {
                [player_ setDisplayFrame:mariom_standL];
            }
            else {
                [player_ setDisplayFrame:mariol_standL];
            }
        }
    }
    [self setViewPointCenter:player_.position];
}

- (id)init {
    if (self = [super init]) {
        
        winSize = [[CCDirector sharedDirector] winSize];
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
        totalPressTime_ = 0;
        isMarioStop_ = YES;
        isMarioMovingRight_ = YES;
        isMoveFast_ = NO;
        isJump_ = NO;
        readyToJump_ = NO;
        mario_status = delegate.marioStatus;
        
        tileMap_  = [CCTMXTiledMap node];
        tileMap_ = delegate.currentLevel.p_bg;
        tileMap_.anchorPoint = ccp(0, 0);
        //        CCTMXLayer *bgLayer = [tileMap_ layerNamed:@"backGround"];
        [self addChild:tileMap_];
                
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mario.plist"];
        spriteSheet_ = [[CCSpriteBatchNode batchNodeWithFile:@"mario.png"] retain];
        [tileMap_ addChild:spriteSheet_];
        
        [self generateAction];
        [self setPhysicsWorld];
                
        [self drawCollideObject];
        [self schedule:@selector(updatePositon:) interval:0.001];
    }
    return self;
}

- (void)dealloc {
    delete world_;
    delete m_debugDraw;
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
    
    [goldBrickFlash_ release];
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

@end