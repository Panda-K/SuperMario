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
    b2Fixture *p_bottomFixture;
    b2Fixture *p_topFixture;
}

@property (nonatomic, readwrite) GameObjectType type; 
@property (nonatomic, readwrite) b2Body *body;
@property (nonatomic, readwrite) b2Fixture *bottomFixture;
@property (nonatomic, readwrite) b2Fixture *topFixture;

- (void)createPhisicsBody:(b2World *)world 
                  postion:(CGPoint)pos 
                     size:(CGPoint)size 
                  dynamic:(BOOL)dy 
                 friction:(long)f 
                  density:(long)dens 
              restitution:(long)rest 
                    boxId:(int)id;


@end
