//
//  Room.m
//  MagicTactil
//
//  Created by cedric on 13/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "Room.h"

@interface Room ()

@end

@implementation Room

/**
 *  Initialise la vue
 *
 *  @param nibNameOrNil   fichier xib
 *  @param nibBundleOrNil bundle de l'application
 *
 *  @return la vue
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
    [self.buttonSend setTitle:NSLocalizedString(@"Send", @"") forState:UIControlStateNormal];
    [self.buttonGame setTitle:NSLocalizedString(@"LaunchGame", @"") forState:UIControlStateNormal];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewDidAppear:(BOOL)animated {
}

/**
 *  Défini les orientation supportées
 *
 *  @return enum de l'orientation
 */
-(NSInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

/**
 *  Initialise les propriétées
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    sendMsg = FALSE;
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    gameBoard = [sbIpad instantiateViewControllerWithIdentifier:@"gameBoard"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLeaveRoomResponse:) name:@"LEAR" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBroadcastMessageResponse:) name:@"MESB" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPlayerJoin:) name:@"PJRO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPlayerLeave:) name:@"PLRO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRoomDestroyed:) name:@"KILR" object:nil];
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Quite la room
 */
- (void)sendLeaveRoom
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"LEAR"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@\nnameRoom\r%@", appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur pour LeaveRoom
 *
 *  @param notification notification Leave room
 */
- (void)checkLeaveRoomResponse:(NSNotification *)notification
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
    
        if ([response isEqualToString:@"OK"])
            [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 *  Envoie un message à la room
 */
- (void)sendBroadcastMessageRoom
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"MESB"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"message\r%@\nnameRoom\r%@", [NSString stringWithFormat:@"%@ : %@", appDelegate.user.auth_userName, self.messageArea.text], ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur pour l'envoie du message
 *
 *  @param notification notification BroadcastMessage
 */
- (void)checkBroadcastMessageResponse:(NSNotification *)notification
{
    if (appDelegate.isMaster == NO)
    {
        Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
        //NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
        
        NSLog(@"src = %d", *(int*)([packet.src bytes]));
        NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
        NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
        NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
        NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
        
        if (sendMsg == FALSE) {
            self.chatArea.text = [NSString stringWithFormat:@"%@\n%@", self.chatArea.text, [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]];
        }
        sendMsg = false;
        [appDelegate.network.packetArray removeLastObject];
    }
}

/**
 *  Vérifie le retour du serveur pour la connexion d'un joueur
 *
 *  @param notification notification PlayerJoin
 */
- (void)checkPlayerJoin:(NSNotification *)notification {
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [self storeNewPlayer:response];
    [appDelegate.network.packetArray removeLastObject];
}

/**
 *  Vérifie le retour du serveur quand un joueur quitte la room
 *
 *  @param notification notification PlayerLeave
 */
- (void)checkPlayerLeave:(NSNotification *)notification {
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [self deletePlayer:response];
    [appDelegate.network.packetArray removeLastObject];
}

/**
 *  Vérifie le retour du serveur quand la room est détruite
 *
 *  @param notification notification RoomDestroyed
 */
- (void)checkRoomDestroyed:(NSNotification *)notification {
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    //NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Supprimes les joueurs de la room
 *
 *  @param request requête
 */
- (void)deletePlayer:(NSString*)request {
    NSArray   *array = [request componentsSeparatedByString:@"\r"];
    int i = 0;
    
    while (i < [array count])
    {
        if (![array[i] isEqualToString:@"username"])
            [appDelegate.listPlayers removeObject:array[i]];
        i++;
    }
    [self.tableView reloadData];
}

/**
 *  Sauvegarde les nouveaux joueurs
 *
 *  @param request requête
 */
- (void)storeNewPlayer:(NSString *)request {
    NSArray   *array = [request componentsSeparatedByString:@"\r"];
    int i = 0;
    
    while (i < [array count])
    {
        if (![array[i] isEqualToString:@"username"])
            [appDelegate.listPlayers addObject:array[i]];
        i++;
    }
    [self.tableView reloadData];
}

/**
 *  Nombre de sections
 *
 *  @param tableView tableView
 *
 *  @return le nombre de section
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
    return ([appDelegate.listPlayers count]);
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
    static NSString *MyIdentifier = @"customCellPlayerRoom";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    cell.textLabel.text = appDelegate.listPlayers[indexPath.row];
    
    return (cell);
}

/**
 *  Affiche la vue précédente
 *
 *  @param sender le boutton return
 */
- (IBAction)clickReturn:(UIButton *)sender
{
    [self sendLeaveRoom];
}

/**
 *  Cette méthode est appelée quand le joueur appuis sur le boutton send et envoie un message à la room
 *
 *  @param sender le boutton send
 */
- (IBAction)clickSend:(UIButton *)sender
{
    sendMsg = true;
    self.chatArea.text = [NSString stringWithFormat:@"%@\nMoi : %@", self.chatArea.text, self.messageArea.text];
    [self sendBroadcastMessageRoom];
    self.messageArea.text = @"";
}

/**
 *  Ferme le clavier
 *
 *  @param sender UITextField
 */
- (IBAction)closeKeyboard:(UITextField *)sender {
    [sender resignFirstResponder];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }
     ];
}

/**
 *  Ouvre le clavier
 *
 *  @param sender UITextField
 */
- (IBAction)editingBegin:(UITextField *)sender {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = CGRectMake(0, -264, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }
     ];
}

/**
 *  Lance le plateau de jeu
 *
 *  @param sender button launch game
 */
- (IBAction)clickLaunchGame:(UIButton *)sender {
    if (appDelegate.cardsAreLoaded) {
        if ([appDelegate.listPlayers count] > 1)
            [self presentViewController:gameBoard animated:YES completion:nil];
        else
            [JDStatusBarNotification showWithStatus:NSLocalizedString(@"TwoPlayers", @"") dismissAfter:3 styleName:@"style02"];
    }
    else
        [JDStatusBarNotification showWithStatus:NSLocalizedString(@"ChooseDeck", @"") dismissAfter:3 styleName:@"style02"];
}
@end
