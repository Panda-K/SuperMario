//
//  MainGameLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainGameLayer.h"

@implementation MainGameLayer

- (void) reset {
    
}

@end


@implementation MainGameScene
@synthesize gameLayer = gameLayer_, hudLayer = hudLayer_;

+ (id)scene {
    MainGameScene *scene = [MainGameScene node];
    scene.gameLayer = [MainGameLayer node];
    [scene addChild:scene.gameLayer z:0];
    scene.hudLayer = [HudStickLayer node];
    [scene addChild:scene.hudLayer z:1];
    
    return scene;
}

@end