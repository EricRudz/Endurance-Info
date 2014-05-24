//
//  SecondViewController.m
//  EI
//
//  Created by Eric on 04/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ChampionnatsViewController.h"
#import "NewsCell.h"
#import "FirstViewController.h"

@implementation ChampionnatsViewController
@synthesize categorie;
@synthesize tableau;
@synthesize currentNewsItem;

#pragma mark -
#pragma mark Initialization

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if ((self = [super initWithStyle:style])) {
 }
 return self;
 }
 */


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
//    self.navigationController.navigationBar.tintColor= [[UIColor alloc] initWithRed:0.0/255 green:49.0/255 blue:83.0/255 alpha:1.0];
    [super viewDidLoad];
    
	self.title = NSLocalizedString(@"Categories", nil);
	categorie = [[NSMutableArray alloc] init];
    
    /*
	 Connexion au forum
	 */
	
    //	tableau = [[NSMutableArray alloc] init];
    //	currentNewsItem = [[NSMutableDictionary alloc] init];
    //	[currentNewsItem setObject:@"Connexion au forum" forKey:@"title"];
    //	[currentNewsItem setObject:@"Si vous voulez vous connecter, c'est ici que ça se passe" forKey:@"sousTitre"];
    //	[currentNewsItem setObject:@"http://www.endurance-info.com/version2/forum/ucp.php?mode=login" forKey:@"lien"];
    //	[tableau addObject:currentNewsItem];
    //	
    //	[categorie addObject:tableau];
    
	
	/*
	 Règles du forum
	 */
	    
    
    tableau = [[NSMutableArray alloc] init];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Info live" forKey:@"title2"];
    [currentNewsItem setObject:@"Info live" forKey:@"title"];
	[currentNewsItem setObject:@"info@2x.png" forKey:@"image"];
    [currentNewsItem setObject:@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/news-breves.php" forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités Nürburgring",@"") forKey:@"title2"];
    [currentNewsItem setObject:NSLocalizedString(@"24 heures du Nürburgring",@"") forKey:@"title"];
	[currentNewsItem setObject:@"24Hnurburgring.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-2.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités 24h Series",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"24H Series" forKey:@"title"];
	[currentNewsItem setObject:@"24Hseries.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-3.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités ADAC",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"ADAC" forKey:@"title"];
	[currentNewsItem setObject:@"AdacGtMasters.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-66.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités ALMS",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"American Le Mans Series" forKey:@"title"];
	[currentNewsItem setObject:@"alms.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-24.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités AsianLMS",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"Asian Le Mans Series" forKey:@"title"];
	[currentNewsItem setObject:@"asian.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-35.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités BES",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"Blancpain Endurance Series" forKey:@"title"];
	[currentNewsItem setObject:@"blancpain.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-46.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités BRCC",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"BRCC" forKey:@"title"];
	[currentNewsItem setObject:@"brcc.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-76.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];

    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités British GT",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"British GT" forKey:@"title"];
	[currentNewsItem setObject:@"britishgt.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-77.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];

    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Chroniques Pilotes",@"") forKey:@"title2"];
    [currentNewsItem setObject:NSLocalizedString(@"Chroniques Pilotes",@"") forKey:@"title"];
	[currentNewsItem setObject:@"Chroniq_pilotes.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-5.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités City Challenge Baku",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"City Challenge Baku" forKey:@"title"];
	[currentNewsItem setObject:@"citychallengebaku.jpg" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-71.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités CER",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"Classic Endurance Racing" forKey:@"title"];
	[currentNewsItem setObject:@"cer.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-42.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Divers",@"") forKey:@"title2"];
    [currentNewsItem setObject:NSLocalizedString(@"Divers",@"") forKey:@"title"];
	[currentNewsItem setObject:@"divers.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-36.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités DTM",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"DTM" forKey:@"title"];
	[currentNewsItem setObject:@"DTM.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-6.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Endurance-Info" forKey:@"title2"];
    [currentNewsItem setObject:@"Endurance-Info" forKey:@"title"];
	[currentNewsItem setObject:@"ei.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-7.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités ELMS",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"European Le Mans Series" forKey:@"title"];
	[currentNewsItem setObject:@"LMS.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-13.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités GT1",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"GT1 World Championship" forKey:@"title"];
	[currentNewsItem setObject:@"fia_gt.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-8.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités GT2",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"GT2" forKey:@"title"];
	[currentNewsItem setObject:@"fia_gt2.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-44.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités GT3",@"") forKey:@"title2"];
    [currentNewsItem setObject:NSLocalizedString(@"GT3 Europe",@"") forKey:@"title"];
	[currentNewsItem setObject:@"FIA_GT3.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-9.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités FIA WEC",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"World Endurance Championship" forKey:@"title"];
    [currentNewsItem setObject:@"ilmc.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://www.endurance-info.com/fr/discipline/fia-world-endurance-championship/feed",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités FLM",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"Formula Le Mans" forKey:@"title"];
	[currentNewsItem setObject:@"flm.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-10.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités Grand-Am",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"Grand-AM" forKey:@"title"];
	[currentNewsItem setObject:@"grand_am.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-26.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités GT Tour",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"GT Tour" forKey:@"title"];
	[currentNewsItem setObject:@"gt_tour.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-47.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités GT4",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"GT4 European Cup" forKey:@"title"];
	[currentNewsItem setObject:@"GT4.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-25.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Guillaume Moreau" forKey:@"title2"];
    [currentNewsItem setObject:@"Guillaume Moreau" forKey:@"title"];
	[currentNewsItem setObject:@"guillaumemoreau.png" forKey:@"image"];
    [currentNewsItem setObject:@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-67.html" forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Le casque de...",@"") forKey:@"title2"];
    [currentNewsItem setObject:NSLocalizedString(@"Le casque de...",@"") forKey:@"title"];
    [currentNewsItem setObject:@"Casque_pilotes2.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-41.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"24 heures du Mans" forKey:@"title2"];
    [currentNewsItem setObject:@"24 heures du Mans" forKey:@"title"];
	[currentNewsItem setObject:@"24h_du_mans.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-33.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Le Mans Classic" forKey:@"title2"];
    [currentNewsItem setObject:@"Le Mans Classic" forKey:@"title"];
	[currentNewsItem setObject:@"lmc.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-15.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Maxi Endurance 48" forKey:@"title2"];
    [currentNewsItem setObject:@"Maxi Endurance 48" forKey:@"title"];
	[currentNewsItem setObject:@"maxiendurance48.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-72.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Miniatures" forKey:@"title2"];
    [currentNewsItem setObject:@"Miniatures" forKey:@"title"];
	[currentNewsItem setObject:@"miniatures.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-37.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Nouveautés du livre" forKey:@"title2"];
    [currentNewsItem setObject:@"Nouveautés du livre" forKey:@"title"];
	[currentNewsItem setObject:@"livres.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-14.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Actualités Open GT" forKey:@"title2"];
    [currentNewsItem setObject:@"Open GT" forKey:@"title"];
	[currentNewsItem setObject:@"GT_Open.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-17.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Petits cadeaux" forKey:@"title2"];
    [currentNewsItem setObject:@"Petits cadeaux" forKey:@"title"];
	[currentNewsItem setObject:@"cadeau.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-34.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Porsche Carrera Cup France" forKey:@"title2"];
    [currentNewsItem setObject:@"Porsche Carrera Cup France" forKey:@"title"];
	[currentNewsItem setObject:@"porschematmutcarreracupbis.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-63.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Portraits" forKey:@"title2"];
    [currentNewsItem setObject:@"Portraits" forKey:@"title"];
	[currentNewsItem setObject:@"portrait.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-18.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités Super GT",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"Super GT" forKey:@"title"];
	[currentNewsItem setObject:@"super-GT.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-19.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Super Series FFSA" forKey:@"title2"];
    [currentNewsItem setObject:@"Super Series FFSA" forKey:@"title"];
	[currentNewsItem setObject:@"FFSA.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-32.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:@"Supercar" forKey:@"title2"];
    [currentNewsItem setObject:@"Supercar" forKey:@"title"];
	[currentNewsItem setObject:@"car.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-30.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];
    
    currentNewsItem = [[NSMutableDictionary alloc] init];
	[currentNewsItem setObject:NSLocalizedString(@"Actualités VdeV",@"") forKey:@"title2"];
    [currentNewsItem setObject:@"VdeV" forKey:@"title"];
	[currentNewsItem setObject:@"vdev.png" forKey:@"image"];
    [currentNewsItem setObject:NSLocalizedString(@"http://ios.rudz.fr/conv_sujetEIV2.php?url=http://www.endurance-info.com/version2/actualite-discipline-61.html",@"") forKey:@"link"];
	[tableau addObject:currentNewsItem];

                	
	[categorie addObject:tableau];

}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
        	return NSLocalizedString(@"Actu", @"");
            break;
        case 1:
        	return NSLocalizedString(@"Actu", @"");
            break;
		default:
            return nil;
	}	
}



//- (UIView *) tableView:(UITableView *)tableView
//viewForHeaderInSection:(NSInteger)section {
//  	UIView* customView = [[[UIView alloc] 
//						   initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)]
//						  autorelease];	
//	UILabel * headerLabel = [[[UILabel alloc]
//							  initWithFrame:CGRectZero] autorelease];
//	headerLabel.backgroundColor = [UIColor clearColor];
//	headerLabel.opaque = YES;
//	headerLabel.font = [UIFont boldSystemFontOfSize:16];
//	headerLabel.frame = CGRectMake(14,-3.0, 320.0, 30.0);
//	switch (section) {
//        case 0:
//			customView.backgroundColor =[UIColor darkGrayColor];
//			headerLabel.textColor = [UIColor whiteColor];
//			headerLabel.text = [NSString stringWithString:@"Connexion"];
//			break;
//
//		case 1:
//			customView.backgroundColor =[UIColor darkGrayColor];
//			headerLabel.textColor = [UIColor whiteColor];
//			headerLabel.text = [NSString stringWithString:@"Notifications"];
//			break;
//		case 2:
//			customView.backgroundColor =[UIColor darkGrayColor];
//			headerLabel.textColor = [UIColor whiteColor];
//			headerLabel.text = [NSString stringWithString:@" Section publique"];
//			break;
//		default:
//			break;
//	}	
//	//	UIImage *theImage = [UIImage imageNamed:@"bandeau_titre.png"];
//	//	UIImageView *imageView = [[[UIImageView alloc] initWithImage:theImage] autorelease];
//	//	[customView addSubview:imageView];	
//  	[customView addSubview:headerLabel];
//	
//	return customView;
//}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
//    NSLog(@"nb cat : %i",[categorie count]);
    return [categorie count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSMutableArray *array = [categorie objectAtIndex:section];
//    NSLog(@"nb elem : %i",[array count]);
	return [array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   	static NSString *newsCellIdentifier = @"CustomCellIdentifier";
	NewsCell *cell = (NewsCell*) [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
		for (id oneObject in nib){
			if ([oneObject isKindOfClass:[NewsCell class]]) {
				cell = (NewsCell *)oneObject;
			}
		}	
	}
	cell.titleLabel.backgroundColor = [UIColor clearColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //	cell.titleLabel.textColor=[UIColor colorWithRed: 0.82 green: 0.05 blue: 0.36 alpha: 1];
	
    //	cell.descriptionLabel.textColor = [UIColor darkGrayColor];
    //	cell.descriptionLabel.backgroundColor = [UIColor clearColor];
    //	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
	// get the NewsItem
	NSMutableDictionary * nextNewsItem = [[categorie objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	cell.titleLabel.text = [nextNewsItem objectForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:[nextNewsItem objectForKey:@"image"]];
    
    
    //	cell.descriptionLabel.text = [nextNewsItem objectForKey:@"sousTitre"];
	
	return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dictio = [[categorie objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSLog(@"section : %li",(long)indexPath.section);
  if (indexPath.section == 0){
      FirstViewController *fVC = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
      fVC.categories = [dictio objectForKey:@"link"];
      fVC.titreCategorie = [dictio objectForKey:@"title2"];
      fVC.image = [dictio  objectForKey:@"image"];
      fVC.pasAccueuil = TRUE;
      
      fVC.refreshButtonNotAvailable = TRUE;
      
      //        fVC.hidesBottomBarWhenPushed = YES;
      [self.navigationController pushViewController:fVC animated:YES];

    }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}




@end

