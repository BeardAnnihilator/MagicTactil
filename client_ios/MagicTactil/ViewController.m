//
//  ViewController.m
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 *  Charge la vue
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initObjects];
    [self translate];
    
    [self setTabBarItemColor];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    self.labelHome.text = NSLocalizedString(@"Home", @"");
    [self.bouttonInscription setTitle:NSLocalizedString(@"SignUp", @"") forState:UIControlStateNormal];
    [self.bouttonConnexion setTitle:NSLocalizedString(@"SignIn", @"") forState:UIControlStateNormal];
    [self.buttonStateIpad setTitle:NSLocalizedString(@"Disconnected", @"") forState:UIControlStateNormal];
    
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:NSLocalizedString(@"Home", @"")];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:NSLocalizedString(@"Game", @"")];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:NSLocalizedString(@"Social", @"")];
    [[self.tabBarController.tabBar.items objectAtIndex:3] setTitle:NSLocalizedString(@"Profile", @"")];
}

/**
 *  Initialise les onglets en fonction de l'état de la connexion
 */
- (void)setTabBarItemColor
{
    if ([UITabBar instancesRespondToSelector:@selector(setSelectedImageTintColor:)])
    {
        //[self.tabBarController.tabBar setSelectedImageTintColor:[[UIColor alloc] initWithRed:0 green:0.8 blue:1.0 alpha:1.0]];
        [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.953 green:0.612 blue:0.071 alpha:1.0]];
    }
}

/**
 *  Initialises les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    sbIphone = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    signInIphone = [sbIphone instantiateViewControllerWithIdentifier:@"SignInIphone"];
    signUpIphone = [sbIphone instantiateViewControllerWithIdentifier:@"SignUpIphone"];
    signInIpad = [sbIpad instantiateViewControllerWithIdentifier:@"SignInIpad"];
    signUpIpad = [sbIpad instantiateViewControllerWithIdentifier:@"SignUpIpad"];
}

/**
 *  Affiche la vue
 *
 *  @param animated Affichage avec animation
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self updateLabelAuthentificationIphone];
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
 *  Redimmensionne les vues en fonction du device (3.5 inch)
 */
- (void)handle3_5
{
    self.buttonSignUp.frame = CGRectMake(20, 18, 40, 40);
    self.buttonSignIn.frame = CGRectMake(260, 18, 40, 40);
    self.navBarLabel.frame = CGRectMake(0, 0, 320, 65);
    self.labelTitle.frame = CGRectMake(103, 14, 115, 47);
    self.labelState.frame = CGRectMake(0, 65, 320, 20);
}

/**
 *  Redimmensionne les vues en fonction du device (4 inch)
 */
- (void)handle4
{
    self.buttonSignUp.frame = CGRectMake(20, 18, 40, 40);
    self.buttonSignIn.frame = CGRectMake(260, 18, 40, 40);
    self.navBarLabel.frame = CGRectMake(0, 0, 320, 65);
    self.labelTitle.frame = CGRectMake(103, 14, 115, 47);
    self.labelState.frame = CGRectMake(0, 65, 320, 20);
}

/**
 *  Met à jour les informations de la vue (les onglets, le status)
 */
- (void)updateLabelAuthentificationIphone
{
    if (appDelegate.network.authentificationState == FALSE)
    {
        [self.buttonStateIpad setTitle:NSLocalizedString(@"Disconnected", @"") forState:UIControlStateNormal];
        [self.buttonStateIphone setTitle:NSLocalizedString(@"Disconnected", @"") forState:UIControlStateNormal];
        
        [[[self.tabBarController.tabBar items] objectAtIndex:1] setEnabled:NO];
        [[[self.tabBarController.tabBar items] objectAtIndex:2] setEnabled:NO];
        [[[self.tabBarController.tabBar items] objectAtIndex:3] setEnabled:NO];
    }
    else
    {
        [self.buttonStateIpad setTitle:NSLocalizedString(@"Connected", @"") forState:UIControlStateNormal];
        [self.buttonStateIphone setTitle:NSLocalizedString(@"Connected", @"") forState:UIControlStateNormal];
        
        [[[self.tabBarController.tabBar items] objectAtIndex:1] setEnabled:YES];
        [[[self.tabBarController.tabBar items] objectAtIndex:2] setEnabled:YES];
        [[[self.tabBarController.tabBar items] objectAtIndex:3] setEnabled:YES];
    }
}

/**
 *  Libère de la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton de connexion iPhone
 *
 *  @param sender le boutton de connexion iPhone
 */
- (IBAction)clickSignInIphone:(id)sender
{
    [self presentViewController:signInIphone animated:YES completion:nil];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton d'inscription iPad
 *
 *  @param sender le boutton d'inscription iPad
 */
- (IBAction)clickSignUpIpad:(id)sender
{
    [self presentViewController:signUpIpad animated:YES completion:nil];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton de connexion iPad
 *
 *  @param sender le boutton de connexion iPad
 */
- (IBAction)clickSignInIpad:(id)sender
{
    [self presentViewController:signInIpad animated:YES completion:nil];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton d'inscription iPhone
 *
 *  @param sender le boutton d'inscription iPhone
 */
- (IBAction)clickSignUpIphone:(id)sender
{
    [self presentViewController:signUpIphone animated:YES completion:nil];
}

@end
