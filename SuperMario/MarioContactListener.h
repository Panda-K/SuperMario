//
//  MarioContactListener.h
//  SuperMario
//
//  Created by jashon on 13-11-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Box2D.h"
#import <vector>
#import <algorithm>
#import "Player.h"

struct MyContact {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    bool operator == (const MyContact& other) const {
        return (fixtureA == other.fixtureA)&&(fixtureB == other.fixtureB);
    }
};

class MarioContactListener : public b2ContactListener {
    public:
    std::vector<MyContact>contacts_;
    
    MarioContactListener();
    ~MarioContactListener();
    
    virtual void BeginContact(b2Contact* contact);
    virtual void EndContact(b2Contact* contact);
    virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
    virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
};