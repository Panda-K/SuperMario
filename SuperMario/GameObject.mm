//
//  GameObject.m
//  SuperMario
//
//  Created by jashon on 13-11-16.
//  Copyright (c) 2013年 __Panda-K__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject
@synthesize type = type_;

-(id)init {
    if (self = [super init]) {
        type_ = kGameObjectNone;
    }
}

- (void)createPhisicsBody:(b2World *)world {
    
}

- (void)dealloc {
    [super dealloc];
}

@end
