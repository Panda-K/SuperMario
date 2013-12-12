//
//  MarioContactListener.m
//  SuperMario
//
//  Created by jashon on 13-11-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MarioContactListener.h"

MarioContactListener::MarioContactListener() : contacts_() {
}
MarioContactListener::~MarioContactListener() {
}

void MarioContactListener::BeginContact(b2Contact *contact) {
    MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    contacts_.push_back(myContact);
    
    
    
}

void MarioContactListener::EndContact(b2Contact *contact) {
    MyContact myContact = {contact->GetFixtureA(), contact->GetFixtureB()};
    std::vector<MyContact>::iterator pos;
    pos = std::find(contacts_.begin(), contacts_.end(), myContact);
    if (pos != contacts_.end()) {
        contacts_.erase(pos);
    }
}

void MarioContactListener::PreSolve(b2Contact *contact, const b2Manifold *oldManifold) {
    
    GameObject *obj1 = (GameObject *)contact->GetFixtureA()->GetBody()->GetUserData();
    GameObject *obj2 = (GameObject *)contact->GetFixtureB()->GetBody()->GetUserData();
    
    if (obj1.type == kGameObjectPlayer) {
        Player *player = (Player *)obj1;
        
        //大mario碰到敌人后，变小，闪烁期间不可以再碰撞
        
//        if (player.isCollidable == NO &&
//            (obj2.type == kGameObjectEnemy1 || 
//             obj2.type == kGameObjectEnemy2)) {
//                
//                b2Filter filter;
//                filter.categoryBits = 0x0004;
//                filter.maskBits = 0x0003;
//                filter.groupIndex = 0;                                  //正确写法是f = f->GetNext()
//                for (b2Fixture *f = player.body->GetFixtureList(); f; f = f->GetNext()) { 
//                    f->SetFilterData(filter);
//                }
//        }
        
        if (obj2.type == kGameObjectPipe || 
            obj2.type == kGameObjectBrick || 
            obj2.type == kGameObjectGoldBrick || 
            obj2.type == kGameObjectIronBrick || 
            obj2.type == kGameObjectMushBrick || 
            obj2.type == kGameObjectRock || 
            obj2.type == kGameObjectPlatform || 
            obj2.type == kGameObjectMultiCoinBrick || 
            obj2.type == kGameObjectStarBrick) {
            
//            polygon的摩擦系数是1，top和bottom的摩擦系数为0.5
//            mario站在其他物体上面时，二者之间的碰撞组合有： 1。mario的bottom和物体的polygon碰撞；
//                                                    2。mario的polygon和物体的top碰撞
//                                                    3。mario的polygon和物体的polygon碰撞
//            mario站在其他物体上面时，二者的polygon不要有碰撞，因为他们的摩擦系数都是1，摩擦力特别大，会造成走走停停的情况
            
            if (
                contact->GetFixtureA() == player.polygonFixture && 
                contact->GetFixtureB() == obj2.polygonFixture) {
                contact->SetEnabled(false);
            }
            
            if (player.position.y-player.contentSize.height/2 > obj2.position.y+obj2.size.y/2-8 &&
                player.position.y-player.contentSize.height/2 < obj2.position.y+obj2.size.y/2 &&
                (contact->GetFixtureA() == player.rightFixture || 
                 contact->GetFixtureA() == player.leftFixture || 
                 contact->GetFixtureA() == player.topRightFixture || 
                 contact->GetFixtureA() == player.topLeftFixture || 
                 contact->GetFixtureA() == player.bottomFixture || 
                 contact->GetFixtureA() == player.polygonFixture)) {
            
                if (player.stkHead == kStickHeadingRight) {
                    contact->SetEnabled(false);
                    player.body->ApplyLinearImpulse(b2Vec2(BIAS_IMPULSE/PTM_RATIO, 0), player.body->GetWorldCenter());
                }
                if (player.stkHead == kStickHeadingLeft) {
                    contact->SetEnabled(false);
                    player.body->ApplyLinearImpulse(b2Vec2(-BIAS_IMPULSE/PTM_RATIO, 0), player.body->GetWorldCenter());
                }
            }
        }
    }
    if (obj2.type == kGameObjectPlayer) {
        Player *player = (Player *)obj2;
        
//        if (player.isCollidable == NO && 
//            (obj1.type == kGameObjectEnemy1 || 
//             obj1.type == kGameObjectEnemy2)) {
//                
//                b2Filter filter;
//                filter.categoryBits = 0x0004;
//                filter.maskBits = 0x0003;
//                filter.groupIndex = 0;
//                for (b2Fixture *f = player.body->GetFixtureList(); f; f = f->GetNext()) {
//                    f->SetFilterData(filter);
//                }
//        }
        
        if (obj1.type == kGameObjectPipe ||
            obj1.type == kGameObjectBrick || 
            obj1.type == kGameObjectGoldBrick || 
            obj1.type == kGameObjectIronBrick || 
            obj1.type == kGameObjectMushBrick || 
            obj1.type == kGameObjectRock || 
            obj1.type == kGameObjectPlatform || 
            obj1.type == kGameObjectMultiCoinBrick || 
            obj1.type == kGameObjectStarBrick) { 
            
            if (contact->GetFixtureB() == player.polygonFixture && 
                contact->GetFixtureA() == obj1.polygonFixture) {
                contact->SetEnabled(false);
            }
            
             if (player.position.y-player.contentSize.height/2 > obj1.position.y+obj1.size.y/2-8 &&
                 player.position.y-player.contentSize.height/2 < obj1.position.y+obj1.size.y/2 &&
                 (contact->GetFixtureB() == player.rightFixture || 
                  contact->GetFixtureB() == player.leftFixture || 
                  contact->GetFixtureB() == player.topRightFixture || 
                  contact->GetFixtureB() == player.topLeftFixture || 
                  contact->GetFixtureB() == player.bottomFixture ||
                  contact->GetFixtureB() == player.polygonFixture)) {
               
                if (player.stkHead == kStickHeadingRight) {
                    contact->SetEnabled(false);
                    player.body->ApplyLinearImpulse(b2Vec2(BIAS_IMPULSE/PTM_RATIO, 0), player.body->GetWorldCenter());
                }
                if (player.stkHead == kStickHeadingLeft) {
                    contact->SetEnabled(false);
                    player.body->ApplyLinearImpulse(b2Vec2(-BIAS_IMPULSE/PTM_RATIO, 0), player.body->GetWorldCenter());
                }
            }
        }
    }
    
}
void MarioContactListener::PostSolve(b2Contact *contact, const b2ContactImpulse *impulse) {
    
    GameObject *obj1 = (GameObject *)contact->GetFixtureA()->GetBody()->GetUserData();
    GameObject *obj2 = (GameObject *)contact->GetFixtureB()->GetBody()->GetUserData();
    
    if (obj1.type == kGameObjectPlayer && 
        obj1.position.y+obj1.contentSize.height/2 > obj2.position.y-obj2.contentSize.height/2) {
        Player *player = (Player *)obj1;
        if (player.isJump == YES) {
            if(contact->GetFixtureA() == player.topRightFixture) { 
                player.body->ApplyLinearImpulse(b2Vec2(10.0/PTM_RATIO, 15.0/PTM_RATIO), player.body->GetWorldCenter());
            }
            
            if (contact->GetFixtureA() == player.topLeftFixture) {
                player.body->ApplyLinearImpulse(b2Vec2(-10.0/PTM_RATIO, 15.0/PTM_RATIO), player.body->GetWorldCenter());
            }
            
        }
    }
    
    if (obj2.type == kGameObjectPlayer && 
        obj2.position.y+obj2.contentSize.height/2 > obj1.position.y-obj1.contentSize.height/2) {
        Player *player = (Player *)obj2;
        if (player.isJump == YES) {
            if(contact->GetFixtureB() == player.topRightFixture) { 
                player.body->ApplyLinearImpulse(b2Vec2(10.0/PTM_RATIO, 15.0/PTM_RATIO), player.body->GetWorldCenter());
            }
            if (contact->GetFixtureB() == player.topLeftFixture) {
                player.body->ApplyLinearImpulse(b2Vec2(-10.0/PTM_RATIO, 15.0/PTM_RATIO), player.body->GetWorldCenter());
            }
            
        }
    }
}