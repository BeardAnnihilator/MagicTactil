//
//  BlackList.m
//  MagicTactil
//
//  Created by cedric on 10/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "BlackList.h"

@interface BlackList ()

@end

@implementation BlackList

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
    [self sendGetBlackListFriend];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    [self.buttonAdd setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
    [self.buttonDelete setTitle:NSLocalizedString(@"Delete", @"") forState:UIControlStateNormal];
    self.textFieldIpad.placeholder = NSLocalizedString(@"Username", @"");
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    app = [[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBlockFriendResponse:) name:@"ADBL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetBlackListFriendResponse:) name:@"GTBL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkDeleteUserFromBlackListFriendResponse:) name:@"DEBL" object:nil];
}

/**
 *  Redimmensionne la vue
 */
- (void)viewWillLayoutSubviews
{
    if (IS_IPHONE5)
    {
        [self handle4];
    }
    else
    {
        [self handle3_5];
    }
}

/**
 *  Redimmensionne l'écran 3.5 inch
 */
- (void)handle3_5
{
    self.tableViewIphone.frame = CGRectMake(0, 65, 320, 415);
}

/**
 *  Redimmensionne l'écran 4 inch
 */
- (void)handle4
{
    self.tableViewIphone.frame = CGRectMake(0, 65, 320, 504);
}

/**
 *  Défini le nombre de sections du tableau
 *
 *  @param tableView le tableau
 *
 *  @return nombre de sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (1);
}

/**
 *  Défini le nombre de colonnes
 *
 *  @param tableView le tableau
 *  @param section   la section
 *
 *  @return le nombre de colonnes
 */
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([app.blackList count]);
}

/**
 *  Défini la cellule
 *
 *  @param tableView le tableau
 *  @param indexPath l'index (section + row)
 *
 *  @return la cellule
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(IDIOM == IPAD))
    {
        static NSString *MyIdentifier = @"customCell02";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
        FriendObject       *object = [app.blackList objectAtIndex:indexPath.row];
        cell.textLabel.text = object.userName;
    
        return (cell);
    }
    else
    {
        static NSString *MyIdentifier = @"customCellIpad02";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        FriendObject       *object = [app.blackList objectAtIndex:indexPath.row];
        cell.textLabel.text = object.userName;
        
        return (cell);
    }
}

/**
 *  Sélectionne une cellule
 *
 *  @param tableView le tableau
 *  @param indexPath l'index
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    app.selectedFriendBL = indexPath.row;
    
    self.textFieldUserName.text = ((FriendObject*)app.blackList[app.selectedFriendBL]).userName;
    self.textFieldIpad.text = ((FriendObject*)app.blackList[app.selectedFriendBL]).userName;
}

/**
 *  Bloque un ami
 */
- (void)sendBlockFriend
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"ADBL"] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!(IDIOM == IPAD))
        packet.data = [[NSString stringWithFormat:@"username\r%@\nbelongsto\r%@", app.user.auth_userName, self.textFieldUserName.text] dataUsingEncoding:NSUTF8StringEncoding];
    else
        packet.data = [[NSString stringWithFormat:@"username\r%@\nbelongsto\r%@", app.user.auth_userName, self.textFieldIpad.text] dataUsingEncoding:NSUTF8StringEncoding];
    
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête block friend
 *
 *  @param notification block friend notification
 */
- (void)checkBlockFriendResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        FriendObject *object = [[FriendObject alloc] init];
        
        if (!(IDIOM == IPAD))
            object.userName = self.textFieldUserName.text;
        else
            object.userName = self.textFieldIpad.text;
        
        [app.blackList addObject:object];
        
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"AddBLOK", @"")];
        
        [self.tableViewIphone reloadData];
        [self.tableViewIpad reloadData];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"AddBLKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
}

/**
 *  Récupère la liste des amis bloqués
 */
- (void)sendGetBlackListFriend
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GTBL"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@", app.user.auth_userName] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête get black list
 *
 *  @param notification get black list notification
 */
- (void)checkGetBlackListFriendResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    //NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
    [self storeBlackList:[[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]];
}

/**
 *  Supprime un ami de la black list
 */
- (void)sendDeleteUserFromBlackListFriend
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"DEBL"] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!(IDIOM == IPAD))
        packet.data = [[NSString stringWithFormat:@"username\r%@\nbelongsto\r%@", app.user.auth_userName, self.textFieldUserName.text] dataUsingEncoding:NSUTF8StringEncoding];
    else
        packet.data = [[NSString stringWithFormat:@"username\r%@\nbelongsto\r%@", app.user.auth_userName, self.textFieldIpad.text] dataUsingEncoding:NSUTF8StringEncoding];
    
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête delete friend from blacklist
 *
 *  @param notification delete friend from black list notification
 */
- (void)checkDeleteUserFromBlackListFriendResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        [app.blackList removeObjectAtIndex:app.selectedFriendBL];
        
        [self.tableViewIphone reloadData];
        [self.tableViewIpad reloadData];
        
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"DeleteBLOK", @"")];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"DeleteBLKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
}

/**
 *  Sauvegarde la liste des amis bloqués
 *
 *  @param list liste des amis bloqués
 */
- (void)storeBlackList:(NSString*)list
{
    NSArray         *array = [list componentsSeparatedByString:@"\n"];
    FriendObject    *current;
    
    int i = 0;
    
    while (i < ([array count] - 1))
    {
        current = [[FriendObject alloc] init];
        
        current.userName = array[i];
        [app.blackList addObject:current];
        
        i++;
    }
    [self.tableViewIphone reloadData];
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Retour à la vue précédente
 *
 *  @param sender boutton précédent
 */
- (IBAction)clickReturn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Ajoute un utilisateur à la black list
 *
 *  @param sender boutton add black list
 */
- (IBAction)clickAddBL:(id)sender
{
    if (!(IDIOM == IPAD))
    {
        if (![self.textFieldUserName.text isEqualToString:@""])
            [self sendBlockFriend];
    }
    else
    {
        if (![self.textFieldIpad.text isEqualToString:@""])
            [self sendBlockFriend];
    }
}

/**
 *  Ferme le clavier
 *
 *  @param sender textfield
 */
- (IBAction)closeKeyboard:(UITextField *)sender
{
    [sender resignFirstResponder];
}

/**
 *  Supprime un utilisateur de la blacklist
 *
 *  @param sender boutton supprimer
 */
- (IBAction)deleteUserFromBlackList:(UIButton *)sender
{
    if (!(IDIOM == IPAD))
    {
        if (![self.textFieldUserName.text isEqualToString:@""])
            [self sendDeleteUserFromBlackListFriend];
    }
    else
    {
        if (![self.textFieldIpad.text isEqualToString:@""])
            [self sendDeleteUserFromBlackListFriend];
    }
}
@end
