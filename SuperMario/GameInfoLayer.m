//
//  GameInfoLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameInfoLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation GameInfoLayer

- (CCSpriteFrame *) getFrameByName: (NSString *)name {
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name];
    return frame;
}

- (CCSprite *) getSpriteByName: (NSString *)name {
    CCSprite *sprite = [CCSprite spriteWithSpriteFrame:[self getFrameByName:name]];
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

- (void) moveToNextScene {
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    if (delegate.curLives <= 0) {
        [delegate loadSelectScene];
    }
    else {
        [delegate loadMainGameScene];
    }
}

- (id) createLabelByName:(NSString *)name position:(CGPoint)pos fontSize:(int)size {
    CCLabelTTF *label = [CCLabelTTF labelWithString:name fontName:@"Chesterfield" fontSize:size];
    label.position = pos;
    [self addChild:label z:1];
    return label;
}

- (void) stopRunAction: (id)sender {
    CCSprite *mario = (CCSprite *)sender;
    [mario setDisplayFrame:[self getFrameByName:@"marios_jumpr.png"]];
    [mario stopActionByTag:0];
    [[SimpleAudioEngine sharedEngine] playEffect:@"smb_jumpsmall.wav"];
}

- (void) startRunAction: (id)sender {
    CCSprite *mario = (CCSprite *)sender;
    [mario runAction:[[m_run copy] autorelease]];
    
}

-(id)init {
    if (self = [super init]) {
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
        winSize = [[CCDirector sharedDirector] winSize];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameInfoLayerSheet.plist"];
        m_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"gameInfoLayerSheet.png"];
        [self addChild:m_spriteSheet];
        
        int l1 = delegate.curLevelNum/4 + 1;
        int l2 = delegate.curLevelNum%4 + 1;
        [self scheduleOnce:@selector(moveToNextScene) delay:5];
        
        if (delegate.curLives > 0) {
            CCSprite *mario = [self getSpriteByName:@"marios_standr.png"];
            mario.position = ccp(winSize.width/2-(50.0/480)*winSize.width, winSize.height/2);
            [m_spriteSheet addChild:mario z:1];
            CCLabelTTF *liveLabel = [self createLabelByName:[NSString stringWithFormat:@"x %d",delegate.curLives] 
                           position:ccp(mario.position.x+(78.0/480)*winSize.width, mario.position.y) 
                           fontSize:18];
            [self createLabelByName:[NSString stringWithFormat:@"WORLD  %d-%d", l1, l2] 
                           position:ccp(winSize.width/2, mario.position.y+(70.0/320)*winSize.height) 
                           fontSize:22];
            if (l2%2 == 1) {
                m_run = [[self createFrameActionByName:@"marios_walkr%d.png" frameNum:3 interval:0.05 repeat:10] retain];
                m_run.tag = 0;

                [mario runAction:[CCSequence actions:
                                  [CCDelayTime actionWithDuration:1], 
                                  [CCSpawn actions:[[m_run copy] autorelease], 
                                                   [CCMoveBy actionWithDuration:0.5 
                                                                        position:ccp((50.0/480)*winSize.width, 0)], nil],  
                                  [CCCallFuncN actionWithTarget:self selector:@selector(stopRunAction:)], 
                                  [CCJumpBy actionWithDuration:1 
                                                      position:ccp(liveLabel.contentSize.width+(40.0/480)*winSize.width, 0) 
                                                        height:(50.0/320)*winSize.height 
                                                         jumps:1],
                                  [CCSpawn actions:[CCCallFuncN actionWithTarget:self selector:@selector(startRunAction:)],
                                                   [CCMoveTo actionWithDuration:1 position:ccp(winSize.width+mario.contentSize.width, mario.position.y)], 
                                                    nil],                                  
                                  nil]];
            }
            else {
                m_run = [[self createFrameActionByName:@"marios_walkl%d.png" frameNum:3 interval:0.05 repeat:20] retain];
                [mario runAction:[CCSequence actions:
                                  [CCDelayTime actionWithDuration:1], 
                                  [CCSpawn actions:[[m_run copy] autorelease], 
                                                    [CCMoveTo actionWithDuration:3 
                                                                        position:ccp(-mario.contentSize.width, 
                                                                                     mario.position.y)], 
                                                    nil], 
                                  nil]];
            }
        }
        else {
            [self createLabelByName:@"Game Over (>.<)" 
                           position:ccp(winSize.width/2, winSize.height/2)
                           fontSize:20];
        }
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    [m_run release];
}

@end

@implementation GameInfoScene

@synthesize layer = layer_;
@synthesize hudLayer = hudLayer_;

+ (id)scene {
    GameInfoScene *scene = [GameInfoScene node];
    scene.layer = [GameInfoLayer node];
    [scene addChild:scene.layer z:0];
    scene.hudLayer = [HudStickLayer node];
    [scene addChild:scene.hudLayer z:1];
    return scene;
}

@end