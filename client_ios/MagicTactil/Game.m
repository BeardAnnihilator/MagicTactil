//
//  Game.m
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

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
}

/**
 *  Traduit la vue
 */
- (void)translate {
    self.labelGame.text = NSLocalizedString(@"Game", @"");
    [self.buttonCreateGame setTitle:NSLocalizedString(@"CreateGame", @"") forState:UIControlStateNormal];
    [self.buttonJoinGame setTitle:NSLocalizedString(@"JoinGame", @"") forState:UIControlStateNormal];
    [self.buttonDeck setTitle:NSLocalizedString(@"MyDecks", @"") forState:UIControlStateNormal];
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    createRoomIpad = [sbIpad instantiateViewControllerWithIdentifier:@"createroomipad"];
    joinRoomIpad = [sbIpad instantiateViewControllerWithIdentifier:@"joinroomipad"];
    deck = [sbIpad instantiateViewControllerWithIdentifier:@"deck"];
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton créer une room
 *
 *  @param sender le boutton créer une room
 */
- (IBAction)clickCreateRoom:(UIButton *)sender
{
    appDelegate.isMaster = YES;
    [self presentViewController:createRoomIpad animated:YES completion:nil];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton rejoindre une room
 *
 *  @param sender le boutton rejoindre une room
 */
- (IBAction)clickJoinRoom:(UIButton *)sender
{
    appDelegate.isMaster = NO;
    [self presentViewController:joinRoomIpad animated:YES completion:nil];
}

/**
 *  Cette méthode est appelé quand l'utilisateur appuis sur le boutton Deck
 *
 *  @param sender le boutton Deck
 */
- (IBAction)clickDeck:(UIButton *)sender
{
    [self presentViewController:deck animated:YES completion:nil];
}

@end
