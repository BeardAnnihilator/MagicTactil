//
//  CardObject.h
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <Foundation/Foundation.h>

@interface CardObject : NSObject
{
    
}
/* Properties */
@property (readwrite, nonatomic) NSString                           *idCard;
@property (readwrite, nonatomic) NSString                           *name;
@property (readwrite, nonatomic) NSString                           *color;
@property (readwrite, nonatomic) NSString                           *manacost;
@property (readwrite, nonatomic) NSString                           *typeCard;
@property (readwrite, nonatomic) NSString                           *pt;
@property (readwrite, nonatomic) NSString                           *tableRow;
@property (readwrite, nonatomic) NSString                           *text;
@property (readwrite, nonatomic) NSString                           *nbCard;
@property (readwrite, nonatomic) NSString                           *isSided;
@property (readwrite, nonatomic) NSString                           *url;
@property (readwrite, nonatomic) NSString                           *idGame;

/* Methods */

@end
