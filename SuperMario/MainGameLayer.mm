//
//  MainGameLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "MainGameLayer.h"

@implementation MainGameLayer

- (void) reset {
    
}

- (id)init {
    if (self = [super init]) {
        winSize = [[CCDirector sharedDirector] winSize];
    }
    return self;
}

@end


@implementation MainGameScene
@synthesize gameLayer = gameLayer_, hudLayer = hudLayer_;

+ (id)scene {
    MainGameScene *scene = [MainGameScene node];
    scene.gameLayer = [MainGameLayer node];
    [scene addChild:scene.gameLayer z:0];
    scene.hudLayer = [HudStickLayer node];
    [scene.hudLayer setStickVisible:YES];
    [scene addChild:scene.hudLayer z:1];
    
    return scene;
}

@end