//
//  DetailDeck.m
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "DetailDeck.h"

@interface DetailDeck ()

@end

@implementation DetailDeck

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
 *  Traduit l'application
 */
- (void)translate {
    [self.buttonAdd setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
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
    addCard = [sbIpad instantiateViewControllerWithIdentifier:@"addCard"];
    manageCards = [sbIpad instantiateViewControllerWithIdentifier:@"manageCards"];
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
    return ([((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards count]);
}

/**
 *  Défini le nombre de sections
 *
 *  @param collectionView collectionView
 *
 *  @return retourne le nombre de section
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
    CustomCellCard *cell;
    CardObject  *object = [((DeckObject*)appDelegate.listDecks[appDelegate.selectedDeck]).listCards objectAtIndex:indexPath.item];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellCardIpad" forIndexPath:indexPath];
    cell.img.alpha = 1;
    
    [cell.img setBackgroundImageWithURL:[NSURL URLWithString:object.url] forState:UIControlStateNormal];
    
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
    ((CustomCellCard*)[collectionView cellForItemAtIndexPath:indexPath]).img.alpha = 0.5;
    appDelegate.selectedCard = indexPath.item;
    
    appDelegate.addEditCard = 1;
    [self presentViewController:addCard animated:YES completion:nil];
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
- (IBAction)clickReturn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  Ajoute une carte
 *
 *  @param sender boutton ajouter une carte
 */
- (IBAction)clickAddCard:(id)sender
{
    appDelegate.addEditCard = 0;
    [self presentViewController:manageCards animated:YES completion:nil];
}
@end
