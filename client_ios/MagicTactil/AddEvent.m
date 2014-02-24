//
//  AddEvent.m
//  MagicTactil
//
//  Created by cedric on 16/04/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "AddEvent.h"

@interface AddEvent ()

@end

@implementation AddEvent

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
    self.labelCreate.text = NSLocalizedString(@"", @"");
    [self.labelAddress setTitle:NSLocalizedString(@"Address", @"") forState:UIControlStateNormal];
    [self.labelDate setTitle:NSLocalizedString(@"Date", @"") forState:UIControlStateNormal];
    [self.labelDescription setTitle:NSLocalizedString(@"Description", @"") forState:UIControlStateNormal];
    [self.labelName setTitle:NSLocalizedString(@"Name", @"") forState:UIControlStateNormal];
    [self.buttonAddIpad setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
    [self.buttonDeleteIpad setTitle:NSLocalizedString(@"Delete", @"") forState:UIControlStateNormal];
    [self.buttonSignOutIpad setTitle:NSLocalizedString(@"Disconnection", @"") forState:UIControlStateNormal];
    [self.buttonSignUpIpad setTitle:NSLocalizedString(@"SignUp", @"") forState:UIControlStateNormal];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self checkCreateEvent];
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
    self.labelTitle.frame = CGRectMake(96, 18, 129, 47);
    self.buttonBack.frame = CGRectMake(20, 22, 40, 40);
    self.titleName.frame = CGRectMake(13, 88, 100, 27);
    self.titleDescription.frame = CGRectMake(13, 130, 100, 27);
    self.titleDate.frame = CGRectMake(13, 307, 100, 27);
    self.titleAddress.frame = CGRectMake(13, 341, 100, 27);
    self.nameIphone.frame = CGRectMake(121, 88, 179, 30);
    self.descriptionIphone.frame = CGRectMake(121, 130, 179, 169);
    self.dateIphone.frame = CGRectMake(121, 307, 186, 30);
    self.buttonAddIphone.frame = CGRectMake(110, 386, 101, 44);
    self.buttonSigninIphone.frame = CGRectMake(13, 386, 101, 44);
    self.buttonSignOutIphone.frame = CGRectMake(206, 386, 101, 44);
    self.buttonDeleteIphone.frame = CGRectMake(110, 433, 101, 44);
}

/**
 *  Redimmensionne l'écran 4 inch
 */
- (void)handle4
{
    self.navBarLabel.frame = CGRectMake(0, 0, 320, 65);
    self.labelTitle.frame = CGRectMake(96, 18, 129, 47);
    self.buttonBack.frame = CGRectMake(20, 22, 40, 40);
    self.titleName.frame = CGRectMake(13, 88, 100, 27);
    self.titleDescription.frame = CGRectMake(13, 130, 100, 27);
    self.titleDate.frame = CGRectMake(13, 307, 100, 27);
    self.titleAddress.frame = CGRectMake(13, 341, 100, 27);
    self.nameIphone.frame = CGRectMake(121, 88, 179, 30);
    self.descriptionIphone.frame = CGRectMake(121, 130, 179, 169);
    self.dateIphone.frame = CGRectMake(121, 307, 186, 30);
    self.buttonAddIphone.frame = CGRectMake(110, 430, 101, 44);
    self.buttonSigninIphone.frame = CGRectMake(13, 430, 101, 44);
    self.buttonSignOutIphone.frame = CGRectMake(206, 430, 101, 44);
    self.buttonDeleteIphone.frame = CGRectMake(110, 482, 101, 44);
}

/**
 *  Vérifie les champs pour créer un évèvenement
 */
- (void)checkCreateEvent
{
    if (app.createEvent == FALSE)
    {
        self.nameIphone.text = app.currentEvent.name;
        self.descriptionIphone.text = app.currentEvent.description;
        self.dateIphone.text = app.currentEvent.date;
        self.adressIphone.text = app.currentEvent.location;
        self.buttonAddIphone.alpha = 0;
        self.buttonDeleteIphone.alpha = 0;
        
        self.nameIpad.text = app.currentEvent.name;
        self.descriptionIpad.text = app.currentEvent.description;
        self.dateIpad.text = app.currentEvent.date;
        self.addressipad.text = app.currentEvent.location;
        self.buttonAddIpad.alpha = 0;
        self.buttonDeleteIpad.alpha = 0;
        
        if ([app.currentEvent.creator isEqualToString:app.user.auth_userName])
        {
            [self.buttonAddIphone setTitle:@"Editer" forState:UIControlStateNormal];
            self.buttonAddIphone.alpha = 1;
            self.buttonDeleteIphone.alpha = 1;
            self.buttonSigninIphone.alpha = 0;
            self.buttonSignOutIphone.alpha = 0;
            
            [self.buttonAddIpad setTitle:@"Editer" forState:UIControlStateNormal];
            self.buttonAddIpad.alpha = 1;
            self.buttonDeleteIpad.alpha = 1;
            self.buttonSignUpIpad.alpha = 0;
            self.buttonSignOutIpad.alpha = 0;
        }
        else
        {
            if (app.isSignup == TRUE)
            {
                self.buttonSigninIphone.alpha = 0;
                self.buttonSignOutIphone.alpha = 1;
                
                self.buttonSignUpIpad.alpha = 0;
                self.buttonSignOutIpad.alpha = 1;
            }
            else
            {
                self.buttonSigninIphone.alpha = 1;
                self.buttonSignOutIphone.alpha = 0;
                
                self.buttonSignUpIpad.alpha = 1;
                self.buttonSignOutIpad.alpha = 0;
            }
        }
    }
    else
    {
        self.nameIphone.text = @"";
        self.descriptionIphone.text = @"";
        self.dateIphone.text = @"";
        self.adressIphone.text = @"";
        self.buttonAddIphone.alpha = 1;
        self.buttonDeleteIphone.alpha = 0;
        self.buttonSignOutIphone.alpha = 0;
        self.buttonSigninIphone.alpha = 0;
        [self.buttonAddIphone setTitle:@"Ajouter" forState:UIControlStateNormal];
        
        self.nameIpad.text = @"";
        self.descriptionIpad.text = @"";
        self.dateIpad.text = @"";
        self.addressipad.text = @"";
        self.buttonAddIpad.alpha = 1;
        self.buttonDeleteIpad.alpha = 0;
        self.buttonSignOutIpad.alpha = 0;
        self.buttonSignUpIpad.alpha = 0;
        [self.buttonAddIpad setTitle:@"Ajouter" forState:UIControlStateNormal];
    }
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    app = [[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAddEventResponse:) name:@"CREV" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkEditEventResponse:) name:@"SNIE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkDeleteEventResponse:) name:@"DELE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSignInEventResponse:) name:@"SGUE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSignOutEventResponse:) name:@"SGOE" object:nil];
}

/**
 *  Vérifie le retour du serveur de la fonction add event
 *
 *  @param notification notification add event
 */
- (void)checkAddEventResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        EventObject *event = [[EventObject alloc] init];
        
        if (!(IDIOM == IPAD))
        {
            event.name = self.nameIphone.text;
            event.description = self.descriptionIphone.text;
            event.date = self.dateIphone.text;
            event.location = self.adressIphone.text;
            event.creator = app.user.auth_userName;
        }
        else
        {
            event.name = self.nameIpad.text;
            event.description = self.descriptionIpad.text;
            event.date = self.dateIpad.text;
            event.location = self.addressipad.text;
            event.creator = app.user.auth_userName;
        }
        
        [app.listEvents addObject:event];
        
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"CreateEventOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"CreateEventKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
}

/**
 *  Envoie la requette add event au serveur
 */
- (void)sendAddEventRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"CREV"] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!(IDIOM == IPAD))
        packet.data = [[NSString stringWithFormat:@"creator\r%@\nname\r%@\ncreatorEmail\r%@\ndescription\r%@\ndate\r%@\nlocation\r%@", app.user.auth_userName, self.nameIphone.text, app.user.auth_email, self.descriptionIphone.text, self.dateIphone.text, self.adressIphone.text] dataUsingEncoding:NSUTF8StringEncoding];
    else
        packet.data = [[NSString stringWithFormat:@"creator\r%@\nname\r%@\ncreatorEmail\r%@\ndescription\r%@\ndate\r%@\nlocation\r%@", app.user.auth_userName, self.nameIpad.text, app.user.auth_email, self.descriptionIpad.text, self.dateIpad.text, self.addressipad.text] dataUsingEncoding:NSUTF8StringEncoding];
        
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Envoie la requete edit event au serveur
 */
- (void)sendEditEventRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"SNIE"] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!(IDIOM == IPAD))
        packet.data = [[NSString stringWithFormat:@"name\r%@\nname\r%@\ndescription\r%@\ndate\r%@\nlocation\r%@", app.currentEvent.name, app.currentEvent.name, self.descriptionIphone.text, self.dateIphone.text, self.adressIphone.text] dataUsingEncoding:NSUTF8StringEncoding];
    else
        packet.data = [[NSString stringWithFormat:@"name\r%@\nname\r%@\ndescription\r%@\ndate\r%@\nlocation\r%@", app.currentEvent.name, app.currentEvent.name, self.descriptionIpad.text, self.dateIpad.text, self.addressipad.text] dataUsingEncoding:NSUTF8StringEncoding];
    
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requette edit event
 *
 *  @param notification edit event notification
 */
- (void)checkEditEventResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        EventObject *event = [[EventObject alloc] init];
        
        if (!(IDIOM == IPAD))
        {
            event.name = app.currentEvent.name;
            event.description = self.descriptionIphone.text;
            event.date = self.dateIphone.text;
            event.location = self.adressIphone.text;
            event.creator = app.user.auth_userName;
        }
        else
        {
            event.name = app.currentEvent.name;
            event.description = self.descriptionIpad.text;
            event.date = self.dateIpad.text;
            event.location = self.addressipad.text;
            event.creator = app.user.auth_userName;
        }
            
        [app.listEvents removeObjectAtIndex:app.selectedEvent];
        [app.listEvents addObject:event];
        
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"UpdateEventOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"UpdateEventKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
}

/**
 *  Envoie la requête delete event au serveur
 */
- (void)sendDeleteEventRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"DELE"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"name\r%@", app.currentEvent.name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête delete event
 *
 *  @param notification delete event notification
 */
- (void)checkDeleteEventResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        [app.listEvents removeObjectAtIndex:app.selectedEvent];
        
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"DeleteEventOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"DeleteEventKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject]; 
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Envoie la requête sign in event au serveur
 */
- (void)sendSignInEventRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"SGUE"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@\nname\r%@", app.user.auth_userName, app.currentEvent.name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Envoie la requête sign out event au serveur
 */
- (void)sendSignOutEventRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"SGOE"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@\nname\r%@", app.user.auth_userName, app.currentEvent.name] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie le retour du serveur de la requête sign in event
 *
 *  @param notification sign in event notification
 */
- (void)checkSignInEventResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignInEventOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignInEventKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject];
}

/**
 *  Vérifie le retour du serveur de la requête sign out event
 *
 *  @param notification sign out event notification
 */
- (void)checkSignOutEventResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignOutEventOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignOutEventKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [app.network.packetArray removeLastObject]; 
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuie sur le boutton retour
 *
 *  @param sender boutton retour
 */
- (IBAction)clickReturn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuie sur le boutton ajouter un évènement
 *
 *  @param sender boutton ajouter une évènement
 */
- (IBAction)clickAddIphone:(id)sender
{
    if ([self checkFields]) {
        if (app.createEvent)
            [self sendAddEventRequest];
        else if ([app.currentEvent.creator isEqualToString:app.user.auth_userName])
            [self sendEditEventRequest];
    }
}

/**
 *  Vérifie les champs pour ajouter un évènement
 *
 *  @return si c'est ok ou ko pour créer un évènement
 */
- (BOOL)checkFields {
    if (([self.nameIpad.text length] > 0) && ([self.descriptionIpad.text length] > 0) && ([self.dateIpad.text length] > 0) && ([self.addressipad.text length] > 0))
        return (YES);
    else {
        [JDStatusBarNotification showWithStatus:NSLocalizedString(@"FillAllFields", @"") dismissAfter:3 styleName:@"style02"];
        return (NO);
    }
}

/**
 *  Ferme le clavier
 *
 *  @param sender le textfield
 */
- (IBAction)closeKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

/**
 *  Supprime l'évènement
 *
 *  @param sender boutton suppression d'évènement
 */
- (IBAction)clickDeleteIphone:(UIButton *)sender
{
    [self sendDeleteEventRequest];
}

/**
 *  Envoie l'inscription à l'évènement
 *
 *  @param sender boutton inscription
 */
- (IBAction)clickSignIn:(UIButton *)sender
{
    [self sendSignInEventRequest];
}

/**
 *  Envoie désinscription de l'évènement
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickSignOut:(UIButton *)sender
{
    [self sendSignOutEventRequest];
}
@end
