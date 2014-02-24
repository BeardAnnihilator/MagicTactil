//
//  Social.m
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "Social.h"

@interface Social ()

@end

@implementation Social

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
 *  Initialise les propriétés
 */
- (void)initObjects
{
    sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    sbIpad = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    
    eventIphone = [sb instantiateViewControllerWithIdentifier:@"event"];
    friends = [sb instantiateViewControllerWithIdentifier:@"friends"];
    bl = [sb instantiateViewControllerWithIdentifier:@"blacklist"];
    
    eventIpad = [sbIpad instantiateViewControllerWithIdentifier:@"eventIpad"];
    friendsIpad = [sbIpad instantiateViewControllerWithIdentifier:@"friendipad"];
    blIpad = [sbIpad instantiateViewControllerWithIdentifier:@"blacklistipad"];
}

/**
 *  Traduit la vue
 */
- (void)translate {
    self.labelSocial.text = NSLocalizedString(@"Social", @"");
    [self.bouttonEvenement setTitle:NSLocalizedString(@"Events", @"") forState:UIControlStateNormal];
    [self.bouttonAmis setTitle:NSLocalizedString(@"Friends", @"") forState:UIControlStateNormal];
    [self.bouttonBL setTitle:NSLocalizedString(@"BlackList", @"") forState:UIControlStateNormal];
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
 *  Redimensionne la vue 3.5 inch
 */
- (void)handle3_5
{
    self.labelTitle.frame = CGRectMake(113, 20, 94, 44);
    self.navBarLabel.frame = CGRectMake(0, 0, 320, 65);
    self.buttonEvent.frame = CGRectMake(0, 105, 320, 85);
    self.buttonFriend.frame = CGRectMake(0, 197, 320, 85);
    self.buttonBL.frame = CGRectMake(0, 288, 320, 85);
}

/**
 *  Redimensionne la vue 4 inch
 */
- (void)handle4
{
    self.labelTitle.frame = CGRectMake(113, 20, 94, 44);
    self.navBarLabel.frame = CGRectMake(0, 0, 320, 65);
    self.buttonEvent.frame = CGRectMake(0, 126, 320, 85);
    self.buttonFriend.frame = CGRectMake(0, 218, 320, 85);
    self.buttonBL.frame = CGRectMake(0, 310, 320, 85);
}

/**
 *  Libère la mémoire
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  Affiche les évènements
 *
 *  @param sender boutton évènement
 */
- (IBAction)clickEventsIphone:(id)sender
{
    if (!(IDIOM == IPAD))
        [self presentViewController:eventIphone animated:YES completion:nil];
    else
        [self presentViewController:eventIpad animated:YES completion:nil];
}

/**
 *  Affiche les amis
 *
 *  @param sender boutton affichage des amis
 */
- (IBAction)clickFriendsIphone:(UIButton *)sender
{
    if (!(IDIOM == IPAD))
        [self presentViewController:friends animated:YES completion:nil];
    else
        [self presentViewController:friendsIpad animated:YES completion:nil];
}

/**
 *  Affiche les joueurs bloqués
 *
 *  @param sender boutton affichage des amis bloqués
 */
- (IBAction)clickBL:(UIButton *)sender
{
    if (!(IDIOM == IPAD))
        [self presentViewController:bl animated:YES completion:nil];
    else
        [self presentViewController:blIpad animated:YES completion:nil];
}

@end
