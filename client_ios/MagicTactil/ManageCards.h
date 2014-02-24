//
//  ManageCards.h
//  MagicTactil
//
//  Created by Ekhoo on 10/09/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "ManageCardsCell.h"
#import                                                             "AppDelegate.h"
#import                                                             "XMLDictionary.h"
#import                                                             "DeckObject.h"
#import                                                             "UIImageView+WebCache.h"
#import                                                             "UIButton+WebCache.h"
#import                                                             "CardObject.h"
#import                                                             <QuartzCore/QuartzCore.h>

@interface ManageCards : UIViewController <UICollectionViewDelegate>
{
    AppDelegate                                                     *appDelegate;
    int                                                             selectedCard;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)clickAdd:(UIButton *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

/* Methods */
- (void)initObjects;
- (void)initListCards;
- (void)sendAddCard;
- (void)checkAddCardResponse:(NSNotification *)notification;
- (void)storeCard;
- (void)translate;

@end
