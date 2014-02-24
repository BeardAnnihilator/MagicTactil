//
//  Deck.m
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@end

@implementation Deck

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
    [self sendGetAllDecks];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    self.deckNameArea.placeholder = NSLocalizedString(@"DeckName", @"");
    [self.buttonAdd setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
    [self.realState setTitle:NSLocalizedString(@"Real", @"") forSegmentAtIndex:0];
    [self.realState setTitle:NSLocalizedString(@"Not", @"") forSegmentAtIndex:1];
}

/**
 *  Affiche la vue
 *
 *  @param animated <#animated description#>
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    detailDeck = [sbIpad instantiateViewControllerWithIdentifier:@"detailDeck"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetAllDecksResponse:) name:@"GLID" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAddDeckResponse:) name:@"CRDK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetDetailsDeckResponse:) name:@"SDTU" object:nil];
}

/**
 *  Charge en mémoire le catalogue
 */
- (void)loadCards
{
    if (appDelegate.cardsAreLoaded == FALSE)
    {
        NSString    *fileName = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"xml"];
    
        NSDictionary *tmpDic = [NSDictionary dictionaryWithXMLFile:fileName];
    
        appDelegate.listCards = [[tmpDic objectForKey:@"cards"] objectForKey:@"card"];
        appDelegate.cardsAreLoaded = TRUE;
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
 *  Défini le nombre d'items par section
 *
 *  @param collectionView collectionView
 *  @param section        la section
 *
 *  @return le nombre d'items
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ([appDelegate.listDecks count]);
}

/**
 *  Défini le nombre de section de la collection
 *
 *  @param collectionView collectionView
 *
 *  @return retourne le nombre de sections
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return (1);
}

/**
 *  Défini la cellule
 *
 *  @param collectionView collectionView
 *  @param indexPath      l'index
 *
 *  @return retourne la cellule
 */
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCellDeck *cell;
    DeckObject  *object = appDelegate.listDecks[indexPath.item];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellDeckIpad" forIndexPath:indexPath];
    cell.img.alpha = 1;
    cell.title.text = object.deckName;
    cell.isReal.text = object.isReal;
    
    return (cell);
}

/**
 *  Sélectionne la cellule
 *
 *  @param collectionView collectionView
 *  @param indexPath      l'index
 */
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ((CustomCellDeck*)[collectionView cellForItemAtIndexPath:indexPath]).img.alpha = 0.5;
    appDelegate.selectedDeck = indexPath.item;
    [self sendGetDetailsDeck];
}

/**
 *  Récupère les deck de l'utilisateur
 */
- (void)sendGetAllDecks
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GLID"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"nameOwner\r%@", appDelegate.user.auth_userName] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête get all deck
 *
 *  @param notification get all deck notification
 */
- (void)checkGetAllDecksResponse:(NSNotification *)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"SRC = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    [self storeAllDecks:response];
}

/**
 *  Ajouter un deck
 */
- (void)sendAddDeck
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"CRDK"] dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([self.realState selectedSegmentIndex] == 0)
        packet.data = [[NSString stringWithFormat:@"deckName\r%@\nnameOwner\r%@\nisReal\rTRUE", self.deckNameArea.text, appDelegate.user.auth_userName] dataUsingEncoding:NSUTF8StringEncoding];
    else
        packet.data = [[NSString stringWithFormat:@"deckName\r%@\nnameOwner\r%@\nisReal\rFALSE", self.deckNameArea.text, appDelegate.user.auth_userName] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête add deck
 *
 *  @param notification add deck notification
 */
- (void)checkAddDeckResponse:(NSNotification *)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"SRC = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    if ([response isEqualToString:@"OK"])
    {
        [appDelegate showAlertView:@"MagicTactil" withMessage:NSLocalizedString(@"CreateDeckOK", @"")];
        [self sendGetAllDecks];
    }
    else
        [JDStatusBarNotification showWithStatus:NSLocalizedString(@"CreateDeckKO", @"") dismissAfter:3 styleName:@"style02"];
}

/**
 *  Récupère les détails du deck
 */
- (void)sendGetDetailsDeck
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"SDTU"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"nameOwner\r%@\nidDeck\r%@", appDelegate.user.auth_userName, ((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).idDeck] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête get details deck
 *
 *  @param notification get details deck notification
 */
- (void)checkGetDetailsDeckResponse:(NSNotification *)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"SRC = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    [self storeDetailsDeck:response];
    [self presentViewController:detailDeck animated:YES completion:nil];
}

/**
 *  Sauvegarde les détails du deck
 *
 *  @param list liste du deck
 */
- (void)storeDetailsDeck:(NSString *)list
{
    [((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards removeAllObjects];
    NSArray   *array = [list componentsSeparatedByString:@"\n"];
    NSArray   *cut;
    int i = 0;
    CardObject *object;
    NSDictionary  *dic;
    NSDictionary *tmp;
    
    if ([array count] >= 3)
        [self loadCards];
    
    while (i < [array count])
    {
        cut = [array[i] componentsSeparatedByString:@"\r"];
        
        if ([cut[0] isEqualToString:@"idCard"])
        {
            object = [[CardObject alloc] init];
            dic = [appDelegate.listCards objectAtIndex:[cut[1] intValue]];
            object.idCard = cut[1];
            
            if([[dic objectForKey:@"set"] isKindOfClass:[NSDictionary class]])
            {
                tmp = [dic objectForKey:@"set"];
            }
            else
            {
                tmp = [[dic objectForKey:@"set"] objectAtIndex:0];
            }

        }
        else if ([cut[0] isEqualToString:@"nbCard"])
            object.nbCard = cut[1];
        else if ([cut[0] isEqualToString:@"isSided"])
        {
            object.isSided = cut[1];
            object.name = [dic objectForKey:@"name"];
            object.manacost = [dic objectForKey:@"manacost"];
            object.text = [dic objectForKey:@"text"];
            object.pt = [dic objectForKey:@"pt"];
            object.url = [tmp objectForKey:@"_picURL"];
            object.tableRow = [dic objectForKey:@"tablerow"];
            object.typeCard = [dic objectForKey:@"type"];
            
            [((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards addObject:object];
        }
        i++;
    }
}

/**
 *  Sauvegarde tous les decks
 *
 *  @param list liste de tous les decks
 */
- (void)storeAllDecks:(NSString *)list
{
    [appDelegate.listDecks removeAllObjects];
    NSArray   *array = [list componentsSeparatedByString:@"\n"];
    NSArray   *cut;
    int i = 0;
    DeckObject *object;
    
    while (i < [array count])
    {
        cut = [array[i] componentsSeparatedByString:@"\r"];
        
        if ([cut[0] isEqualToString:@"idDeck"])
        {
            object = [[DeckObject alloc] init];
            object.idDeck = cut[1];
        }
        else if ([cut[0] isEqualToString:@"deckName"])
            object.deckName = cut[1];
        else if ([cut[0] isEqualToString:@"isReal"])
        {
            object.isReal = cut[1];
            [appDelegate.listDecks addObject:object];
        }
        i++;
    }
    [self.collectionView reloadData];
}

/**
 *  Ajouter une deck
 *
 *  @param sender boutton ajouter un deck
 */
- (IBAction)clickAddDeck:(UIButton *)sender
{
    [self sendAddDeck];
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
 *  Ferme le clavier
 *
 *  @param sender textfield
 */
- (IBAction)closeKeyboard:(id)sender
{
    [sender resignFirstResponder];
}
@end
