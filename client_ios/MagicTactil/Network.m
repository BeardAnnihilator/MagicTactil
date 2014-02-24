//
//  Network.m
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "Network.h"

@implementation Network

/**
 *  Initialise le réseau
 */
- (void)initNetworkConnection
{
    self.signUp = false;
    self.connectionState = FALSE;
    self.authentificationState = FALSE;
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)[NSString stringWithUTF8String:IP_SERVER_ADRESS], PORT_SERVER, &readStream, &writeStream);
    self.inputStream = (__bridge NSInputStream *)readStream;
    self.outputStream = (__bridge NSOutputStream *)writeStream;
    [self.inputStream setDelegate:self];
    [self.outputStream setDelegate:self];
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.inputStream open];
    [self.outputStream open];
}

/**
 *  Call back reception packet
 */
- (void)receivePacket
{
    NSLog(@"RECEIVE");
    Packet *packet = [[Packet alloc] init];
    NSString        *notification;
    int             dataSize;
    uint8_t         src[4];
    uint8_t         dest[4];
    uint8_t         func[4];
    uint8_t         size[4];
    
    [self.inputStream read:src maxLength:4];
    [self.inputStream read:dest maxLength:4];
    [self.inputStream read:size maxLength:4];
    [self.inputStream read:func maxLength:4];
    
    packet.src = [[NSData alloc] initWithBytes:src length:4];
    packet.dest = [[NSData alloc] initWithBytes:dest length:4];
    packet.func = [[NSData alloc] initWithBytes:func length:4];
    packet.dataSize = [[NSData alloc] initWithBytes:size length:4];
    
    [packet.dataSize getBytes:&dataSize length:4];
    uint8_t         data[dataSize];
    if (dataSize > 0)
        [self.inputStream read:data maxLength:dataSize];
    packet.data = [[NSData alloc] initWithBytes:data length:dataSize];
    
    notification = [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding];
    
    NSLog(@"%@", notification);
    
    [self.packetArray addObject:packet];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:self];
}

/**
 *  Envoie un packet
 *
 *  @param packet le packet
 */
- (void)sendPacket:(Packet *)packet
{
    NSMutableData           *header = [NSMutableData alloc];
    
    [header appendData:packet.src];
    [header appendData:packet.dest];
    [header appendData:packet.dataSize];
    [header appendData:packet.func];
    
    [self.outputStream write:[header bytes] maxLength:16];
    
    [self.outputStream write:[packet.data bytes] maxLength:*(int*)([packet.dataSize bytes])];
}

/**
 *  Gère les évènements du réseau
 *
 *  @param aStream   le flux
 *  @param eventCode description de l'event
 */
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode)
    {
        case NSStreamEventOpenCompleted:
            self.connectionState = TRUE;
            break;
        case NSStreamEventHasBytesAvailable:
            [self receivePacket];
			break;
        default:
            break;
    }
}

/**
 *  Vérifie l'était de la connexion
 *
 *  @return retourne l'état de la connexion
 */
- (BOOL)checkInternetConnection
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        return (false);
    }
    else
    {
        return (true);
    }
}

@end
