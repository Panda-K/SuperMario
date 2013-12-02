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
    CGPoint p_size;
    b2Fixture *p_bottomFixture;
    b2Fixture *p_topFixture;
    b2Fixture *p_rightFixture;
    b2Fixture *p_leftFixture;
    b2Fixture *p_polygonFixture;
}
@property (nonatomic, readwrite) CGPoint size;
@property (nonatomic, readwrite) GameObjectType type; 
@property (nonatomic, readwrite) b2Body *body;
@property (nonatomic, readwrite) b2Fixture *bottomFixture;
@property (nonatomic, readwrite) b2Fixture *topFixture;
@property (nonatomic, readwrite) b2Fixture *rightFixture;
@property (nonatomic, readwrite) b2Fixture *leftFixture;
@property (nonatomic, readwrite) b2Fixture *polygonFixture;

- (void)createPhisicsBody:(b2World *)world 
                  postion:(CGPoint)pos 
                     size:(CGPoint)size 
                  dynamic:(BOOL)dy 
                 friction:(float)f 
                  density:(float)dens 
              restitution:(long)rest 
                    boxId:(int)id;


@end
