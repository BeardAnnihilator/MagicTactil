//
//  CreateRoom.m
//  MagicTactil
//
//  Created by cedric on 13/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "CreateRoom.h"

@interface CreateRoom ()

@end

@implementation CreateRoom

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
    [self translate];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    self.labelCreate.text = NSLocalizedString(@"Creation", @"");
    self.labelName.text = NSLocalizedString(@"NameGame", @"");
    self.labelFormat.text = NSLocalizedString(@"FormatGame", @"");
    self.labelType.text = NSLocalizedString(@"TypeGame", @"");
    [self.buttonCreate setTitle:NSLocalizedString(@"Create", @"") forState:UIControlStateNormal];
    self.roomName.placeholder = NSLocalizedString(@"NameGame", @"");
    [self.state setTitle:NSLocalizedString(@"Private", @"") forSegmentAtIndex:0];
    [self.state setTitle:NSLocalizedString(@"Public", @"") forSegmentAtIndex:1];
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    room = [sbIpad instantiateViewControllerWithIdentifier:@"masterRoom"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAddRoomResponse:) name:@"CNRO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetPlayersResponse:) name:@"GPFR" object:nil];
}

/**
 *  Ajoute une room sur le serveur
 */
- (void)sendAddRoom
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"CNRO"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"nameOwner\r%@\nformat\r%@\nnameRoom\r%@\nstate\r%d", appDelegate.user.auth_userName, [self.format titleForSegmentAtIndex:self.format.selectedSegmentIndex], self.roomName.text, self.state.selectedSegmentIndex] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête add room
 *
 *  @param notification add room notification
 */
- (void)checkAddRoomResponse:(NSNotification *)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if (![response isEqualToString:@"KO"])
    {
        RoomObject *roomObject = [[RoomObject alloc] init];
        
        roomObject.name = self.roomName.text;
        roomObject.creator = appDelegate.user.auth_userName;
        roomObject.id = response;
        
        [appDelegate.listRoom addObject:roomObject];
        appDelegate.selectedRoom = [appDelegate.listRoom count] - 1;
        
        [appDelegate showAlertView:@"Serveur" withMessage:NSLocalizedString(@"CreateRoomOK", @"")];
        [self sendGetPlayers];
    }
    else
    {
        [appDelegate showAlertView:@"Serveur" withMessage:NSLocalizedString(@"CreateRoomKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
}

/**
 *  Récupère la liste des joueurs de la room
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
    packet.data = [[NSString stringWithFormat:@"idRoom\r%@", ((RoomObject*)appDelegate.listRoom[[appDelegate.listRoom count] - 1]).id] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête get players
 *
 *  @param notification get players notifications
 */
- (void)checkGetPlayersResponse:(NSNotification *)notification
{
    if (appDelegate.isMaster == YES)
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
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Retourne à la vue précédente
 *
 *  @param sender boutton retour
 */
- (IBAction)clickReturn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Ferme le clavier
 *
 *  @param sender textfield
 */
- (IBAction)closeKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

/**
 *  Créer une room
 *
 *  @param sender button créer une room
 */
- (IBAction)clickCreateRoom:(id)sender
{
    [self sendAddRoom];
}
@end
