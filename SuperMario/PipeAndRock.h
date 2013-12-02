//
//  PipeAndRock.h
//  SuperMario
//
//  Created by jashon on 13-11-27.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#import "GameConfig.h"
#import "GameObject.h"

@interface PipeAndRock : GameObject {
    
}


- (void)createPhisicsBody:(b2World *)world 
                  postion:(CGPoint)pos 
                     size:(CGPoint)size 
                  dynamic:(BOOL)dy 
                 friction:(float)f 
                  density:(float)dens 
              restitution:(long)rest 
                    boxId:(int)id;

@end
