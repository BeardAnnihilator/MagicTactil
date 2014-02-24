//
//  AddCard.m
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "AddCard.h"

@interface AddCard ()

@end

@implementation AddCard

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
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetCardResponse:) name:@"GCBI" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAddCardResponse:) name:@"ACFD" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkDeleteCardResponse:) name:@"RCFD" object:nil];
}

/**
 *  Affiche la vue
 *
 *  @param animated Avec animation
 */
- (void)viewWillAppear:(BOOL)animated
{
    if (appDelegate.addEditCard == 0)
    {
        self.buttonDelete.alpha = 0;
    }
    else if (appDelegate.addEditCard == 1)
    {
        self.buttonDelete.alpha = 1;
    }
}

/**
 *  Envoie la requette get card au serveur
 */
- (void)sendGetCard
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GCBI"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"idCard\r%@", self.idCardArea.text] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie les retour du serveur de la requette get card
 *
 *  @param notification get card
 */
- (void)checkGetCardResponse:(NSNotification *)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"SRC = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    [self displayDetailsCard:response];
}

/**
 *  Envoie la requette add card au serveur
 */
- (void)sendAddCard
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"ACFD"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"nameOwner\r%@\ndeckName\r%@\nidCard\r%@\nnbCard\r%@\nisSided\r%@", appDelegate.user.auth_userName, ((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).deckName, self.idCardArea.text, @"1", @"YES"] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requette add card
 *
 *  @param notification notification add card
 */
- (void)checkAddCardResponse:(NSNotification *)notification
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
    {
        [appDelegate showAlertView:@"Magictactil" withMessage:NSLocalizedString(@"AddCardOK", @"")];
        [self storeCard];
    }
}

/**
 *  Envoie la requete delete card au serveur
 */
- (void)sendDeleteCard
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    DeckObject *deck = ((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]);
    CardObject *card = deck.listCards[appDelegate.selectedCard];
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"RCFD"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"nameOwner\r%@\ndeckName\r%@\nidCard\r%@\nnbCard\r%@\nisSided\r%@", appDelegate.user.auth_userName, deck.deckName, card.idCard, @"1", @"YES"] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur delete card
 *
 *  @param notification notification delete card
 */
- (void)checkDeleteCardResponse:(NSNotification *)notification
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
    {
        [appDelegate showAlertView:@"Magictactil" withMessage:NSLocalizedString(@"DeleteCardOK", @"")];
        [((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards removeObjectAtIndex:appDelegate.selectedCard];
    }
}

/**
 *  Affiche les détails de la carte
 *
 *  @param details description de la carte
 */
- (void)displayDetailsCard:(NSString*)details
{
    NSArray   *array = [details componentsSeparatedByString:@"\n"];
    NSArray   *cut;
    int i = 0;
    currentCard = [[CardObject alloc] init];
    currentCard.idCard = self.idCardArea.text;
    
    while (i < [array count])
    {
        cut = [array[i] componentsSeparatedByString:@"\r"];
        
        if ([cut[0] isEqualToString:@"name"])
        {
            self.nameCard.text = cut[1];
            currentCard.name = cut[1];
        }
        else if ([cut[0] isEqualToString:@"color"])
        {
            currentCard.color = cut[1];
        }
        else if ([cut[0] isEqualToString:@"manacost"])
        {
            currentCard.manacost = cut[1];
        }
        else if ([cut[0] isEqualToString:@"typeCard"])
        {
            currentCard.typeCard = cut[1];
        }
        else if ([cut[0] isEqualToString:@"pt"])
        {
            currentCard.pt = cut[1];
        }
        else if ([cut[0] isEqualToString:@"tablerow"])
        {
            currentCard.tableRow = cut[1];
        }
        else if ([cut[0] isEqualToString:@"text"])
        {
            self.descriptionCard.text = cut[1];
            currentCard.text = cut[1];
        }
        i++;
    }
}

/**
 *  Sauvegarde la carte dans le deck
 */
- (void)storeCard
{
  [((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards addObject:currentCard];
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuie sur le boutton retour
 *
 *  @param sender le boutton retour
 */
- (IBAction)clickReturn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
 *  Appuie sur recherche de carte
 *
 *  @param sender description de la carte
 */
- (IBAction)clickFind:(UIButton *)sender
{
    [self sendGetCard];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuie sur le boutton ajouter une carte
 *
 *  @param sender boutton ajouter un carte
 */
- (IBAction)clickAdd:(UIButton *)sender
{
    [self sendAddCard];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuie sur le boutton supprimer une carte
 *
 *  @param sender boutton supprimer un carte
 */
- (IBAction)clickDeleteCard:(UIButton *)sender
{
    [self sendDeleteCard];
}
@end
