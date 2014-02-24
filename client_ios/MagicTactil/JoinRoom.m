//
//  JoinRoom.m
//  MagicTactil
//
//  Created by cedric on 13/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "JoinRoom.h"

@interface JoinRoom ()

@end

@implementation JoinRoom

/**
 *  Initialise la vue
 *
 *  @param nibNameOrNil   fichier xib
 *  @param nibBundleOrNil bundle de l'application
 *
 *  @return retourne la vue
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

/**
 *  Charge la vue
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initObjects];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillAppear:(BOOL)animated
{
    [appDelegate.listRoom removeAllObjects];
    [self sendGetAllRooms];
    [self.tableViewIpad reloadData];
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    room = [sbIpad instantiateViewControllerWithIdentifier:@"room"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetAllRoomsResponse:) name:@"GEAR" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetPlayersResponse:) name:@"GPFR" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkJoinRoomResponse:) name:@"JORO" object:nil];
}

/**
 *  Récupère les rooms
 */
- (void)sendGetAllRooms
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GEAR"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"/"] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie la récupération des rooms
 *
 *  @param notification get all room notification
 */
- (void)checkGetAllRoomsResponse:(NSNotification *)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"SRC = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    [self storeAllRooms:response];
}

/**
 *  Récupère les joueurs
 */
- (void)sendGetPlayers
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GPFR"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"idRoom\r%@", ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).id] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie la récupération des joueurs
 *
 *  @param notification get players notification
 */
- (void)checkGetPlayersResponse:(NSNotification *)notification
{
    if (appDelegate.isMaster == NO)
    {
        Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
        NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
        NSLog(@"src = %d", *(int*)([packet.src bytes]));
        NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
        NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
        NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
        NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
        [appDelegate.network.packetArray removeLastObject];
        [self storeAllPlayers:response];
        [self presentViewController:room animated:YES completion:nil];
    }
}

/**
 *  Rejoindre une room
 */
- (void)sendJoinRoom
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"JORO"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@\nnameRoom\r%@", appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête join room
 *
 *  @param notification join room notification
 */
- (void)checkJoinRoomResponse:(NSNotification *)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    
    if ([response isEqualToString:@"OK"])
        [self sendGetPlayers];
}

/**
 *  Sauvegarde les joueurs
 *
 *  @param list liste des joueurs
 */
- (void)storeAllPlayers:(NSString *)list
{
    [appDelegate.listPlayers removeAllObjects];
    NSArray   *array = [list componentsSeparatedByString:@"\n"];
    int i = 0;
    
    while (i < ([array count] - 1))
    {
        [appDelegate.listPlayers addObject:array[i]];
        i++;
    }
}

/**
 *  Sauvegarde les rooms
 *
 *  @param list liste des rooms
 */
- (void)storeAllRooms:(NSString *)list
{
    list = [list stringByReplacingOccurrencesOfString:@"/" withString:@""];
    [appDelegate.listRoom removeAllObjects];
    NSArray   *array = [list componentsSeparatedByString:@"\n"];
    NSArray   *cut;
    int i = 0;
    RoomObject *object;
    
    while (i < [array count])
    {
        cut = [array[i] componentsSeparatedByString:@"\r"];
        
        if ([cut[0] isEqualToString:@"id"])
        {
            object = [[RoomObject alloc] init];
            object.id = cut[1];
        }
        else if ([cut[0] isEqualToString:@"nameOwner"])
            object.creator = cut[1];
        else if ([cut[0] isEqualToString:@"format"])
            object.format = cut[1];
        else if ([cut[0] isEqualToString:@"nameRoom"])
            object.name = cut[1];
        else if ([cut[0] isEqualToString:@"state"])
        {
            object.state = cut[1];
            [appDelegate.listRoom addObject:object];
        }
        i++;
    }
    [self.tableViewIpad reloadData];
}

/**
 *  Défini le nombre de sections
 *
 *  @param tableView tableView
 *
 *  @return le nombre de sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (1);
}

/**
 *  Défini le nombre de cellules par sections
 *
 *  @param tableView tableView
 *  @param section   la section
 *
 *  @return le nombre de cellules
 */
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([appDelegate.listRoom count]);
}

/**
 *  Défini la cellule
 *
 *  @param tableView tableView
 *  @param indexPath l'index
 *
 *  @return la cellule
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"customCellIpad03";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
    RoomObject       *object = [appDelegate.listRoom objectAtIndex:indexPath.row];
    
    if (![object.state isEqualToString:@"0"])
        cell.textLabel.text = object.name;
    else
        cell.textLabel.text = @"Privée";
    return (cell);
}

/**
 *  Sélectionne une cellule
 *
 *  @param tableView tableView
 *  @param indexPath l'index
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appDelegate.selectedRoom = indexPath.row;
    [self sendJoinRoom];
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Affiche la vue précédente
 *
 *  @param sender boutton retour
 */
- (IBAction)clickReturn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
