//
//  MasterRoom.m
//  MagicTactil
//
//  Created by cedric on 20/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "MasterRoom.h"

@interface MasterRoom ()

@end

@implementation MasterRoom

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
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    [self.buttonDelete setTitle:NSLocalizedString(@"Delete", @"") forState:UIControlStateNormal];
}

/**
 *  Défini les orientations supportées
 *
 *  @return enum de l'orientation
 */
-(NSInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    gameBoard = [sbIpad instantiateViewControllerWithIdentifier:@"gameBoard"];
    sendMsg = false;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLeaveRoomResponse:) name:@"LEAR" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkDeleteRoomResponse:) name:@"DERO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBroadcastMessageResponse:) name:@"MESB" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPlayerJoin:) name:@"PJRO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPlayerLeave:) name:@"PLRO" object:nil];
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Quitter une room
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
 *  Vérifie le retour du serveur de leave room
 *
 *  @param notification leave room notification
 */
- (void)checkLeaveRoomResponse:(NSNotification *)notification
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
    
        if ([response isEqualToString:@"OK"])
            [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 *  Supprime la room
 */
- (void)sendDeleteRoom
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"DERO"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"nameOwner\r%@\nnameRoom\r%@", appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie la suppression de la room
 *
 *  @param notification delete room notification
 */
- (void)checkDeleteRoomResponse:(NSNotification *)notification
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

/**
 *  Défini le nombre de sections
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
 *  Défini le nombre de cellules par section
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
 *  Envoie un message public
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
    packet.data = [[NSString stringWithFormat:@"message\r%@\nnameRoom\r%@", [NSString stringWithFormat:@"%@ : %@",appDelegate.user.auth_userName, self.messageArea.text], ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie l'envoie d'un message public
 *
 *  @param notification send broadcast message notification
 */
- (void)checkBroadcastMessageResponse:(NSNotification *)notification
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

/**
 *  Vérifie le retour du serveur de la requête join room
 *
 *  @param notification join room notification
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
 *  Vérifie le retour du serveur de la requête leave room
 *
 *  @param notification leave room notification
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
 *  supprime les joueurs
 *
 *  @param request liste des joueurs
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
 *  Sauvegarde un nouveau joueur
 *
 *  @param request details du joueurs
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
    [appDelegate.network.packetArray removeLastObject];
}

/**
 *  Affiche la vue précédente
 *
 *  @param sender boutton précédent
 */
- (IBAction)clickReturn:(UIButton *)sender
{
    [self sendLeaveRoom];
}

/**
 *  Supprime la room
 *
 *  @param sender boutton suppression room
 */
- (IBAction)deleteRoom:(UIButton *)sender
{
    [self sendDeleteRoom];
}

/**
 *  Lancer le jeu
 *
 *  @param sender boutton lancer le jeu
 */
- (IBAction)clickLaunchGame:(UIButton *)sender
{
    if (appDelegate.cardsAreLoaded) {
        if ([appDelegate.listPlayers count] > 1)
            [self presentViewController:gameBoard animated:YES completion:nil];
        else
            [JDStatusBarNotification showWithStatus:NSLocalizedString(@"TwoPlayers", @"") dismissAfter:3 styleName:@"style02"];
    }
    else
        [JDStatusBarNotification showWithStatus:NSLocalizedString(@"ChooseDeck", @"") dismissAfter:3 styleName:@"style02"];
}

/**
 *  Envoyer un message public
 *
 *  @param sender boutton envoyer un message
 */
- (IBAction)clickSendMessage:(UIButton *)sender {
    sendMsg = true;
    self.chatArea.text = [NSString stringWithFormat:@"%@\nMoi : %@", self.chatArea.text, self.messageArea.text];
    [self sendBroadcastMessageRoom];
    self.messageArea.text = @"";
}

/**
 *  Ferme le clavier
 *
 *  @param sender textfield
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
 *  Commence l'édition d'un uitextfield
 *
 *  @param sender uitextfield
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
@end
