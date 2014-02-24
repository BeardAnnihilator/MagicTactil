//
//  Network.h
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Packet.h"

#define         IP_SERVER_ADRESS "192.168.1.12"
//#define         IP_SERVER_ADRESS "163.5.84.57"
//#define         IP_SERVER_ADRESS "192.168.1.12"
//#define           IP_SERVER_ADRESS "10.41.177.0"
#define         PORT_SERVER 3000

@interface Network : NSObject <NSStreamDelegate>
{
}
/* IBOutlets */
@property (readwrite, nonatomic) BOOL                           connectionState;
@property (readwrite, nonatomic) BOOL                           authentificationState;
@property (strong, nonatomic) NSInputStream                     *inputStream;
@property (strong, nonatomic) NSOutputStream                    *outputStream;
@property (strong, nonatomic) NSMutableArray                    *packetArray;
@property (readwrite, nonatomic) BOOL                           signUp;

/* IBActions */

/* Methodes Classiques */
- (void)initNetworkConnection;
- (void)sendPacket:(Packet*)packet;
- (void)receivePacket;
- (BOOL)checkInternetConnection;

@end
