//
//  Events.m
//  MagicTactil
//
//  Created by cedric on 16/04/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "Events.h"

@interface Events ()

@end

@implementation Events

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
    [self initObject];
    [self translate];
    [self sendGetAllEvents];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    self.labelEvents.text = NSLocalizedString(@"Events", @"");
    [self.bouttonAjouter setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
}

/**
 *  Affiche la vue
 *
 *  @param animated <#animated description#>
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [self.tableViewIpad reloadData];
}

/**
 *  Initialise les propriétés
 */
- (void)initObject
{
    sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    addEventIphone = [sb instantiateViewControllerWithIdentifier:@"addevent"];
    
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    addEventIpad = [sbIpad instantiateViewControllerWithIdentifier:@"addeventipad"];
    
    app = [[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetAllEventResponse:) name:@"GTAL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetEventResponse:) name:@"GETE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkIfSignUpEventResponse:) name:@"ISUE" object:nil];
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
    self.navBarLabel.frame = CGRectMake(0, 0, 320, 65);
    self.buttonBack.frame = CGRectMake(20, 13, 40, 40);
    self.buttonAdd.frame = CGRectMake(265, 14, 40, 40);
    self.labelTitle.frame = CGRectMake(73, 10, 175, 47);
    self.tableView.frame = CGRectMake(0, 65, 320, 415);
}

/**
 *  Redimmensionne l'écran 4 inch
 */
- (void)handle4
{
    self.navBarLabel.frame = CGRectMake(0, 0, 320, 65);
    self.buttonBack.frame = CGRectMake(20, 13, 40, 40);
    self.buttonAdd.frame = CGRectMake(265, 14, 40, 40);
    self.labelTitle.frame = CGRectMake(73, 10, 175, 47);
    self.tableView.frame = CGRectMake(0, 65, 320, 503);
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
 *  Récupère les évènements
 */
- (void)sendGetAllEvents
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GTAL"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"/"] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête get all events
 *
 *  @param notification get all events notification
 */
- (void)checkGetAllEventResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    //NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
    
    [self storeAllEvents:[[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]];
}

/**
 *  Sauvegarde les évènements
 *
 *  @param allEvents liste des évènements
 */
- (void)storeAllEvents:(NSString *)allEvents
{
    NSArray   *array = [allEvents componentsSeparatedByString:@"\n"];
    int i = 0;
    
    while (i < ([array count] - 1))
    {
        EventObject *event = [[EventObject alloc] init];
        
        event.name = array[i];
        [app.listEvents addObject:event];
        i++;
    }
    [self.tableView reloadData];
    [self.tableViewIpad reloadData];
}

/**
 *  Récupère les détails de l'évènement
 */
- (void)sendGetEvent
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GETE"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"name\r%@", ((EventObject*)app.listEvents[app.selectedEvent]).name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête get event
 *
 *  @param notification get event notification
 */
- (void)checkGetEventResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    //NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
    [self storeCurrentEvent:[[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]];
    [self sendIfSignUptEventRequest];
}

/**
 *  S'inscrit à l'évènement
 */
- (void)sendIfSignUptEventRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"ISUE"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"name\r%@\nusername\r%@", app.currentEvent.name, app.user.auth_userName] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie l'inscription à l'évènement
 *
 *  @param notification if sign up event notification
 */
- (void)checkIfSignUpEventResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        app.isSignup = TRUE;
    }
    else
    {
        app.isSignup = FALSE;
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];

    if (!(IDIOM == IPAD))
        [self presentViewController:addEventIphone animated:YES completion:nil];
    else
        [self presentViewController:addEventIpad animated:YES completion:nil];
}

/**
 *  Sauvegarde l'évènement
 *
 *  @param event description de l'évènement
 */
- (void)storeCurrentEvent:(NSString *)event
{
    NSArray   *array = [event componentsSeparatedByString:@"\n"];
    NSArray   *cut;
    EventObject *current = [[EventObject alloc] init];
    
    int i = 0;
    
    while (i < [array count])
    {
        cut = [array[i] componentsSeparatedByString:@"\r"];
        if ([cut[0] isEqualToString:@"id"])
            current.id = cut[1];
        else if ([cut[0] isEqualToString:@"creator"])
            current.creator = cut[1];
        else if ([cut[0] isEqualToString:@"name"])
            current.name = cut[1];
        else if ([cut[0] isEqualToString:@"description"])
            current.description = cut[1];
        else if ([cut[0] isEqualToString:@"date"])
            current.date = cut[1];
        else if ([cut[0] isEqualToString:@"location"])
            current.location = cut[1];
        i++;
    }
    app.currentEvent = current;
}

/**
 *  Ajouter un évènement
 *
 *  @param sender boutton ajouter évènement
 */
- (IBAction)clickAddEventIphone:(id)sender
{
    app.createEvent = TRUE;
    
    if (!(IDIOM == IPAD))
        [self presentViewController:addEventIphone animated:YES completion:nil];
    else
        [self presentViewController:addEventIpad animated:YES completion:nil];
}

/**
 *  Défini le nombre de sections
 *
 *  @param tableView tableView
 *
 *  @return le nombre de sections
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
    return ([app.listEvents count]);
}

/**
 *  Défini la cellule
 *
 *  @param tableView tableView
 *  @param indexPath l'index
 *
 *  @return retourne la cellule
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(IDIOM == IPAD))
    {
        static NSString *MyIdentifier = @"myCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
        EventObject       *object = [app.listEvents objectAtIndex:indexPath.row];
        cell.textLabel.text = object.name;
    
        return (cell);
    }
    else
    {
        static NSString *MyIdentifier = @"myCellIpad";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        EventObject       *object = [app.listEvents objectAtIndex:indexPath.row];
        cell.textLabel.text = object.name;
        
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
    app.selectedEvent = indexPath.row;
    app.createEvent = FALSE;
    [self sendGetEvent];
}

@end
