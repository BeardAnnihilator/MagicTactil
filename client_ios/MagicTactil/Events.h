//
//  Events.h
//  MagicTactil
//
//  Created by cedric on 16/04/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Import */
#import                                         <UIKit/UIKit.h>
#import                                         "AddEvent.h"
#import                                         "AppDelegate.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface Events :                             UIViewController <UITableViewDelegate>
{
    UIStoryboard                                *sb;
    UIStoryboard                                *sbIpad;
    
    AddEvent                                    *addEventIphone;
    AddEvent                                    *addEventIpad;
    AppDelegate                                 *app;
}

/* Actions */
- (IBAction)clickReturn:(id)sender;
- (IBAction)clickAddEventIphone:(id)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *navBarLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableViewIpad;
@property (weak, nonatomic) IBOutlet UILabel *labelEvents;
@property (weak, nonatomic) IBOutlet UIButton *bouttonAjouter;

/* Méthodes */
- (void)initObject;
- (void)translate;
- (void)sendGetAllEvents;
- (void)checkGetAllEventResponse:(NSNotification *)notification;
- (void)sendGetEvent;
- (void)checkGetEventResponse:(NSNotification *)notification;
- (void)storeAllEvents:(NSString*)allEvents;
- (void)storeCurrentEvent:(NSString*)event;
- (void)checkIfSignUpEventResponse:(NSNotification*)notification;
- (void)sendIfSignUptEventRequest;
- (void)handle4;
- (void)handle3_5;

@end
