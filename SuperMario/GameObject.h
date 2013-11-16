//
//  GameObject.h
//  SuperMario
//
//  Created by jashon on 13-11-16.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//
#import "Box2D.h"
#import "GameConfig.h"

@interface GameObject : CCSprite {
    GameObjectType type_;
    b2Body *p_body;
}

@property (nonatomic, readwrite) GameObjectType type; 
@property (nonatomic, readwrite) b2Body *body;

- (void) createPhisicsBody:(b2World *)world;


@end
