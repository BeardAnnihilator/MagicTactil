//
//  SignUp.m
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "SignUp.h"

@interface SignUp ()

@end

@implementation SignUp

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
 *  Traduit la vue
 */
- (void)translate {
    self.firstNameIpad.placeholder = NSLocalizedString(@"Firstname", @"");
    self.lastNameIpad.placeholder = NSLocalizedString(@"Lastname", @"");
    self.userNameIpad.placeholder = NSLocalizedString(@"Username", @"");
    self.passwordIpad.placeholder = NSLocalizedString(@"Password", @"");
    self.emailIpad.placeholder = NSLocalizedString(@"Email", @"");
    self.labelInscription.text = NSLocalizedString(@"SignUp", @"");
    [self.bouttonInscription setTitle:NSLocalizedString(@"Register", @"") forState:UIControlStateNormal];
}

/**
 *  Redimmensionne pour l'écran 3.5 pouces
 */
- (void)handle3_5
{
    
}

/**
 *  Redimmensionne pour l'écran 4 pouces
 */
- (void)handle4
{
    
}

/**
 *  Affiche une alerter à l'écran
 *
 *  @param title   titre de l'alerte
 *  @param message message de l'alerte
 */
- (void)showAlertView:(NSString *)title withMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSignUpResponse:) name:@"REGU" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSignInResponse:) name:@"SGNI" object:nil];
}

/**
 *  Remplis les information de facebook
 */
- (void)fillFacebookInformationsIphone
{
    self.firstNameIphone.text = appDelegate.user.firstName;
    self.lastNameIphone.text = appDelegate.user.lastName;
    self.emailIphone.text = appDelegate.user.email;
    
    self.firstNameIpad.text = appDelegate.user.firstName;
    self.lastNameIpad.text = appDelegate.user.lastName;
    self.emailIpad.text = appDelegate.user.email;
    
    self.checkIphone_01.hidden = NO;
    self.checkIphone_02.hidden = NO;
    self.checkIphone_05.hidden = NO;
    
    self.checkIpad_01.hidden = NO;
    self.checkIpad_02.hidden = NO;
    self.checkIpad_05.hidden = NO;
}

/**
 *  Vérifie la session facebook
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
                 [self fillFacebookInformationsIphone];
                 
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
 *  Retourne à la vue précédente
 *
 *  @param sender boutton retour
 */
- (IBAction)clickReturnIphone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Active la connexion facebook
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
        [self showAlertView:@"Systeme" withMessage:NSLocalizedString(@"SignUpInternet", @"")];
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
 *  Vérifie les champs pour l'inscription
 *
 *  @param sender textfield
 */
- (IBAction)checkTextFieldIphone:(id)sender
{
    if (![((UITextField*)sender).text isEqualToString:@""])
        switch (((UITextField*)sender).tag)
        {
            case 1:
                self.checkIphone_01.hidden = NO;
                self.checkIpad_01.hidden = NO;
                appDelegate.user.firstName = ((UITextField*)sender).text;
                break;
            case 2:
                self.checkIphone_02.hidden = NO;
                self.checkIpad_02.hidden = NO;
                appDelegate.user.lastName = ((UITextField*)sender).text;
                break;
            case 3:
                self.checkIphone_03.hidden = NO;
                self.checkIpad_03.hidden = NO;
                appDelegate.user.userName = ((UITextField*)sender).text;
                break;
            case 4:
                self.checkIphone_04.hidden = NO;
                self.checkIpad_04.hidden = NO;
                appDelegate.user.password = ((UITextField*)sender).text;
                break;
            case 5:
                self.checkIphone_05.hidden = NO;
                self.checkIpad_05.hidden = NO;
                appDelegate.user.email = ((UITextField*)sender).text;
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
             appDelegate.user.firstName = ((UITextField*)sender).text;
            break;
        case 2:
            self.checkIphone_02.hidden = YES;
            self.checkIpad_02.hidden = YES;
             appDelegate.user.lastName = ((UITextField*)sender).text;
            break;
        case 3:
            self.checkIphone_03.hidden = YES;
            self.checkIpad_03.hidden = YES;
             appDelegate.user.userName = ((UITextField*)sender).text;
            break;
        case 4:
            self.checkIphone_04.hidden = YES;
            self.checkIpad_04.hidden = YES;
             appDelegate.user.password = ((UITextField*)sender).text;
            break;
        case 5:
            self.checkIphone_05.hidden = YES;
            self.checkIpad_05.hidden = YES;
             appDelegate.user.email = ((UITextField*)sender).text;
            break;
        default:
            break;
    }
}

/**
 *  Envoie la requête de connexion
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
 *  Vérifie les champs de l'inscription
 *
 *  @return retourne le status
 */
- (BOOL)checkSignUpTextFieldIphone
{
    if ((self.checkIphone_03.hidden == NO) && (self.checkIphone_04.hidden == NO) && (self.checkIphone_05.hidden == NO))
        return (YES);
    else
        return (NO);
}

/**
 *  Met à jour les information de l'utilisateur
 */
- (void)updaUserInformations
{
    appDelegate.user.auth_firstName = appDelegate.user.firstName;
    appDelegate.user.auth_lastName = appDelegate.user.lastName;
    appDelegate.user.auth_userName = appDelegate.user.userName;
    appDelegate.user.auth_password = appDelegate.user.password;
    appDelegate.user.auth_email = appDelegate.user.email;
    appDelegate.user.auth_gender = appDelegate.user.gender;
    appDelegate.user.auth_phone = appDelegate.user.phone;
    appDelegate.user.auth_location = appDelegate.user.location;
    appDelegate.user.auth_birthday = appDelegate.user.birthday;
}

/**
 *  Vérifie la connexion
 *
 *  @param notification sign in notification
 */
- (void)checkSignInResponse:(NSNotification*)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        appDelegate.network.signUp = false;
        appDelegate.network.authentificationState = TRUE;
        [self updaUserInformations];
        [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignUpOK", @"")];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignUpKO", @"")];
    }
    
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
 *  @param notification sign up notification
 */
- (void)checkSignUpResponse:(NSNotification*)notification
{
    Packet *packet = [appDelegate.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        appDelegate.network.signUp = true;
        [self sendSignInRequest];
    }
    else
    {
        [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"SignUpKO", @"")];
    }
    
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [appDelegate.network.packetArray removeLastObject];
}

/**
 *  Envoie au serveur sign up
 */
- (void)sendSignUpRequestIphone
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"REGU"] dataUsingEncoding:NSUTF8StringEncoding];
    packet.data = [[NSString stringWithFormat:@"gender\r%@\ntelephone\r%@\nlocation\r%@\nbirthday\r%@\ngivenname\r%@\nname\r%@\nusername\r%@\nemail\r%@\npassword\r%@", appDelegate.user.gender, appDelegate.user.phone, appDelegate.user.location, appDelegate.user.birthday, appDelegate.user.lastName, appDelegate.user.firstName, appDelegate.user.userName, appDelegate.user.email, appDelegate.user.password] dataUsingEncoding:NSUTF8StringEncoding];
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [appDelegate.network sendPacket:packet];
}

/**
 *  Envoie l'inscription au serveur
 *
 *  @param sender boutton inscription
 */
- (IBAction)clickSignUpIphone:(id)sender
{
    if ([appDelegate.network checkInternetConnection] == true)
    {
        if (appDelegate.network.connectionState == TRUE)
        {
            if ([self checkSignUpTextFieldIphone] == YES)
            {
                [self sendSignUpRequestIphone];
            }
            else
            {
                [self showAlertView:@"Inscription" withMessage:NSLocalizedString(@"SignInFields", @""   )];
            }
        }
        else
            [self showAlertView:@"Serveur" withMessage:NSLocalizedString(@"ServerOut", @"")];
    }
    else
        [self showAlertView:@"Systeme" withMessage:NSLocalizedString(@"SignUpInternet", @"")];
}

/**
 *  Affiche la vue précédente
 *
 *  @param sender boutton retour
 */
- (IBAction)clickReturnIpad:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Envoie l'inscription au serveur
 *
 *  @param sender boutton inscription
 */
- (IBAction)clickSignUpIpad:(UIButton *)sender {
    if ([appDelegate.network checkInternetConnection] == true)
    {
        if (appDelegate.network.connectionState == TRUE)
        {
            if ([self checkSignUpTextFieldIpad] == YES)
            {
                if ([self checkFields])
                    [self sendSignUpRequestIphone];
            }
            else
            {
                [JDStatusBarNotification showWithStatus:NSLocalizedString(@"SignInFields", @"") dismissAfter:3 styleName:@"style02"];
            }
        }
        else
            [JDStatusBarNotification showWithStatus:NSLocalizedString(@"ServerOut", @"") dismissAfter:3 styleName:@"style02"];
    }
    else
        [JDStatusBarNotification showWithStatus:NSLocalizedString(@"SignUpInternet", @"") dismissAfter:3 styleName:@"style02"];
}

/**
 *  Vérifie les champs d'inscription
 *
 *  @return YES ou NO
 */
- (BOOL)checkFields {
    if ([self.passwordIpad.text length] >= 6)
        return (TRUE);
    else {
        [JDStatusBarNotification showWithStatus:NSLocalizedString(@"Password", @"") dismissAfter:3 styleName:@"style02"];
        return (NO);
    }
        
}

/**
 *  Vérifie les champs de l'inscription
 *
 *  @return renvoie le status de l'inscription
 */
- (BOOL)checkSignUpTextFieldIpad {
    if ((self.checkIpad_03.hidden == NO) && (self.checkIpad_04.hidden == NO) && (self.checkIpad_05.hidden == NO))
        return (YES);
    else
        return (NO);
}

@end
