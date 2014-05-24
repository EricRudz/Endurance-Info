//
//  FirstViewController.h
//  EI
//
//  Created by Eric on 03/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "RESideMenu.h"


@class RssParser;
@interface FirstViewController : UITableViewController {
	NSMutableArray *listOfItems;
    NSMutableArray *listOfNewsDejaLues;
	UIBarButtonItem *refreshButton;
	int z;
	BOOL booleen;
	BOOL afficherMessage;
    NSString *titreCategorie;
    BOOL refreshButtonNotAvailable;
    BOOL pasAccueuil; // faux si c la page principale vrai sinon
}
- (void) afficher;
- (void)refreshTable;

- (IBAction)showMenu;
@property (weak, nonatomic) NSMutableArray *listeDesActualites;
@property (weak, nonatomic) NSMutableArray *listeDesActualitesHeader;
@property (weak, nonatomic) NSMutableArray *listeDesActualitesDejaLues;
@property (retain) RssParser * rssParser;
@property (weak, nonatomic) NSString * categories;
@property (weak, nonatomic) NSString * image;
@property (retain, nonatomic) NSMutableArray *listOfItems;
@property (retain, nonatomic) NSMutableArray *listOfImages;
@property (nonatomic, nonatomic) NSMutableArray *listOfNewsDejaLues;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, retain) UIBarButtonItem *refreshButton;
@property (nonatomic, retain) NSString *titreCategorie;
@property (nonatomic, assign) BOOL refreshButtonNotAvailable;
@property (nonatomic, assign) BOOL pasAccueuil;


@end
