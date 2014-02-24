//
//  Friends.m
//  MagicTactil
//
//  Created by cedric on 10/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "Friends.h"

@interface Friends ()

@end

@implementation Friends

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
    [self sendGetAllFriends];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    self.textFieldIpad.placeholder = NSLocalizedString(@"Username", @"");
    [self.buttonAdd setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableViewIphone reloadData];
    [self.tableViewIpad reloadData];
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
 *  initialise les propriétés
 */
- (void)initObjects
{
    app = [[UIApplication sharedApplication] delegate];
    sbIphone = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    detailFriend = [sbIphone instantiateViewControllerWithIdentifier:@"detailfriends"];
    detailFriendIpad = [sbIpad instantiateViewControllerWithIdentifier:@"detailfriendIpad"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetAllFriendsResponse:) name:@"GFRL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAddFriendsResponse:) name:@"ADFR" object:nil];
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Défini le nombre sections
 *
 *  @param tableView tableView
 *
 *  @return retourne le nombre de sections
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
    return ([app.listFriends count]);
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
    if (!(IDIOM == IPAD))
    {
        static NSString *MyIdentifier = @"customCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
        FriendObject       *object = [app.listFriends objectAtIndex:indexPath.row];
        cell.textLabel.text = object.userName;
        return (cell);
    }
    else
    {
        static NSString *MyIdentifier = @"customCellIpad";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        FriendObject       *object = [app.listFriends objectAtIndex:indexPath.row];
        cell.textLabel.text = object.userName;
        return (cell);
    }
}

/**
 *  Sélectionne une cellule
 *
 *  @param tableView tableView
 *  @param indexPath l'index
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    app.selectedFriend = indexPath.row;
    
    if (!(IDIOM == IPAD))
        [self presentViewController:detailFriend animated:YES completion:nil];
    else
        [self presentViewController:detailFriendIpad animated:YES completion:nil];
}

/**
 *  Sauvegarde les amis
 *
 *  @param list liste des amis
 */
- (void)storeAllFriends:(NSString*)list
{
    NSArray         *array = [list componentsSeparatedByString:@"\n"];
    FriendObject    *current;
    
    int i = 0;
    
    while (i < ([array count] - 1))
    {
        current = [[FriendObject alloc] init];
        current.messages = @"";
        current.userName = array[i];
        [app.listFriends addObject:current];
        
        i++;
    }
    [self.tableViewIphone reloadData];
    [self.tableViewIpad reloadData];
}

/**
 *  Ajoute un ami
 */
- (void)sendAddFriends
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"ADFR"] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!(IDIOM == IPAD))
        packet.data = [[NSString stringWithFormat:@"username\r%@\nbelongsto\r%@", app.user.auth_userName, self.textFieldUserName.text] dataUsingEncoding:NSUTF8StringEncoding];
    else
        packet.data = [[NSString stringWithFormat:@"username\r%@\nbelongsto\r%@", app.user.auth_userName, self.textFieldIpad.text] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie l'ajout d'un ami
 *
 *  @param notification add friend notification
 */
- (void)checkAddFriendsResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        FriendObject *friend = [[FriendObject alloc] init];
        
        if (!(IDIOM == IPAD))
            friend.userName = self.textFieldUserName.text;
        else
            friend.userName = self.textFieldIpad.text;
        
        [app.listFriends addObject:friend];
        self.textFieldIpad.text = @"";
        friend.messages = @"";
         
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"AddFriendOK", @"")];
        [self.tableViewIphone reloadData];
        [self.tableViewIpad reloadData];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"AddFriendKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
}

/**
 *  Récupère les amis
 */
- (void)sendGetAllFriends
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GFRL"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@", app.user.auth_userName] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet]; 
}

/**
 *  Vérifie la récupération des amis
 *
 *  @param notification get all friends notification
 */
- (void)checkGetAllFriendsResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
    [self storeAllFriends:response];
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
 *  Ajoute une ami
 *
 *  @param sender boutton ajouter un ami
 */
- (IBAction)clickAddFriend:(id)sender
{
    if (!(IDIOM == IPAD))
    {
        if (![self.textFieldUserName.text isEqualToString:@""])
            [self sendAddFriends];
    }
    else
    {
        if ([self checkFields])
            [self sendAddFriends];
    }
}

/**
 *  Vérifie les champs
 *
 *  @return ok pour ajouter si non KO
 */
- (BOOL)checkFields {
    if ([self.textFieldIpad.text length] > 0)
        return (YES);
    else {
        [JDStatusBarNotification showWithStatus:NSLocalizedString(@"PseudoAddFriend", @"") dismissAfter:3 styleName:@"style02"];
        return (NO);
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

@end
