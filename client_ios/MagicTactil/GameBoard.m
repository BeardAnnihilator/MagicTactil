//
//  GameBoard.m
//  MagicTactil
//
//  Created by cedric on 22/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "GameBoard.h"

@interface GameBoard ()

@end

@implementation GameBoard

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
 *  Traduit la vue
 */
- (void)translate {
    self.handLabel.text = NSLocalizedString(@"Hand", @"");
    self.deckLabel.text = NSLocalizedString(@"Deck", @"");
    self.graveyardLabel.text = NSLocalizedString(@"Graveyard", @"");
    self.exiledLabel.text = NSLocalizedString(@"Exiled", @"");
    self.playerLabel.text = NSLocalizedString(@"PlayerZone", @"");
    self.opponentLabel.text = NSLocalizedString(@"OpponentZone", @"");
}

/**
 *  Initialise les objets
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    listDeck = [NSMutableArray array];
    listHand = [NSMutableArray array];
    listCardsOpponent = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkMoveCard:) name:@"MOVE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTapHorizontalCard:) name:@"TAPC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTapVerticalCard:) name:@"UTAP" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkupdatePoints:) name:@"UPGI" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLoose:) name:@"RSET" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLoose:) name:@"SYWL" object:nil];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self cleanGameBoard];
    
    [self initHand];
    [self initAudioPlayer];
    [self initPlayersNames];
    [self initCountersCards];
}

/**
 *  Initialise les compteur de points
 */
- (void)initCountersCards {
    NSArray *listCards = ((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards;
    
    cardsInDeck = [listCards count];
    cardsInExiled = 0;
    cardsInGraveyard = 0;
    
    self.labelCardsInDeck.text = [NSString stringWithFormat:@"%d", cardsInDeck];
    self.labelCardsInExiled.text = [NSString stringWithFormat:@"%d", cardsInExiled];
    self.labelCardsInGraveyard.text = [NSString stringWithFormat:@"%d", cardsInGraveyard];
}

/**
 *  initialise les joueurs
 */
- (void)initPlayersNames {
    self.labelMyPseudo.text = appDelegate.user.auth_userName;
    
    for (int i = 0; i < [appDelegate.listPlayers count]; i++) {
        NSString *opponent = appDelegate.listPlayers[i];
        
        if (![opponent isEqualToString:appDelegate.user.auth_userName]) {
            self.labelOpponent.text = opponent;
            break;
        }
    }
}

/**
 *  Défini les orientations supportées
 *
 *  @return Enum de l'orientation
 */
-(NSInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

/**
 *  Initialise la musique
 */
- (void)initAudioPlayer
{
    AudioSessionInitialize (NULL, NULL, NULL, (__bridge void *)self);
    
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof (sessionCategory), &sessionCategory);
    
    NSData *soundFileData;
    soundFileData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gameboard.mp3" ofType:NULL]]];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:soundFileData error:NULL];
    
    if(!([self.audioPlayer prepareToPlay]))
        NSLog(@"La méthode prepareToPlay a renvoyé la valeur FALSE");
    
    //self.audioPlayer.delegate = self;
    self.audioPlayer.numberOfLoops = -1;
    
    [self.audioPlayer setVolume:0.5];
    
    [self.audioPlayer play];
}

/**
 *  Initialise la main de jeu
 */
- (void)initHand
{
    NSArray *listCards = ((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards;
    CardObject *card;
    int i = 0;
    int x = 0;
    
    while (i < [listCards count])
    {
        card = listCards[i];
        
        __weak ButtonCard *button = [ButtonCard buttonWithType:UIButtonTypeCustom];
        [button initButtonCard];
        
        button.idGame = [NSString stringWithFormat:@"%d", i];
        button.idCard = [card.idCard intValue];
        card.idGame = [NSString stringWithFormat:@"%d", i];
        button.url = card.url;
        [button setImageWithURL:[NSURL URLWithString:button.url] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(x, 0, 92, 130);
        button.oldX = x;
        button.oldY = 0;
        
        [button addTarget:self action:@selector(buttonCardMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [button addTarget:self action:@selector(buttonCardMoved:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
        [button addTarget:self action:@selector(buttonCardTouchUp:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
        UIPinchGestureRecognizer *longTap = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTap:)];
        [button addGestureRecognizer:longTap];
        
        [self.deckZone addSubview:button];
        [listDeck addObject:button];
        [self.deckZone sendSubviewToBack:button];
        i++;
    }
}

/**
 *  Récupère la carte courrante de l'adversaire pour le switch
 *
 *  @param request requête
 */
- (void)getCurrentCardOpponentOnTap:(NSString *)request {
    NSArray   *array = [request componentsSeparatedByString:@"\n"];
    NSArray   *cut;
    int i = 0;
    __weak ButtonCard *object;
    
    while (i < [array count])
    {
        cut = [array[i] componentsSeparatedByString:@"\r"];
        
        if ([cut[0] isEqualToString:@"idCard"])
        {
            object = [ButtonCard buttonWithType:UIButtonTypeCustom];
            [object initButtonCard];
            object.idCard = [cut[1] intValue];
            object.idGame = cut[1];
        }
        else if ([cut[0] isEqualToString:@"source"])
            object.src = cut[1];
        else if ([cut[0] isEqualToString:@"destination"])
            object.dest = cut[1];
        else if ([cut[0] isEqualToString:@"X"]) {
            object.pourcentX = [cut[1] intValue];
        }
        else if ([cut[0] isEqualToString:@"Y"]) {
            object.pourcentY = [cut[1] intValue];
        }
        else if ([cut[0] isEqualToString:@"url"])
            object.url = cut[1];
        else if ([cut[0] isEqualToString:@"client_name"])
            object.clientName = cut[1];
        else if ([cut[0] isEqualToString:@"nameRoom"])
            object.roomName = cut[1];
        i++;
    }
        
    i = 0;
    currentCardOpponent = object;
        
    while (i < [listCardsOpponent count]) {
        if ([currentCardOpponent.idGame isEqualToString:((ButtonCard*)listCardsOpponent[i]).idGame]) {
            currentCardOpponent = listCardsOpponent[i];
            currentCardOpponent.src = object.src;
            currentCardOpponent.dest = object.dest;
        }
        i++;
    }
}

/**
 *  Récupère la carte courrante de l'adversaire pour le déplacement
 *
 *  @param request requête
 */
- (void)getCurrentCardOpponent:(NSString*)request {
    NSArray   *array = [request componentsSeparatedByString:@"\n"];
    NSArray   *cut;
    int i = 0;
    __weak ButtonCard *object;
    int x = 0;
    int y = 0;
    BOOL new = true;
    BOOL coor = false;
    
    while (i < [array count])
    {
        cut = [array[i] componentsSeparatedByString:@"\r"];
        
        if ([cut[0] isEqualToString:@"idCard"])
        {
            object = [ButtonCard buttonWithType:UIButtonTypeCustom];
            [object initButtonCard];
            object.idCard = [cut[1] intValue];
            object.idGame = cut[1];
        }
        else if ([cut[0] isEqualToString:@"source"])
            object.src = cut[1];
        else if ([cut[0] isEqualToString:@"destination"])
            object.dest = cut[1];
        else if ([cut[0] isEqualToString:@"X"]) {
            coor = true;
            object.pourcentX = [cut[1] intValue];
        }
        else if ([cut[0] isEqualToString:@"Y"]) {
            coor = true;
            object.pourcentY = [cut[1] intValue];
        }
        else if ([cut[0] isEqualToString:@"url"])
            object.url = cut[1];
        else if ([cut[0] isEqualToString:@"client_name"])
            object.clientName = cut[1];
        else if ([cut[0] isEqualToString:@"nameRoom"])
            object.roomName = cut[1];
        i++;
    }
    
    i = 0;
    currentCardOpponent = object;
    
    while (i < [listCardsOpponent count]) {
        if ([currentCardOpponent.idGame isEqualToString:((ButtonCard*)listCardsOpponent[i]).idGame]) {
            new = false;
            currentCardOpponent = listCardsOpponent[i];
            currentCardOpponent.src = object.src;
            currentCardOpponent.dest = object.dest;
        }
        i++;
    }
    
    if ([object.dest isEqualToString:@"Battlefield"]) {
        if (coor == true) {
            x = (object.pourcentX * self.playerZone.frame.size.width) / 100;
            y = (object.pourcentY * self.playerZone.frame.size.height) / 100;
        
            if (currentCardOpponent.isSided)
                currentCardOpponent.frame = CGRectMake(x, y, 130, 92);
            else
                currentCardOpponent.frame = CGRectMake(x, y, 92, 130);
        }
    
        if (new == true) {
            [currentCardOpponent setImageWithURL:[NSURL URLWithString:object.url] forState:UIControlStateNormal];
            [listCardsOpponent addObject:currentCardOpponent];
        }
    }
}

/**
 *  Gère la carte de l'adversaire
 */
- (void)handleCurrentCard {
    if ([currentCardOpponent.dest isEqualToString:@"Battlefield"]) {
        if (![currentCardOpponent.src isEqualToString:@"Battlefield"])
            [self.opponentZone addSubview:currentCardOpponent];
    }
    else if ([currentCardOpponent.dest isEqualToString:@"Hand"]) {
        if (![currentCardOpponent.src isEqualToString:@"Deck"])
            [currentCardOpponent removeFromSuperview];
    }
    else if ([currentCardOpponent.dest isEqualToString:@"Deck"]) {
        [currentCardOpponent removeFromSuperview];
    }
    else if ([currentCardOpponent.dest isEqualToString:@"Graveyard"]) {
        [currentCardOpponent removeFromSuperview];
    }
    else if ([currentCardOpponent.dest isEqualToString:@"Exile"]) {
        [currentCardOpponent removeFromSuperview];
    }
}

/**
 *  Envoie switch de la carte
 *
 *  @param request requête
 */
- (void)sendTapVerticalCard:(NSString *)request {
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"UTAP"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"%@", request] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le switch de la carte
 *
 *  @param notification switch cart notification
 */
- (void)checkTapVerticalCard:(NSNotification *)notification {
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    
    if ([response isEqualToString:@"OK"]) {
    }
    else {
        [self getCurrentCardOpponentOnTap:response];
        currentCardOpponent.transform = CGAffineTransformMakeRotation( ( 0 * M_PI ) / 180 );
        currentCardOpponent.isSided = NO;
    }
}

/**
 *  Envoie le switch de la carte
 *
 *  @param request requête
 */
- (void)sendTapHorizontalCard:(NSString *)request {
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"TAPC"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"%@", request] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie le switch de la carte
 *
 *  @param notification switch card notification
 */
- (void)checkTapHorizontalCard:(NSNotification *)notification {
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    
    if ([response isEqualToString:@"OK"]) {
    }
    else {
        [self getCurrentCardOpponentOnTap:response];
        currentCardOpponent.transform = CGAffineTransformMakeRotation( ( 90 * M_PI ) / 180 );
        currentCardOpponent.isSided = YES;
    }
}

/**
 *  Détecte le mouvement d'une carte de l'adversaire
 *
 *  @param notification move card notification
 */
- (void)checkMoveCard:(NSNotification *)notification {
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    
    if ([response isEqualToString:@"OK"]) {
    }
    else {
        [self getCurrentCardOpponent:response];
        [self handleCurrentCard];
    }
}

/**
 *  Envoie la requête move card au serveur lors du déplacement d'une carte
 *
 *  @param request la requête
 */
- (void)sendMoveCard:(NSString *)request {
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"MOVE"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"%@", request] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];

}

/**
 *  Affiche les details de la carte
 *
 *  @param gesture zoom
 */
- (void)handleLongTap:(UIGestureRecognizer*)gesture;
{
    ButtonCard *button = (ButtonCard*)gesture.view;
    
    if (button.isAnimating == NO)
    {
        if (button.isZoomed)
        {
            button.isZoomed = NO;
            button.isAnimating = YES;
            [UIView animateWithDuration:1
                             animations:^{
                                 button.frame = CGRectMake(button.oldX, button.oldY, 92, 130);
                             }
                             completion:^(BOOL finished){
                                 button.isAnimating = NO;
                             }
             ];
        }
        else
        {
            button.isZoomed = YES;
            button.isAnimating = YES;
            [UIView animateWithDuration:1
                             animations:^{
                                 button.frame = CGRectMake(button.oldX, button.oldY, 194, 260);
                             }
                             completion:^(BOOL finished){
                                 button.isAnimating = NO;
                             }
             ];
  
        }
    }
}

/**
 *  Gère l'intersection des zone de drag and drop
 *
 *  @param sender drag
 *  @param event  drop
 */
- (void)checkIntersection:(ButtonCard*)sender withEvent:(UIEvent*)event
{
    CGRect handFrame = [self.handZone frame];
    CGRect deckFrame = [self.deckZone frame];
    CGRect exiledFrame = [self.exiledZone frame];
    CGRect graveyardFrame = [self.graveyardZone frame];
    CGRect gameFrame = [self.playerZone frame];
    CGRect buttonCardFrame = [sender frame];
    CGRect handIntersection = CGRectIntersection(handFrame, buttonCardFrame);
    CGRect deckIntersection = CGRectIntersection(deckFrame, buttonCardFrame);
    CGRect exiledIntersection = CGRectIntersection(exiledFrame, buttonCardFrame);
    CGRect graveyardIntersection = CGRectIntersection(graveyardFrame, buttonCardFrame);
    CGRect gameIntersection = CGRectIntersection(gameFrame, buttonCardFrame);
    
    if (!CGRectIsNull(handIntersection))
        cardIntersection = HAND;
    else if (!CGRectIsNull(exiledIntersection))
        cardIntersection = EXILED;
    else if (!CGRectIsNull(graveyardIntersection))
        cardIntersection = GRAVEYARD;
    else if (!CGRectIsNull(gameIntersection))
        cardIntersection = GAME;
    else if (!CGRectIsNull(deckIntersection))
        cardIntersection = DECK;
    else
        cardIntersection = NILL;
    
    [self handleIntersection:sender withEvent:event];
}

/**
 *  Gère l'intersection avec la main
 *
 *  @param sender drag
 *  @param event  drop
 */
- (void)handleIntersectionHand:(ButtonCard *)sender withEvent:(UIEvent*)event
{
    NSLog(@"HAND");
    NSString *request = @"";
    NSString *srcPosition = @"";
    int x = 0;
    int y = 0;
    
    [self.handZone addSubview:sender];
        
    CGRect newFrame = [self.view convertRect:sender.frame toView:self.handZone];
    sender.frame = newFrame;
    
    [UIView animateWithDuration:1
                     animations:^{
                         sender.frame = CGRectMake(sender.frame.origin.x, 0, 92, 130);
                     }
                     completion:^(BOOL finished){
                     }
     ];
    
    switch (sender.oldPosition) {
        case HAND:
            srcPosition = @"Hand";
            break;
        case DECK:
            srcPosition = @"Deck";
            break;
        case GAME:
            srcPosition = @"Battlefield";
            break;
        case GRAVEYARD:
            srcPosition = @"Graveyard";
            break;
        case EXILED:
            srcPosition = @"Exile";
            break;
        default:
            break;
    }
    
    [sender resetArea];
    sender.isInHand = YES;
    sender.oldPosition = HAND;
    sender.oldX = sender.frame.origin.x;
    sender.oldY = sender.frame.origin.y;
    [listHand addObject:sender];
    
    x = (100 * sender.frame.origin.x) / self.playerZone.frame.size.width;
    y = (100 * sender.frame.origin.y) / self.playerZone.frame.size.height;
    request = [NSString stringWithFormat:@"idCard\r%@\nsource\r%@\ndestination\r%@\nX\r%d\nY\r%d\nurl\r%@\nclient_name\r%@\nnameRoom\r%@", sender.idGame, srcPosition, @"Hand", x, y, sender.url, appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name];
    [self sendMoveCard:request];
}

/**
 *  Gère l'intersection avec le cimetiere
 *
 *  @param sender drag
 *  @param event  drop
 */
- (void)handleIntersectionGraveyard:(ButtonCard *)sender withEvent:(UIEvent*)event
{
    NSLog(@"GRAVEYARD");
    NSString *request = @"";
    NSString *srcPosition = @"";
    int x = 0;
    int y = 0;
    
    cardsInGraveyard++;
    self.labelCardsInGraveyard.text = [NSString stringWithFormat:@"%d", cardsInGraveyard];
    
    [self.graveyardZone addSubview:sender];
    CGRect newFrame = [self.view convertRect:sender.frame toView:self.graveyardZone];
    sender.frame = newFrame;
    
    [UIView animateWithDuration:1
                     animations:^{
                         sender.frame = CGRectMake(0, 0, 92, 130);
                     }
                     completion:^(BOOL finished){
                     }
     ];
    
    switch (sender.oldPosition) {
        case HAND:
            srcPosition = @"Hand";
            break;
        case DECK:
            srcPosition = @"Deck";
            break;
        case GAME:
            srcPosition = @"Battlefield";
            break;
        case GRAVEYARD:
            srcPosition = @"Graveyard";
            break;
        case EXILED:
            srcPosition = @"Exile";
            break;
        default:
            break;
    }
    
    [sender resetArea];
    sender.isInGraveyard = YES;
    sender.oldPosition = GRAVEYARD;
    sender.oldX = sender.frame.origin.x;
    sender.oldY = sender.frame.origin.y;
    
    x = (100 * sender.frame.origin.x) / self.playerZone.frame.size.width;
    y = (100 * sender.frame.origin.y) / self.playerZone.frame.size.height;
    request = [NSString stringWithFormat:@"idCard\r%@\nsource\r%@\ndestination\r%@\nX\r%d\nY\r%d\nurl\r%@\nclient_name\r%@\nnameRoom\r%@", sender.idGame, srcPosition, @"Hand", x, y, sender.url, appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name];
    [self sendMoveCard:request];
}

/**
 *  Gère l'intersection avec l'exil
 *
 *  @param sender drag
 *  @param event  drop
 */
- (void)handleIntersectionExiled:(ButtonCard *)sender withEvent:(UIEvent*)event
{
    NSLog(@"EXILED");
    NSString *request = @"";
    NSString *srcPosition = @"";
    int x = 0;
    int y = 0;
    
    cardsInExiled++;
    self.labelCardsInExiled.text = [NSString stringWithFormat:@"%d", cardsInExiled];
    
    [self.exiledZone addSubview:sender];
    CGRect newFrame = [self.view convertRect:sender.frame toView:self.exiledZone];
    sender.frame = newFrame;
    
    [UIView animateWithDuration:1
                     animations:^{
                         sender.frame = CGRectMake(0, 0, 92, 130);
                     }
                     completion:^(BOOL finished){
                     }
     ];

    switch (sender.oldPosition) {
        case HAND:
            srcPosition = @"Hand";
            break;
        case DECK:
            srcPosition = @"Deck";
            break;
        case GAME:
            srcPosition = @"Battlefield";
            break;
        case GRAVEYARD:
            srcPosition = @"Graveyard";
            break;
        case EXILED:
            srcPosition = @"Exiled";
            break;
        default:
            break;
    }
    
    [sender resetArea];
    sender.isExiled= YES;
    sender.oldPosition = EXILED;
    sender.oldX = sender.frame.origin.x;
    sender.oldY = sender.frame.origin.y;
    
    x = (100 * sender.frame.origin.x) / self.playerZone.frame.size.width;
    y = (100 * sender.frame.origin.y) / self.playerZone.frame.size.height;
    request = [NSString stringWithFormat:@"idCard\r%@\nsource\r%@\ndestination\r%@\nX\r%d\nY\r%d\nurl\r%@\nclient_name\r%@\nnameRoom\r%@", sender.idGame, srcPosition, @"Hand", x, y, sender.url, appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name];
    [self sendMoveCard:request];
}

/**
 *  Gère l'intersection avec le deck
 *
 *  @param sender drag
 *  @param event  drop
 */
- (void)handleIntersectionDeck:(ButtonCard *)sender withEvent:(UIEvent*)event
{
    NSLog(@"DECK");
    NSString *request = @"";
    NSString *srcPosition = @"";
    int x = 0;
    int y = 0;
    
    cardsInDeck++;
    self.labelCardsInDeck.text = [NSString stringWithFormat:@"%d", cardsInDeck];
    
    [self.deckZone addSubview:sender];
    CGRect newFrame = [self.view convertRect:sender.frame toView:self.deckZone];
    sender.frame = newFrame;
    
    [UIView animateWithDuration:1
                     animations:^{
                         sender.frame = CGRectMake(0, 0, 92, 130);
                     }
                     completion:^(BOOL finished){
                         [self.deckZone sendSubviewToBack:sender];
                     }
     ];
    
    switch (sender.oldPosition) {
        case HAND:
            srcPosition = @"Hand";
            break;
        case DECK:
            srcPosition = @"Deck";
            break;
        case GAME:
            srcPosition = @"Battlefield";
            break;
        case GRAVEYARD:
            srcPosition = @"Graveyard";
            break;
        case EXILED:
            srcPosition = @"Exiled";
            break;
        default:
            break;
    }
    
    if (sender.oldPosition == HAND)
        [listHand removeObject:sender];
        
    [sender resetArea];
    sender.isInDeck = YES;
    sender.oldPosition = DECK;
    sender.oldX = sender.frame.origin.x;
    sender.oldY = sender.frame.origin.y;
    [listDeck addObject:sender];
    
    x = (100 * sender.frame.origin.x) / self.playerZone.frame.size.width;
    y = (100 * sender.frame.origin.y) / self.playerZone.frame.size.height;
    request = [NSString stringWithFormat:@"idCard\r%@\nsource\r%@\ndestination\r%@\nX\r%d\nY\r%d\nurl\r%@\nclient_name\r%@\nnameRoom\r%@", sender.idGame, srcPosition, @"Hand", x, y, sender.url, appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name];
    [self sendMoveCard:request];
}

/**
 *  Gère l'intersection avec le jeu
 *
 *  @param sender drag
 *  @param event  drop
 */
- (void)handleIntersectionGame:(ButtonCard *)sender withEvent:(UIEvent*)event
{
    NSLog(@"GAME");
    NSString *request = @"";
    NSString *srcPosition = @"";
    int x = 0;
    int y = 0;
    
    [self.playerZone addSubview:sender];
        
    CGRect newFrame = [self.view convertRect:sender.frame toView:self.playerZone];
    sender.frame = newFrame;
        
    [sender resetArea];
    sender.isInGame = YES;
    sender.oldX = sender.frame.origin.x;
    sender.oldY = sender.frame.origin.y;
    
    switch (sender.oldPosition) {
        case HAND:
            srcPosition = @"Hand";
            break;
        case DECK:
            srcPosition = @"Deck";
            break;
        case GAME:
            srcPosition = @"Battlefield";
            break;
        case GRAVEYARD:
            srcPosition = @"Graveyard";
            break;
        case EXILED:
            srcPosition = @"Exile";
            break;
        default:
            break;
    }
    sender.oldPosition = GAME;
    
    x = (100 * sender.frame.origin.x) / self.playerZone.frame.size.width;
    y = (100 * sender.frame.origin.y) / self.playerZone.frame.size.height;
    request = [NSString stringWithFormat:@"idCard\r%@\nsource\r%@\ndestination\r%@\nX\r%d\nY\r%d\nurl\r%@\nclient_name\r%@\nnameRoom\r%@", sender.idGame, srcPosition, @"Battlefield", x, y, sender.url, appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name];
    [self sendMoveCard:request];
}

/**
 *  Gère l'intersection avec une zone interdite
 *
 *  @param sender drag
 *  @param event  drop
 */
- (void)handleIntersectionNill:(ButtonCard *)sender withEvent:(UIEvent *)event
{
    NSLog(@"NILL");
    
    if (sender.oldPosition == HAND)
    {
        CGRect newFrame;
        
        [self.handZone addSubview:sender];
        newFrame = [self.view convertRect:sender.frame toView:self.handZone];
        
        sender.frame = CGRectMake(sender.oldX, sender.oldY, 92, 130);
        [sender resetArea];
        sender.isInHand = YES;
    }
    else if (sender.oldPosition == GAME)
    {
        CGRect newFrame;
        
        [self.playerZone addSubview:sender];
        newFrame = [self.view convertRect:sender.frame toView:self.playerZone];
        
        sender.frame = CGRectMake(sender.oldX, sender.oldY, 92, 130);
        [sender resetArea];
        sender.isInGame = YES;
    }
    else if (sender.oldPosition == DECK)
    {
        CGRect newFrame;
        
        [self.deckZone addSubview:sender];
        newFrame = [self.view convertRect:sender.frame toView:self.deckZone];
        
        sender.frame = CGRectMake(sender.oldX, sender.oldY, 92, 130);
        [sender resetArea];
        sender.isInDeck = YES;
    }

    else if (sender.oldPosition == GRAVEYARD)
    {
        CGRect newFrame;
        
        [self.graveyardZone addSubview:sender];
        newFrame = [self.view convertRect:sender.frame toView:self.graveyardZone];
        
        sender.frame = CGRectMake(sender.oldX, sender.oldY, 92, 130);
        [sender resetArea];
        sender.isInGraveyard = YES;
    }
    else if (sender.oldPosition == EXILED)
    {
        CGRect newFrame;
        
        [self.exiledZone addSubview:sender];
        newFrame = [self.view convertRect:sender.frame toView:self.exiledZone];
        
        sender.frame = CGRectMake(sender.oldX, sender.oldY, 92, 130);
        [sender resetArea];
        sender.isExiled = YES;
    }
}

/**
 *  Gère les intersections
 *
 *  @param sender drag
 *  @param event  drop
 */
- (void)handleIntersection:(ButtonCard *)sender withEvent:(UIEvent*)event
{
    if (cardIntersection == HAND)
        [self handleIntersectionHand:sender withEvent:event];
    else if (cardIntersection == GAME)
        [self handleIntersectionGame:sender withEvent:event];
    else if (cardIntersection == GRAVEYARD)
        [self handleIntersectionGraveyard:sender withEvent:event];
    else if (cardIntersection == EXILED)
        [self handleIntersectionExiled:sender withEvent:event];
    else if (cardIntersection == DECK)
        [self handleIntersectionDeck:sender withEvent:event];
    else if (cardIntersection == NILL)
        [self handleIntersectionNill:sender withEvent:event];
}

/**
 *  Envoie le switch de la carte
 *
 *  @param sender drag
 *  @param event  drop
 */
- (IBAction)buttonCardTouchUp:(ButtonCard*)sender withEvent:(UIEvent*)event
{
    NSString *request = @"";
    if (sender.drag)
        [self checkIntersection:sender withEvent:event];
    else
    {
        if (sender.oldPosition == GAME)
        {
            if (sender.isSided)
            {
                sender.transform = CGAffineTransformMakeRotation( ( 0 * M_PI ) / 180 );
                sender.isSided = NO;
                request = [NSString stringWithFormat:@"idCard\r%@\nclient_name\r%@\nnameRoom\r%@", sender.idGame, appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name];
                [self sendTapVerticalCard:request];
            }
            else
            {
                sender.transform = CGAffineTransformMakeRotation( ( 90 * M_PI ) / 180 );
                sender.isSided = YES;
                request = [NSString stringWithFormat:@"idCard\r%@\nclient_name\r%@\nnameRoom\r%@", sender.idGame, appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name];
                [self sendTapHorizontalCard:request];
            }
        }
    }
    sender.drag = NO;
}

/**
 *  Déplace la carte
 *
 *  @param sender drag
 *  @param event  drop
 */
- (IBAction)buttonCardMoved:(ButtonCard*)sender withEvent:(UIEvent*)event
{
    sender.drag = YES;
    if (sender.isInView)
    {
        CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
        UIControl *control = sender;
        control.center = point;
    }
    else
    {
        if (sender.isInGame || sender.isInHand || sender.isInGraveyard || sender.isExiled || sender.isInDeck)
        {
            CGRect newFrame;
        
            [self.view addSubview:sender];
        
            if (sender.isInHand)
            {
                newFrame = [self.handZone convertRect:sender.frame toView:self.view];
                [listHand removeObject:sender];
            }
            else if (sender.isInGame)
                newFrame = [self.playerZone convertRect:sender.frame toView:self.view];
            else if (sender.isInGraveyard) {
                newFrame = [self.graveyardZone convertRect:sender.frame toView:self.view];
                cardsInGraveyard--;
                self.labelCardsInGraveyard.text = [NSString stringWithFormat:@"%d", cardsInGraveyard];
            }
            else if (sender.isExiled) {
                newFrame = [self.exiledZone convertRect:sender.frame toView:self.view];
                cardsInExiled--;
                self.labelCardsInExiled.text = [NSString stringWithFormat:@"%d", cardsInExiled];
            }
            else if (sender.isInDeck) {
                newFrame = [self.deckZone convertRect:sender.frame toView:self.view];
                cardsInDeck--;
                self.labelCardsInDeck.text = [NSString stringWithFormat:@"%d", cardsInDeck];
            }
            
            sender.frame = newFrame;
            [sender resetArea];
            sender.isInView = YES;
        }
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
 *  Pioche une carte
 *
 *  @param sender boutton card
 */
- (IBAction)clickDeck:(UIButton *)sender
{
    if ([listDeck count] > 0)
    {
        cardsInDeck--;
        self.labelCardsInDeck.text = [NSString stringWithFormat:@"%d", cardsInDeck];
        ButtonCard *card = [listDeck objectAtIndex:0];
        int x = 0;
        int i = 0;
        [listDeck removeObjectAtIndex:0];
    
        while (i < [listHand count])
        {
            ButtonCard *object = [listHand objectAtIndex:i];
            
            if (object.oldX >= x)
                x = object.oldX + 102;
            
            i++;
        }
    
        card.oldX = x;
        [self.handZone addSubview:card];
        card.frame = CGRectMake(x, 0, 92, 130);
        [listHand addObject:card];
        [card resetArea];
        card.isInHand = YES;
        card.oldPosition = HAND;
        
        self.handZone.contentSize = CGSizeMake(x + 92, 130);
        
        NSString *request = [NSString stringWithFormat:@"idCard\r%@\nsource\r%@\ndestination\r%@\nX\r%d\nY\r%d\nurl\r%@\nclient_name\r%@\nnameRoom\r%@", card.idGame, @"Deck", @"Hand", 0, 0, card.url, appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name];
        [self sendMoveCard:request];
    }
}

/**
 *  Met à jour les points
 *
 *  @param request nombre de points
 */
- (void)sendUpdatePoints:(NSString *)request {
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"UPGI"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"%@", request] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie la mise à jour des points
 *
 *  @param notification update health points notification
 */
- (void)checkupdatePoints:(NSNotification *)notification {
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
    
    if ([response isEqualToString:@"OK"]) {
    }
    else {
        NSArray   *array = [response componentsSeparatedByString:@"\n"];
        NSArray   *cut;
        int i = 0;
        
        while (i < [array count])
        {
            cut = [array[i] componentsSeparatedByString:@"\r"];
            
            if ([cut[0] isEqualToString:@"healthpoints"])
                self.labelPointsOpponent.text = cut[1];
            i++;
        }
    }
}

/**
 *  Met à jour les points
 *
 *  @param sender uistepper
 */
- (IBAction)changePoints:(UIStepper *)sender {
    self.labelPoints.text = [NSString stringWithFormat:@"%d", (int)[sender value]];
    [self sendUpdatePoints:[NSString stringWithFormat:@"client_name\r%@\nnameRoom\r%@\nhealthpoints\r%@\nmarqueurs\r0", appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name, self.labelPoints.text]];
}

/**
 *  Envoie abandon de la partie
 *
 *  @param request requête
 */
- (void)sendLoose:(NSString *)request {
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"RSET"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"%@", request] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie l'abandon de la partie
 *
 *  @param notification loose notification
 */
- (void)checkLoose:(NSNotification *)notification {
    //[JDStatusBarNotification showWithStatus:@"Votre adversaire a quitter la partie" dismissAfter:3 styleName:@"style02"];
    
    [appDelegate.network.packetArray removeLastObject];
    
    [self.audioPlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Abandonner la partie
 *
 *  @param sender boutton abandon
 */
- (IBAction)clickLoose:(UIButton *)sender {
    [self sendLoose:[NSString stringWithFormat:@"client_name\r%@\nnameRoom\r%@", appDelegate.user.auth_userName, ((RoomObject*)appDelegate.listRoom[appDelegate.selectedRoom]).name]];
    
    [self.audioPlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Nettoie le plateau de jeu
 */
- (void)cleanGameBoard {
    for (int i = 0; i < [listDeck count]; i++) {
        ButtonCard *card = listDeck[i];
        
        [card removeFromSuperview];
    }
    for (int i = 0; i < [listHand count]; i++) {
        ButtonCard *card = listHand[i];
        
        [card removeFromSuperview];
    }
    for (int i = 0; i < [listCardsOpponent count]; i++) {
        ButtonCard *card = listCardsOpponent[i];
        
        [card removeFromSuperview];
    }
    
    [listDeck removeAllObjects];
    [listHand removeAllObjects];
    [listCardsOpponent removeAllObjects];
    
    NSArray *subviews = [self.playerZone subviews];
    if ([subviews count] == 0)
        return;
    for (UIView *card in subviews) {
        if ([card isKindOfClass:[ButtonCard class]]) {
            [card removeFromSuperview];
        }
    }
    
    subviews = [self.graveyardZone subviews];
    if ([subviews count] == 0)
        return;
    for (UIView *card in subviews) {
        if ([card isKindOfClass:[ButtonCard class]]) {
            [card removeFromSuperview];
        }
    }
    
    subviews = [self.exiledZone subviews];
    if ([subviews count] == 0)
        return;
    for (UIView *card in subviews) {
        if ([card isKindOfClass:[ButtonCard class]]) {
            [card removeFromSuperview];
        }
    }
    
    subviews = [self.handZone subviews];
    if ([subviews count] == 0)
        return;
    for (UIView *card in subviews) {
        if ([card isKindOfClass:[ButtonCard class]]) {
            [card removeFromSuperview];
        }
    }
}

@end
