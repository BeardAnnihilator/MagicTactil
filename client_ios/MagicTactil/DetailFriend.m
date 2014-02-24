//
//  DetailFriend.m
//  MagicTactil
//
//  Created by cedric on 10/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "DetailFriend.h"

@interface DetailFriend ()

@end

@implementation DetailFriend

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
    [self.buttonDelete setTitle:NSLocalizedString(@"Delete", @"") forState:UIControlStateNormal];
    [self.buttonSend setTitle:NSLocalizedString(@"Send", @"") forState:UIControlStateNormal];
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    app = [[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkDeleteFriendResponse:) name:@"DELF" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkReceiveMessage:) name:@"PRIVATE_MESSAGE" object:nil];
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
- (IBAction)clickReturn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillAppear:(BOOL)animated {
    if ([((FriendObject*)app.listFriends[app.selectedFriend]).messages length] > 0)
        self.chatArea.text = ((FriendObject*)app.listFriends[app.selectedFriend]).messages;
    self.pseudo.text = ((FriendObject*)app.listFriends[app.selectedFriend]).userName;
    self.pseudoIpad.text = ((FriendObject*)app.listFriends[app.selectedFriend]).userName;
}

/**
 *  Vérifie le reception d'un message
 *
 *  @param notification check private message notification
 */
- (void)checkReceiveMessage:(NSNotification *)notification {
    self.chatArea.text = ((FriendObject*)app.listFriends[app.selectedFriend]).messages;
}

/**
 *  Supprime un ami
 */
- (void)sendDeleteFriend
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"DELF"] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!(IDIOM == IPAD))
        packet.data = [[NSString stringWithFormat:@"username\r%@\nbelongsto\r%@", app.user.auth_userName, self.pseudo.text] dataUsingEncoding:NSUTF8StringEncoding];
    else
         packet.data = [[NSString stringWithFormat:@"username\r%@\nbelongsto\r%@", app.user.auth_userName, self.pseudoIpad.text] dataUsingEncoding:NSUTF8StringEncoding];
        
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête delete friend
 *
 *  @param notification delete friend notification
 */
- (void)checkDeleteFriendResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        [app.listFriends removeObjectAtIndex:app.selectedFriend];
        
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"DeleteFriendOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"DeleteFriendKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject]; 
}

/**
 *  Envoie un message privée
 */
- (void)sendPrivateMessageRoom {
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"MESP"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@\nmessage\r%@", ((FriendObject*)app.listFriends[app.selectedFriend]).userName, [NSString stringWithFormat:@"%@ : %@", app.user.auth_userName, self.messageArea.text]] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    ((FriendObject*)app.listFriends[app.selectedFriend]).messages = [NSString stringWithFormat:@"%@\nMoi: %@", ((FriendObject*)app.listFriends[app.selectedFriend]).messages, self.messageArea.text];
    self.chatArea.text = ((FriendObject*)app.listFriends[app.selectedFriend]).messages;
    
    [app.network sendPacket:packet];
    self.messageArea.text = @"";
}

/**
 *  Supprime un ami
 *
 *  @param sender boutton supprimer
 */
- (IBAction)clickDelete:(id)sender
{
    [self sendDeleteFriend];
}

/**
 *  Envoie un message privée
 *
 *  @param sender boutton send
 */
- (IBAction)clickSendMessage:(UIButton *)sender {
    [self sendPrivateMessageRoom];
}

/**
 *  Ferme le clavier
 *
 *  @param sender textfield
 */
- (IBAction)closeKeyboard:(id)sender {
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
 *  Call back de début d'edition de message privée
 *
 *  @param sender textfield
 */
- (IBAction)beginEditing:(UITextField *)sender {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = CGRectMake(0, -264, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }
     ];
}

@end
