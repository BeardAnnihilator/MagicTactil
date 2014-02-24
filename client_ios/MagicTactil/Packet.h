//
//  Packet.h
//  MagicTactil
//
//  Created by Ekhoo on 13/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Packet : NSObject
{
    
}

@property (strong, nonatomic) NSData             *src;
@property (strong, nonatomic) NSData             *dest;
@property (strong, nonatomic) NSData             *func;
@property (strong, nonatomic) NSData             *dataSize;
@property (strong, nonatomic) NSData             *data;

@end
