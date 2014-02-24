//
//  DeckObject.m
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "DeckObject.h"

@implementation DeckObject

/**
 *  Initialise le deck
 *
 *  @return le deck
 */
- (id)init
{
    self = [super init];
    
    self.listCards = [NSMutableArray array];
    
    return (self);
}

@end
