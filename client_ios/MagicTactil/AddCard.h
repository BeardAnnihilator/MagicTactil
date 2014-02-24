//
//  AddCard.h
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "DeckObject.h"
#import                                                             "CardObject.h"

@interface AddCard : UIViewController
{
    AppDelegate                                                     *appDelegate;
    CardObject                                                      *currentCard;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)closeKeyboard:(UITextField *)sender;
- (IBAction)clickFind:(UIButton *)sender;
- (IBAction)clickAdd:(UIButton *)sender;
- (IBAction)clickDeleteCard:(UIButton *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UITextField *idCardArea;
@property (weak, nonatomic) IBOutlet UILabel *nameCard;
@property (weak, nonatomic) IBOutlet UIImageView *imgCard;
@property (weak, nonatomic) IBOutlet UITextView *descriptionCard;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;

/* Methods */
- (void)initObjects;
- (void)sendGetCard;
- (void)checkGetCardResponse:(NSNotification *)notification;
- (void)displayDetailsCard:(NSString*)details;
- (void)sendAddCard;
- (void)checkAddCardResponse:(NSNotification *)notification;
- (void)sendDeleteCard;
- (void)checkDeleteCardResponse:(NSNotification *)notification;
- (void)storeCard;

@end
