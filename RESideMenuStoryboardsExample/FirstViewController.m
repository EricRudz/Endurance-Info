//
//  FirstViewController.m
//  EI
//
//  Created by Eric on 03/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FirstViewController.h"
#import "RssParser.h"
#import "NewsCell.h"
#import "WebViewController.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@implementation FirstViewController
@synthesize listOfItems;
@synthesize listOfNewsDejaLues;
@synthesize refreshButton;
@synthesize categories;
@synthesize titreCategorie;
@synthesize refreshButtonNotAvailable;
@synthesize image;
@synthesize pasAccueuil;
@synthesize listeDesActualitesHeader;
@synthesize rssParser;
@synthesize listeDesActualites;
@synthesize listOfImages;
@synthesize listeDesActualitesDejaLues;

bool _firstLoad;
/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */
- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    //Definitions

//    UIApplicationWillEnterForegroundNotification;
//    EIAppDelegate *appDelegate= [[EIAppDelegate alloc] initWithController:self];
    
	refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(afficher)];
    if (refreshButtonNotAvailable == TRUE) {
    }
    else {
        self.navigationItem.rightBarButtonItem = refreshButton;

    }
	refreshButton.enabled = NO;
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
        self.navigationController.navigationBar.translucent = YES;
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }

    //self.navigationController.navigationBar.tintColor= [[UIColor alloc] initWithRed:0.0/255 green:49.0/255 blue:83.0/255 alpha:1.0];

	z=0;
	afficherMessage= TRUE;						   
	if (titreCategorie ==NULL) {
        self.title = NSLocalizedString(@"Actu", @"Titre de la page");

    } else {
        self.title = titreCategorie;

    }
	
    
    
    
    
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    // on initialise le tableau des news déjà lues
	// on cherche un fichier de données pour le rootViewController
	//il y a un fichier
    listOfItems = [[NSMutableArray alloc] init];
    //on charge les adresses mémorisées
    [self afficher];
    
    
    listOfItems = [[NSMutableArray alloc] init];
    //on charge les adresses mémorisées
    [self afficher];
}

- (void) afficher{
    NSLog(@"on affiche");
    rssParser = [[RssParser alloc] initWithController:self];
    NSString *fluxAparser;
    if (categories == NULL){
        // start the parser
        //fluxAparser=@"http://www.endurance-info.com/version2/rssEnduranceInfoFr.php";
        fluxAparser=NSLocalizedString(@"flux", nil);
        [rssParser parseRSSFeed:fluxAparser];
    }
    else{
        // start the parser
        [rssParser parseRSSFeed:categories];

    }
    
}


- (void)refreshTable{
    //    NSLog(@"refresh");
	//	//on charge les adresses mémorisées
	[self afficher];
	[self.tableView reloadData];
    
}


- (void) viewWillAppear:(BOOL)animated{    
    //on recharge les informations de l'heure
	booleen = TRUE;
	//on teste la connexion
	/*ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://www.endurance-info.com/version2"]];
	[request setDelegate:self];
	[request startAsynchronous];*/
	z++;
    

	[self.tableView reloadData];
	[super viewDidAppear:animated];
}






//cette méthode charge le tableau des adresses et appelle la méthode pour récupérer les flux,
//ou les récupère directement



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"nb : %lu",(unsigned long)[listOfItems count]);
	return [listOfItems count];
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
	cell.titleLabel.textColor=[UIColor blackColor];
	
//	cell.descriptionLabel.textColor = [UIColor orangeColor];
//	cell.descriptionLabel.backgroundColor = [UIColor darkGrayColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
	// get the NewsItem
	NSMutableDictionary * nextNewsItem = [listOfItems objectAtIndex:indexPath.row];
    //on cherche si la news a déjà été lue
    for (int i=0; i<[listOfNewsDejaLues count]; i++) {
        if ([nextNewsItem isEqualToDictionary:[listOfNewsDejaLues objectAtIndex:i]]) {
            cell.titleLabel.textColor=[UIColor grayColor];

        }
    }
    
	//image choice
	NSString *titre = [nextNewsItem objectForKey:@"title"];
    NSLog(@"title = %@", titre);

	NSArray *listItems =[titre componentsSeparatedByString:@"]"];
	NSString *tag =[listItems objectAtIndex:0];
//	NSLog(@"%@",tag);
	
//	if ([tag isEqualToString:@"[24H Nürburgring & VLN"]) {
//		UIImage* theImage = [UIImage imageNamed:@"24Hnurburgring.png"];
//		cell.imageView.image = theImage;
//	}
    if (image!=NULL) {
        cell.imageView.image= [UIImage imageNamed:image];
    }
//    if ([titreCategorie isEqualToString:@"Actualités ILMC"]) {
//        UIImage* theImage = [UIImage imageNamed:@"ilmc.png"];
//		cell.imageView.image = theImage;
//    }
//    
//    else if ([titreCategorie isEqualToString:@"Actualités LMS"]) {
//        UIImage* theImage = [UIImage imageNamed:@"LMS.png"];
//		cell.imageView.image = theImage;
//    }
//
//    else if ([titreCategorie isEqualToString:@"Actualités ALMS"]) {
//        UIImage* theImage = [UIImage imageNamed:@"alms.png"];
//		cell.imageView.image = theImage;
//    }
//    
//    else if ([titreCategorie isEqualToString:@"Actualités GT1"]) {
//        UIImage* theImage = [UIImage imageNamed:@"fia_gt.png"];
//		cell.imageView.image = theImage;
//    }
//    
//    else if ([titreCategorie isEqualToString:@"Actualités GT3"]) {
//		UIImage* theImage = [UIImage imageNamed:@"FIA_GT3.png"];
//		cell.imageView.image = theImage;
//	}
//
//    else if ([titreCategorie isEqualToString:@"Actualités 24h du Mans"]) {
//        UIImage* theImage = [UIImage imageNamed:@"24h_du_mans.png"];
//		cell.imageView.image = theImage;
//    }
//
//    else if ([titreCategorie isEqualToString:@"Actualités BES"]) {
//        UIImage* theImage = [UIImage imageNamed:@"blancpain.png"];
//		cell.imageView.image = theImage;
//    }
    
    else if ([[tag lowercaseString] isEqualToString:@"[24h nürburgring & vln"]) {
		UIImage* theImage = [UIImage imageNamed:@"24Hnurburgring.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[adac gt masters"]) {
		UIImage* theImage = [UIImage imageNamed:@"AdacGtMasters.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[porsche matmut carrera cup"]) {
		UIImage* theImage = [UIImage imageNamed:@"porschematmutcarreracupbis.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[porsche carrera cup france"]) {
		UIImage* theImage = [UIImage imageNamed:@"porschematmutcarreracupbis.png"];
		cell.imageView.image = theImage;
	}

    
    //    else if ([tag isEqualToString:@"[24H Series"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"24Hseries.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[24h series"]) {
        UIImage* theImage = [UIImage imageNamed:@"24Hseries.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[American Le Mans Series"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"alms.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[american le mans series"]) {
		UIImage* theImage = [UIImage imageNamed:@"alms.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Asian Le Mans Series"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"asian.png"];
    //		cell.imageView.image = theImage;
    //	}
    
	else if ([[tag lowercaseString] isEqualToString:@"[asian le mans series"]) {
		UIImage* theImage = [UIImage imageNamed:@"asian.png"];
		cell.imageView.image = theImage;
	}
    
    //    else if ([tag isEqualToString:@"[Blancpain Endurance Series"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"blancpain.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[blancpain endurance series"]) {
		UIImage* theImage = [UIImage imageNamed:@"blancpain.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[brcc"]) {
		UIImage* theImage = [UIImage imageNamed:@"brcc.png"];
		cell.imageView.image = theImage;
	}

    else if ([[tag lowercaseString] isEqualToString:@"[gulf12"]) {
		UIImage* theImage = [UIImage imageNamed:@"Gulf12.jpg"];
		cell.imageView.image = theImage;
	}

    else if ([[tag lowercaseString] isEqualToString:@"[british gt"]) {
		UIImage* theImage = [UIImage imageNamed:@"britishgt.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[chroniques pilotes"]) {
		UIImage* theImage = [UIImage imageNamed:@"Chroniq_pilotes.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[city challenge baku"]) {
		UIImage* theImage = [UIImage imageNamed:@"citychallengebaku.jpg"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[classic endurance racing"]) {
		UIImage* theImage = [UIImage imageNamed:@"cer.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Divers"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"divers.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[divers"]) {
		UIImage* theImage = [UIImage imageNamed:@"divers.png"];
		cell.imageView.image = theImage;
	}
	
    //	else if ([tag isEqualToString:@"[DTM"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"DTM.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[dtm"]) {
		UIImage* theImage = [UIImage imageNamed:@"DTM.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Endurance Info"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"ei.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[endurance info"]) {
		UIImage* theImage = [UIImage imageNamed:@"ei.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Endurance VdeV"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"vdev.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[endurance vdev"]) {
		UIImage* theImage = [UIImage imageNamed:@"vdev.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[vdev"]) {
		UIImage* theImage = [UIImage imageNamed:@"vdev.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[FIA GT1"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"fia_gt.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[fia gt1"]) {
		UIImage* theImage = [UIImage imageNamed:@"fia_gt.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[FIA GT2"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"fia_gt2.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[fia gt2"]) {
		UIImage* theImage = [UIImage imageNamed:@"fia_gt2.png"];
		cell.imageView.image = theImage;
	}
	
    //	else if ([tag isEqualToString:@"[FIA GT3"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"FIA_GT3.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[fia gt3"]) {
		UIImage* theImage = [UIImage imageNamed:@"FIA_GT3.png"];
		cell.imageView.image = theImage;
	}
	
    //	else if ([tag isEqualToString:@"[Formula Le Mans Cup"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"flm.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[formula le mans cup"]) {
		UIImage* theImage = [UIImage imageNamed:@"flm.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Grand-Am"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"grand_am.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[grand-am"]) {
		UIImage* theImage = [UIImage imageNamed:@"grand_am.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[GT4 European Cup"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"GT4.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[gt4 european cup"]) {
		UIImage* theImage = [UIImage imageNamed:@"GT4.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[guillaume moreau"]) {
		UIImage* theImage = [UIImage imageNamed:@"guillaumemoreau.png"];
		cell.imageView.image = theImage;
	}

    
    //	else if ([tag isEqualToString:@"[Intercontinental Le Mans Cup"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"ilmc.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[intercontinental le mans cup"]) {
		UIImage* theImage = [UIImage imageNamed:@"ilmc.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[fia world endurance championship"]) {
		UIImage* theImage = [UIImage imageNamed:@"ilmc.png"];
		cell.imageView.image = theImage;
	}
    
    
    //	else if ([tag isEqualToString:@"[Le Casque De..."]) {
    //		UIImage* theImage = [UIImage imageNamed:@"Casque_pilotes2"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[le casque de..."]) {
		UIImage* theImage = [UIImage imageNamed:@"Casque_pilotes2"];
		cell.imageView.image = theImage;
	}
	
    //	else if ([tag isEqualToString:@"[Le Mans"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"24h_du_mans.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[le mans"]) {
		UIImage* theImage = [UIImage imageNamed:@"24h_du_mans.png"];
		cell.imageView.image = theImage;
	}
	
    //	else if ([tag isEqualToString:@"[Le Mans Classic"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"lmc.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[le mans classic"]) {
		UIImage* theImage = [UIImage imageNamed:@"lmc.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[maxi endurance 48"]) {
		UIImage* theImage = [UIImage imageNamed:@"maxiendurance48.png"];
		cell.imageView.image = theImage;
	}

    
    //	else if ([tag isEqualToString:@"[Le Mans Series"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"LMS.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[le mans series"]) {
		UIImage* theImage = [UIImage imageNamed:@"LMS.png"];
		cell.imageView.image = theImage;
	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[european le mans series"]) {
		UIImage* theImage = [UIImage imageNamed:@"LMS.png"];
		cell.imageView.image = theImage;
	}
    
    
    //	else if ([tag isEqualToString:@"[Miniatures"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"miniatures.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[miniatures"]) {
		UIImage* theImage = [UIImage imageNamed:@"miniatures.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Nouveautés Du Livre"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"livres.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[nouveautés du livre"]) {
		UIImage* theImage = [UIImage imageNamed:@"livres.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Open GT"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"GT_Open.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[open gt"]) {
		UIImage* theImage = [UIImage imageNamed:@"GT_Open.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Petits Cadeaux"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"cadeau.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[petits cadeaux"]) {
		UIImage* theImage = [UIImage imageNamed:@"cadeau.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Portrait"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"portrait.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[portrait"]) {
		UIImage* theImage = [UIImage imageNamed:@"portrait.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Super GT"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"super-GT.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[super gt"]) {
		UIImage* theImage = [UIImage imageNamed:@"super-GT.png"];
		cell.imageView.image = theImage;
	}
    
    //	else if ([tag isEqualToString:@"[Super Série FFSA"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"FFSA.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[super série ffsa"]) {
		UIImage* theImage = [UIImage imageNamed:@"FFSA.png"];
		cell.imageView.image = theImage;
	}
    //
    //	else if ([tag isEqualToString:@"[Supercar"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"car.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[supercar"]) {
		UIImage* theImage = [UIImage imageNamed:@"car.png"];
		cell.imageView.image = theImage;
	}
    
    //    else if ([tag isEqualToString:@"[GT Tour"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"gt_tour.png"];
    //		cell.imageView.image = theImage;
    //	}
    
    else if ([[tag lowercaseString] isEqualToString:@"[gt tour"]) {
		UIImage* theImage = [UIImage imageNamed:@"gt_tour.png"];
		cell.imageView.image = theImage;
	}

	else{
		UIImage* theImage = [UIImage imageNamed:@"info@2x.png"];
		cell.imageView.image = theImage;
    }
	
	cell.titleLabel.text = [nextNewsItem objectForKey:@"title"];

//	cell.descriptionLabel.text = [nextNewsItem objectForKey:@"description"];
	
	return cell;
}

//- (UIView *) tableView:(UITableView *)tableView
//viewForHeaderInSection:(NSInteger)section {
//  	UIView* customView = [[[UIView alloc] 
//						   initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)]
//						  autorelease];
//	  	customView.backgroundColor = 
//		[UIColor orangeColor];
//	
//	
//	UILabel * headerLabel = [[[UILabel alloc]
//							  initWithFrame:CGRectZero] autorelease];
//	headerLabel.backgroundColor = [UIColor clearColor];
//	headerLabel.opaque = YES;
//	headerLabel.textColor = [UIColor blackColor];
//	headerLabel.font = [UIFont boldSystemFontOfSize:16];
//	headerLabel.frame = CGRectMake(14,-3.0, 320.0, 30.0);
//	headerLabel.text = [NSString stringWithString:@"Endurance-Info"];
//	
//  	[customView addSubview:headerLabel];
//	
//	return customView;
//}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSMutableDictionary *dictio = [listOfItems objectAtIndex:indexPath.row];
    [listOfNewsDejaLues addObject:dictio];
	// Navigation logic may go here -- for example, create and push another view controller.
	if ((booleen==TRUE)&&([[dictio objectForKey:@"link"]length]>0)) {
		WebViewController *wVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
		wVC.storyNewsItem = dictio;
        if (pasAccueuil == TRUE) {
            wVC.langue = @"anglais";
        }
		//hide tabbarcontroller
		wVC.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:wVC animated:YES];
	}
}



 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}
 

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void) viewDidDisappear:(BOOL)animated{
    
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView];

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView];
}

@end
