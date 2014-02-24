//
//  ManageCards.m
//  MagicTactil
//
//  Created by Ekhoo on 10/09/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "ManageCards.h"

@interface ManageCards ()

@end

@implementation ManageCards

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
    
    [JDStatusBarNotification showWithStatus:NSLocalizedString(@"LoadingCards", @"") styleName:@"style01"];
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAddCardResponse:) name:@"ACFD" object:nil];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    [self.buttonAdd setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewDidAppear:(BOOL)animated {
    [self initListCards];
    [JDStatusBarNotification dismiss];
    [self.collection reloadData];
}

/**
 *  Initialise le catalogue de cartes
 */
- (void)initListCards
{
    if (appDelegate.cardsAreLoaded == FALSE)
    {
        NSString    *fileName = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"xml"];
    
        NSDictionary *tmpDic = [NSDictionary dictionaryWithXMLFile:fileName];
    
        appDelegate.listCards = [[tmpDic objectForKey:@"cards"] objectForKey:@"card"];
        appDelegate.cardsAreLoaded = TRUE;
    
        NSLog(@"%d", [appDelegate.listCards count]);
        appDelegate.cardsAreLoaded = TRUE;
    }
}

/**
 *  Défini le nombre d'items par sections
 *
 *  @param collectionView collectionView
 *  @param section        la section
 *
 *  @return le nombre d'items
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ([appDelegate.listCards count]);
}

/**
 *  Défini le nombre de sections
 *
 *  @param collectionView collectionView
 *
 *  @return le nombre de sections
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return (1);
}

/**
 *  Défini la cellule
 *
 *  @param collectionView collectionview
 *  @param indexPath      l'index
 *
 *  @return la cellule
 */
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ManageCardsCell *cell;
    NSDictionary  *object = [appDelegate.listCards objectAtIndex:indexPath.item];
    NSDictionary *tmp;
    
    if([[object objectForKey:@"set"] isKindOfClass:[NSDictionary class]])
    {
        tmp = [object objectForKey:@"set"];
    }
    else
    {
        tmp = [[object objectForKey:@"set"] objectAtIndex:0];
    }
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearDisk];
    [imageCache clearMemory];
    [imageCache cleanDisk];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"manageCardsCell" forIndexPath:indexPath];
    
    [cell.img setBackgroundImageWithURL:[NSURL URLWithString:[tmp objectForKey:@"_picURL"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"deck.jpg"]];
    
    cell.labelTitle.text = [object objectForKey:@"name"];
    cell.description.text = [object objectForKey:@"text"];
    [cell.layer setBorderWidth:2.0];
    [cell.layer setCornerRadius:5.0];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    return (cell);
}

/**
 *  Sélectionne une cellule
 *
 *  @param collectionView collectionView
 *  @param indexPath      l'index
 */
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary  *object = [appDelegate.listCards objectAtIndex:indexPath.item];
    self.labelTitle.text = [object objectForKey:@"name"];
    selectedCard = indexPath.item;
}

/**
 *  Envoie la requete add card au serveur
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
    packet.data = [[NSString stringWithFormat:@"nameOwner\r%@\ndeckName\r%@\nidCard\r%@\nnbCard\r%@\nisSided\r%@", appDelegate.user.auth_userName, ((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).deckName, [NSString stringWithFormat:@"%d", selectedCard], @"1", @"YES"] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requette add card
 *
 *  @param notification la notification add card
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
 *  Sauvegarde la carte dans le deck
 */
- (void)storeCard
{
    NSDictionary  *object = [appDelegate.listCards objectAtIndex:selectedCard];
    CardObject *card = [[CardObject alloc] init];
    NSDictionary *tmp;
    
    if([[object objectForKey:@"set"] isKindOfClass:[NSDictionary class]])
    {
        tmp = [object objectForKey:@"set"];
    }
    else
    {
        tmp = [[object objectForKey:@"set"] objectAtIndex:0];
    }
    
    card.color = [object objectForKey:@"color"];
    card.manacost = [object objectForKey:@"manacost"];
    card.idCard = [NSString stringWithFormat:@"%d", selectedCard];
    card.text = [object objectForKey:@"text"];
    card.name = [object objectForKey:@"name"];
    card.pt = [object objectForKey:@"pt"];
    card.url = [tmp objectForKey:@"_picURL"];
    card.tableRow = [object objectForKey:@"tablerow"];
    card.typeCard = [object objectForKey:@"type"];
    
    [((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards addObject:card];
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton retour
 *
 *  @param sender le boutton retour
 */
- (IBAction)clickReturn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton ajouter une carte
 *
 *  @param sender le boutton ajouter une carte
 */
- (IBAction)clickAdd:(UIButton *)sender
{
    [self sendAddCard];
}
@end
