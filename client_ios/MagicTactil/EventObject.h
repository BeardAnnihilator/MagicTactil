//
//  EventObject.h
//  MagicTactil
//
//  Created by cedric on 16/04/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventObject : NSObject

@property (readwrite, nonatomic) NSString *name;
@property (readwrite, nonatomic) NSString *description;
@property (readwrite, nonatomic) NSString *date;
@property (readwrite, nonatomic) NSString *location;
@property (readwrite, nonatomic) NSString *id;
@property (readwrite, nonatomic) NSString *creator;

@end
