//
//  GameInfoLayer.h
//  SuperMario
//
//  Created by jashon on 13-11-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "HudStickLayer.h"
@interface GameInfoLayer : CCLayer

- (void) reset;

@end

@interface GameInfoScene : CCScene {
    GameInfoLayer *layer_;
    HudStickLayer *hudLayer_;
}

@property (nonatomic, retain) GameInfoLayer *layer;
@property (nonatomic, retain) HudStickLayer *hudLayer;

+ (id) scene;

@end