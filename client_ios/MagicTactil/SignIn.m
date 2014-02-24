//
//  SignIn.m
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "SignIn.h"

@interface SignIn ()

@end

@implementation SignIn

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
    if (self) {
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
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSignInResponse:) name:@"SGNI" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSignOutResponse:) name:@"SGNO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkGetInfoUserResponse:) name:@"GETU" object:nil];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    self.userNameIpad.placeholder = NSLocalizedString(@"Username", @"");
    self.passwordIpad.placeholder = NSLocalizedString(@"Password", @"");
    self.labelConnexion.text = NSLocalizedString(@"SignIn", @"");
    [self.bouttonConnexion setTitle:NSLocalizedString(@"SignIn", @"") forState:UIControlStateNormal];
    [self.bouttonDeconnexion setTitle:NSLocalizedString(@"SignOut", @"") forState:UIControlStateNormal];
}

/**
 *  Affiche une alerte
 *
 *  @param title   Titre de l'alerte
 *  @param message description de l'alerte
 */
- (void)showAlertView:(NSString *)title withMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

/**
 *  Vérifie l'état de la connexion de facebook
 */
- (void)checkFacebookSession
{
    if (FBSession.activeSession.isOpen)
    {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error)
             {
                 appDelegate.user.firstName = user.first_name;
                 appDelegate.user.lastName = user.last_name;
                 appDelegate.user.facebookId = user.id;
                 appDelegate.user.email = [user objectForKey:@"email"];
                 
                 [facebookTimer invalidate];
                 facebookTimer = nil;
             }
         }];
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
 *  Affiche la vue précédente
 *
 *  @param sender boutton retour
 */
- (IBAction)clickReturnIphone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Met à jour les informations de facebook
 */
- (void)updateUserInformations
{
    appDelegate.user.auth_userName = self.userNameIphone.text;
    appDelegate.user.auth_password = self.passwordIphone.text;
    
    appDelegate.user.auth_userName = self.userNameIpad.text;
    appDelegate.user.auth_password = self.passwordIpad.text;
}

/**
 *  Sauvegarde les informations de la session
 *
 *  @param response details des informations
 */
- (void)storeUserInformations:(NSString*)response
{
    NSArray   *array = [response componentsSeparatedByString:@"\n"];
    NSArray   *cut;
    int i = 0;

    while (i < [array count])
    {
        cut = [array[i] componentsSeparatedByString:@"\r"];
        if ([cut[0] isEqualToString:@"username"])
            appDelegate.user.auth_userName = cut[1];
        else if ([cut[0] isEqualToString:@"gender"])
            appDelegate.user.auth_gender = cut[1];
        else if ([cut[0] isEqualToString:@"location"])
            appDelegate.user.auth_location = cut[1];
        else if ([cut[0] isEqualToString:@"password"])
            appDelegate.user.auth_password = cut[1];
        else if ([cut[0] isEqualToString:@"telephone"])
            appDelegate.user.auth_phone = cut[1];
        else if ([cut[0] isEqualToString:@"email"])
            appDelegate.user.auth_email = cut[1];
        else if ([cut[0] isEqualToString:@"name"])
            appDelegate.user.auth_firstName = cut[1];
        else if ([cut[0] isEqualToString:@"givenname"])
            appDelegate.user.auth_lastName = cut[1];
        i++;
    }
}

/**
 *  Récupère les informations de l'utilisateur
 *
 *  @param notification get infos user notification
 */
- (void)checkGetInfoUserResponse:(NSNotification *)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    [self storeUserInformations:response];
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
}

/**
 *  Vérifie l'inscription
 *
 *  @param notification sign in notification
 */
- (void)checkSignInResponse:(NSNotification*)notification
{
    if (appDelegate.network.signUp == false) {
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        appDelegate.network.authentificationState = TRUE;
        [self updateUserInformations];
        [self sendGetInfoUserRequest];
        [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignInOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignInKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
        [appDelegate.network.packetArray removeLastObject];
    }
}

/**
 *  Vérifie la déconnexion
 *
 *  @param notification sign out notification
 */
- (void)checkSignOutResponse:(NSNotification*)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        [appDelegate closeFacebookSession];
        appDelegate.network.authentificationState = FALSE;
        [self updateUserInformations];
        [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignOutOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignOutKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
}

/**
 *  Initialise une session facebook
 *
 *  @param sender boutton facebook
 */
- (IBAction)clickFacebookConnectIphone:(id)sender
{
    if ([appDelegate.network checkInternetConnection] == true)
    {
        if (FBSession.activeSession.isOpen)
        {
            [self showAlertView:@"Facebook" withMessage:@"Vos informations Facebook ont deja ete telecharges"];
        }
        else
        {
            facebookTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(checkFacebookSession) userInfo:nil repeats:YES];
            [appDelegate openFacebookSession];
        }
    }
    else
        [self showAlertView:@"Systeme" withMessage:NSLocalizedString(@"SignInInternet", @"")];
}

/**
 *  Se connecter sur iPhone
 *
 *  @param sender boutton sign in
 */
- (IBAction)clickSignInIphone:(id)sender
{
    if ([appDelegate.network checkInternetConnection] == true)
    {
        if (appDelegate.network.connectionState == TRUE)
        {
            if ([self checkSignInTextFieldIphone] == YES)
            {
                [self sendSignInRequest];
            }
            else
            {
                [self showAlertView:@"Connection" withMessage:NSLocalizedString(@"SignInFields", @"")];
            }
        }
        else
            [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"ServerOut", @"")];
    }
    else
        [self showAlertView:@"Systeme" withMessage:NSLocalizedString(@"SignInInternet", @"")];
}

/**
 *  Ferme le clavier
 *
 *  @param sender textfield
 */
- (IBAction)closeKeyboardIphone:(id)sender
{
    [self resignFirstResponder];
}

/**
 *  Envoie la connexion au serveur
 */
- (void)sendSignInRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"SGNI"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@\npassword\r%@", appDelegate.user.userName, appDelegate.user.password] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Envoie la deconnexion au serveur
 */
- (void)sendSignOutRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"SGNO"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@", appDelegate.user.auth_userName] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
 
    // TEMPORAIRE
    [appDelegate closeFacebookSession];
    appDelegate.network.authentificationState = FALSE;
    [self updateUserInformations];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Récupère les information de l'utilisateur
 */
- (void)sendGetInfoUserRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"GETU"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"username\r%@", appDelegate.user.auth_userName] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Vérifie les champs de connexion
 *
 *  @return retourne le status
 */
- (BOOL)checkSignInTextFieldIphone
{
    if ((self.checkIphone_01.hidden == NO) && (self.checkIphone_02.hidden == NO))
        return (YES);
    else
        return (NO);
}

/**
 *  Vérifie les champs de connexion
 *
 *  @param sender retourne le status
 */
- (IBAction)checktextFieldIphone:(id)sender
{
    if (![((UITextField*)sender).text isEqualToString:@""])
        switch (((UITextField*)sender).tag)
    {
        case 1:
            self.checkIphone_01.hidden = NO;
            self.checkIpad_01.hidden = NO;
            appDelegate.user.userName = ((UITextField*)sender).text;
            break;
        case 2:
            self.checkIphone_02.hidden = NO;
            self.checkIpad_02.hidden = NO;
            appDelegate.user.password = ((UITextField*)sender).text;
            break;
        default:
            break;
    }
    else
        switch (((UITextField*)sender).tag)
    {
        case 1:
            self.checkIphone_01.hidden = YES;
            self.checkIpad_01.hidden = YES;
            appDelegate.user.userName = ((UITextField*)sender).text;
            break;
        case 2:
            self.checkIphone_02.hidden = YES;
            self.checkIpad_02.hidden = YES;
            appDelegate.user.password = ((UITextField*)sender).text;
            break;
        default:
            break;
    }
}

/**
 *  Vérifie les champs de connexion
 *
 *  @return YES ou NO
 */
- (BOOL)checkFields {
    if ((self.checkIpad_01.hidden == NO) && (self.checkIpad_02.hidden == NO)) {
        if ([self.passwordIpad.text length] >= 6)
            return (YES);
        else {
            [JDStatusBarNotification showWithStatus:NSLocalizedString(@"password", @"") dismissAfter:3 styleName:@"style02"];
            return (NO);
        }
            
    }
    else
        [JDStatusBarNotification showWithStatus:NSLocalizedString(@"SignInFields", @"") dismissAfter:3 styleName:@"style02"];
        
    return (NO);
}

/**
 *  Envoie la requête connexion au serveur
 *
 *  @param sender button signin
 */
- (IBAction)clickSignInIpad:(UIButton *)sender {
    if ([appDelegate.network checkInternetConnection] == true)
    {
        if (appDelegate.network.connectionState == TRUE)
        {
            if ([self checkFields] == YES)
            {
                [self sendSignInRequest];
            }
        }
        else
            [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"ServerOut", @"")];
    }
    else
        [self showAlertView:@"Systeme" withMessage:NSLocalizedString(@"SignInInternet", @"")];
}

/**
 *  Affiche la vue précédente
 *
 *  @param sender button return
 */
- (IBAction)clickReturnIpad:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Se déconnecte du serveur
 *
 *  @param sender button signout
 */
- (IBAction)clickSignOutIphone:(id)sender
{
    if (appDelegate.network.authentificationState == YES)
    {
        [self sendSignOutRequest];
    }
    else
        [self showAlertView:@"Systeme" withMessage:NSLocalizedString(@"AlreadySignOut", @"")];
}
@end
