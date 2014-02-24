//
//  Deck.h
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "DeckObject.h"
#import                                                             "CustomCellDeck.h"
#import                                                             "DetailDeck.h"
#import                                                             "CardObject.h"

@interface Deck : UIViewController <UICollectionViewDelegate>
{
    AppDelegate                                                     *appDelegate;
    UIStoryboard                                                    *sbIpad;
    DetailDeck                                                      *detailDeck;
}

/* Actions */
- (IBAction)clickAddDeck:(UIButton *)sender;
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)closeKeyboard:(id)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *realState;
@property (weak, nonatomic) IBOutlet UITextField *deckNameArea;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

/* Methods */
- (void)initObjects;
- (void)translate;
- (void)sendGetAllDecks;
- (void)checkGetAllDecksResponse:(NSNotification *)notification;
- (void)sendAddDeck;
- (void)checkAddDeckResponse:(NSNotification *)notification;
- (void)storeAllDecks:(NSString*)list;
- (void)storeDetailsDeck:(NSString*)list;
- (void)sendGetDetailsDeck;
- (void)checkGetDetailsDeckResponse:(NSNotification *)notification;
- (void)loadCards;


@end
