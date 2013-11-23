//
//  Player.m
//  SuperMario
//
//  Created by jashon on 13-11-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)init {
    if (self = [super init]) {
        type_ = kGameObjectPlayer;
    }
    return self;
}

- (void)moveRight {
    b2Vec2 impulse = b2Vec2(10.0, 0.0);
    p_body->ApplyLinearImpulse(impulse, p_body->GetWorldCenter());
    
}

- (void)moveLeft {
    b2Vec2 impulse = b2Vec2(-10.0, 0.0);
    p_body->ApplyLinearImpulse(impulse, p_body->GetWorldCenter());
}

- (void)jump {
    b2Vec2 impulse = b2Vec2(0.0, 15.0);
    p_body->ApplyLinearImpulse(impulse, p_body->GetWorldCenter());
}
@end
