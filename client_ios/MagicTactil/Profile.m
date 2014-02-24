//
//  Profile.m
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "Profile.h"

@interface Profile ()

@end

@implementation Profile

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
 *  Traduit la vue
 */
- (void)translate {
    self.labelProfile.text = NSLocalizedString(@"Profile", @"");
    self.userNameIpad.placeholder = NSLocalizedString(@"Username", @"");
    self.firstNameIpad.placeholder = NSLocalizedString(@"Firstname", @"");
    self.lastNameIpad.placeholder = NSLocalizedString(@"LastName", @"");
    self.addressIPad.placeholder = NSLocalizedString(@"Address", @"");
    self.emailIpad.placeholder = NSLocalizedString(@"Email", @"");
    self.passwordIpad.placeholder = NSLocalizedString(@"Password", @"");
    self.phoneIpad.placeholder = NSLocalizedString(@"Phone", @"");
    [self.buttonUpdate setTitle:NSLocalizedString(@"Update", @"") forState:UIControlStateNormal];
}

/**
 *  Affiche la vue
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self updateInformations];
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
 *  Redimensionne l'écran 4 inch
 */
- (void)handle4
{
    self.scrollView.contentSize = CGSizeMake(320, 650);
    
    self.navBarlabel.frame = CGRectMake(0, 0, 320, 65);
    self.labelTitle.frame = CGRectMake(114, 18, 92, 47);
    self.scrollView.frame = CGRectMake(0, 65, 320, 455);
}

/**
 *  Redimensionne l'écran 3.5 inch
 */
- (void)handle3_5
{
    self.scrollView.contentSize = CGSizeMake(320, 558);
    
    self.navBarlabel.frame = CGRectMake(0, 0, 320, 65);
    self.labelTitle.frame = CGRectMake(114, 18, 92, 47);
    self.scrollView.frame = CGRectMake(0, 65, 320, 365);
}

/**
 *  Cette méthode est appelé quand le vue va bientôt disparaître
 *
 *  @param animated avec ou sans animation
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [self.scrollView setContentOffset:CGPointMake(0,0) animated:NO];
}

/**
 *  Met à jour les information de la session
 */
- (void)updateInformations
{
    self.pseudo.text = app.user.auth_userName;
    self.prenom.text = app.user.auth_firstName;
    self.nom.text = app.user.auth_lastName;
    self.email.text = app.user.auth_email;
    self.adresse.text = app.user.auth_location;
    self.telephone.text = app.user.auth_phone;
    self.mdp.text = app.user.auth_password;
    
    self.userNameIpad.text = app.user.auth_userName;
    self.firstNameIpad.text = app.user.auth_firstName;
    self.lastNameIpad.text = app.user.auth_lastName;
    self.emailIpad.text = app.user.auth_email;
    self.addressIPad.text = app.user.auth_location;
    self.phoneIpad.text = app.user.auth_phone;
    self.passwordIpad.text = app.user.auth_password;
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    app = [[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSetInfoUserResponse:) name:@"SETU" object:nil];
}

/**
 *  Récupère les informations de la session
 */
- (void)sendSetInfoUserRequest
{
    Packet      *packet = [[Packet alloc] init];
    int sizeData;
    int srcInt = 5;
    int destInt = 8;
    
    packet.src = [NSData dataWithBytes:&srcInt length:sizeof(srcInt)];
    packet.dest = [NSData dataWithBytes:&destInt length:sizeof(destInt)];
    packet.func = [[NSString stringWithFormat:@"SETU"] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!(IDIOM == IPAD))
        packet.data = [[NSString stringWithFormat:@"username\r%@\npassword\r%@\nemail\r%@\ntelephone\r%@\nlocation\r%@", app.user.auth_userName, self.mdp.text, self.email.text, self.telephone.text, self.adresse.text] dataUsingEncoding:NSUTF8StringEncoding];
   else
       packet.data = [[NSString stringWithFormat:@"username\r%@\npassword\r%@\nemail\r%@\ntelephone\r%@\nlocation\r%@", app.user.auth_userName, self.passwordIpad.text, self.emailIpad.text, self.phoneIpad.text, self.addressIPad.text] dataUsingEncoding:NSUTF8StringEncoding];
    
    sizeData = [packet.data length];
    packet.dataSize = [NSData dataWithBytes:&sizeData length:sizeof(sizeData)];
    
    [app.network sendPacket:packet];
}

/**
 *  Vérifie la récupération des informations de la session
 *
 *  @param notification get infos user notification
 */
- (void)checkSetInfoUserResponse:(NSNotification *)notification
{
    Packet *packet = [app.network.packetArray objectAtIndex:0];
    NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
    
    if ([response isEqualToString:@"OK"])
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"UpdateProfileOK", @"")];
    }
    else
    {
        [app showAlertView:@"Serveur" withMessage:NSLocalizedString(@"UpdateProfileKO", @"")];
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
 *  Ferme le clavier
 *
 *  @param sender textfield
 */
- (IBAction)closeKeyboardIphone:(id)sender
{
    [sender resignFirstResponder];
}

/**
 *  met à jour les informations de la session
 *
 *  @param sender boutton update
 */
- (IBAction)clickUpdate:(id)sender
{
    [self sendSetInfoUserRequest];
}
@end
