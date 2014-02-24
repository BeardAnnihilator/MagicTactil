//
//  DetailDeck.h
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "CustomCellCard.h"
#import                                                             "CardObject.h"
#import                                                             "DeckObject.h"
#import                                                             "AddCard.h"
#import                                                             "ManageCards.h"

@interface DetailDeck : UIViewController <UICollectionViewDelegate>
{
    AppDelegate                                                     *appDelegate;
    AddCard                                                         *addCard;
    ManageCards                                                     *manageCards;
    UIStoryboard                                                    *sbIpad;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)clickAddCard:(id)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

/* Methods */
- (void)initObjects;
- (void)translate;

@end
