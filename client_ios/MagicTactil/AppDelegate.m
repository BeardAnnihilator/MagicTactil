//
//  AppDelegate.m
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

/**
 *  Charge l'application
 *
 *  @param application   application
 *  @param launchOptions options de lancement
 *
 *  @return YES si l'application est chargée NO s'il y a eu un problème
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBProfilePictureView class];
    [self initObjects];
    [self initUser];
    [self initNotificationsStyle];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPrivateMessageResponse:) name:@"MESP" object:nil];
    
    return YES;
}

/**
 *  Initialise les styles pour les notifications
 */
- (void)initNotificationsStyle {
    [JDStatusBarNotification addStyleNamed:@"style01"
                                   prepare:^JDStatusBarStyle*(JDStatusBarStyle *style) {
                                       
                                       style.barColor = [UIColor colorWithRed:0.173 green:0.408 blue:0.922 alpha:1];
                                       style.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
                                       style.font = [UIFont boldSystemFontOfSize:17];
                                       
                                       //style.animationType = <#type#>;
                                       //style.textShadow = <#shadow#>;
                                       //style.textVerticalPositionAdjustment = <#adjustment#>;
                                       
                                       //style.progressBarColor = <#color#>;
                                       //style.progressBarHeight = 60;
                                       //style.progressBarPosition = <#position#>;
                                       
                                       return style;
                                   }];
    [JDStatusBarNotification addStyleNamed:@"style02"
                                   prepare:^JDStatusBarStyle*(JDStatusBarStyle *style) {
                                       
                                       style.barColor = [UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1];
                                       style.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
                                       style.font = [UIFont boldSystemFontOfSize:17];
                                       
                                       //style.animationType = <#type#>;
                                       //style.textShadow = <#shadow#>;
                                       //style.textVerticalPositionAdjustment = <#adjustment#>;
                                       
                                       //style.progressBarColor = <#color#>;
                                       //style.progressBarHeight = 70;
                                       //style.progressBarPosition = <#position#>;
                                       
                                       return style;
                                   }];
}

/**
 *  Vérifie les messages privées
 *
 *  @param notification notification private message
 */
- (void)checkPrivateMessageResponse:(NSNotification *)notification
{
    Packet *packet = [self.network.packetArray objectAtIndex:0];
    //NSString *response = [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding];
        
    NSLog(@"src = %d", *(int*)([packet.src bytes]));
    NSLog(@"dest = %d", *(int*)([packet.dest bytes]));
    NSLog(@"func = %@", [[NSString alloc] initWithBytes:[packet.func bytes] length:4 encoding:NSASCIIStringEncoding]);
    NSLog(@"size = %d", *(int*)([packet.dataSize bytes]));
    NSLog(@"data = %@", [[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]);
    
    [self.network.packetArray removeLastObject];
    [self handleMessage:@"" withMessage:[[NSString alloc] initWithBytes:[packet.data bytes] length:*(int*)([packet.dataSize bytes]) encoding:NSASCIIStringEncoding]];
}

/**
 *  Sauvegarde le message privée
 *
 *  @param username l'username de l'ami
 *  @param message  le message
 */
- (void)handleMessage:(NSString *)username withMessage:(NSString *)message {
    NSArray *components = [message componentsSeparatedByString:@" "];
    NSString *sender = [components objectAtIndex:0];
    int i = 0;
    FriendObject *friend;
    
    NSLog(@"%@", sender);
    while (i < [self.listFriends count]) {
        friend = [self.listFriends objectAtIndex:i];
        
        if ([sender isEqualToString:friend.userName]) {
            friend.messages = [NSString stringWithFormat:@"%@\n%@", friend.messages, message];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PRIVATE_MESSAGE" object:self];
            break;
        }
        i++;
    }
}

/**
 *  Initialise les propriétés
 */
- (void)initObjects
{
    self.user = [[User alloc] init];
    self.network = [[Network alloc] init];
    self.network.packetArray = [NSMutableArray array];
    self.listEvents = [NSMutableArray array];
    self.listFriends = [NSMutableArray array];
    self.blackList = [NSMutableArray array];
    self.listRoom = [NSMutableArray array];
    self.listPlayers = [NSMutableArray array];
    self.listDecks = [NSMutableArray array];
    [self.network initNetworkConnection];
    self.createEvent = FALSE;
    self.isSignup = FALSE;
    self.selectedFriendBL = -1;
    self.cardsAreLoaded = FALSE;
}

/**
 *  Initialise la session
 */
- (void)initUser
{
    self.user.firstName = @"";
    self.user.lastName = @"";
    self.user.userName = @"";
    self.user.password = @"";
    self.user.email = @"";
    self.user.gender = @"";
    self.user.phone = @"";
    self.user.location = @"";
    self.user.facebookId = @"";
    self.user.birthday = @"";
    
    self.user.auth_firstName = @"";
    self.user.auth_lastName = @"";
    self.user.auth_userName = @"";
    self.user.auth_password = @"";
    self.user.auth_email = @"";
    self.user.auth_gender = @"";
    self.user.auth_phone = @"";
    self.user.auth_location = @"";
    self.user.auth_birthday = @"";
}

/**
 *  Affiche une alerte
 *
 *  @param title   le titre de l'alerte
 *  @param message le message de l'alerte
 */
- (void)showAlertView:(NSString *)title withMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];

}

/**
 *  Gestionnaire de session facebook
 *
 *  @param session la session en cours
 *  @param state   l'état de la session
 *  @param error   l'erreur
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state)
    {
        case FBSessionStateOpen:
            if (!error)
            {
                [self showAlertView:@"Facebook" withMessage:@"Vos informations Facebook ont ete telecharges"];
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    if (error)
        [self showAlertView:@"Error" withMessage:error.localizedDescription];
}

/**
 *  Ouvre une session facebook
 */
- (void)openFacebookSession
{
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"email",
                            @"user_likes",
                            nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState state,
                                                      NSError *error) {
                                      [self sessionStateChanged:session
                                                          state:state
                                                          error:error];
                                  }];

}

/**
 *  Ferme la session facebook
 */
- (void)closeFacebookSession
{
    [FBSession.activeSession closeAndClearTokenInformation];
}

/**
 *  Lance la session facebook
 *
 *  @param application       application facebook
 *  @param url               url de l'application
 *  @param sourceApplication source de l'application
 *  @param annotation        annotation
 *
 *  @return YES si réussi NO si échech
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

/**
 *  Met l'application en background
 *
 *  @param application l'application
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

/**
 *  Met l'application en premier plan
 *
 *  @param application l'application
 */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

/**
 *  Réactive l'application
 *
 *  @param application l'application
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

/**
 *  Quitte l'application
 *
 *  @param application l'application
 */
- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
    [self.network.outputStream close];
    [self.network.inputStream close];
}

@end
