//
//  MoveRectObject.h
//  SuperMario
//
//  Created by jashon on 13-12-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#import "Box2D.h"
#import "GameObject.h"

@interface MoveRectObject : GameObject {
    BOOL isMoving_;
    BOOL isShrink_;
}
@property (nonatomic, readwrite) BOOL isMoving;
@property (nonatomic, readwrite) BOOL isShrink;

- (void)createPhisicsBody:(b2World *)world 
                  postion:(CGPoint)pos 
                     size:(CGPoint)size 
                  dynamic:(BOOL)dy 
                 friction:(float)f 
                  density:(float)dens 
              restitution:(long)rest 
                    boxId:(int)id;

@end
