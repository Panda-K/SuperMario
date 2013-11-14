//
//  GameInfoLayer.m
//  SuperMario
//
//  Created by jashon on 13-11-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameInfoLayer.h"

@implementation GameInfoLayer

- (void) reset {
    
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