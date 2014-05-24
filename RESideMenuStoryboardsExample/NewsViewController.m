//
//  NewsViewController.m
//  SidebarDemo
//
//  Created by Eric on 11/09/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "NewsViewController.h"
#import "RssParser.h"
#import "NewsCell.h"
#import "WebViewController.h"


@interface NewsViewController ()


@end

@implementation NewsViewController
@synthesize listOfItems;
@synthesize listeDesActualitesHeader;
@synthesize listOfNewsDejaLues;
@synthesize rssParser;
@synthesize image;
@synthesize categories;
@synthesize listeDesActualites;
@synthesize listOfImages;
@synthesize listeDesActualitesDejaLues;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
//
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}

- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    else
    {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    // Set the gesture
    
    self.title = NSLocalizedString(@"Actu", @"Titre de la page");
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    shadow.shadowOffset = CGSizeMake(0, 0);
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                                     shadow, NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    self.navigationController.navigationBar.translucent = YES;
    [[UIView appearance] setTintColor:[UIColor whiteColor]];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"PullTo", nil)];
    [refresh addTarget:self action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [self.refreshControl addTarget:self
                            action:@selector(refreshView:)
                  forControlEvents:UIControlEventValueChanged];
    
    
    
    // on initialise le tableau des news déjà lues
    //    listOfNewsDejaLues = [NSMutableArray alloc];
	// initialise the RSS feeder
    //	listOfItems = [[NSMutableArray alloc] init];
    
	z=0;
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath : %@",filePath);
	// on cherche un fichier de données pour le rootViewController
	//il y a un fichier
	if (([[NSFileManager defaultManager] fileExistsAtPath:filePath])&&(z==0)){
		listOfItems = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        //        [listOfItems initWithContentsOfFile:filePath];
		//S'il y a a un fichier mais aucune données
		if ([listOfItems count] == 0) {
            NSLog(@"C'était vide");
            
			//on charge les adresses mémorisées
			[self afficher];
		}
		else {
            //[self afficher];
			NSLog(@"on a chargé le mutableArray");
		}
	}
	//Pas de fichier
	else {
        NSLog(@"le fichier n'existe pas");
		//on charge les adresses mémorisées
        [self afficher];
	}
    
    
	NSString *filePath2 = [self dataFilePath2];
	// on cherche un fichier de données pour le rootViewController
	//il y a un fichier
	if (([[NSFileManager defaultManager] fileExistsAtPath:filePath2])&&(z==0)){
		listOfNewsDejaLues = [[NSMutableArray alloc] initWithContentsOfFile:filePath2];
		//S'il y a a un fichier mais aucune données
		if ([listOfNewsDejaLues count] == 0) {
		}
	}
	//Pas de fichier
	else {
        //		listOfItems = [[NSMutableArray alloc] init];
		//on charge les adresses mémorisées
        //        [self afficher];
	}
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated{
    //on recharge les informations de l'heure
    //	booleen = TRUE;
	//on teste la connexion
	z++;
    
    
    //	[self.tableView reloadData];
	[super viewDidAppear:animated];
}


- (NSString *) dataFilePath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:jFilename];
}

- (NSString *) dataFilePath2{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:jFilenamedejalues];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void) afficher{
    NSLog(@"on affiche");
    rssParser = [[RssParser alloc] initWithController:self];
    NSString *fluxAparser;
    if (categories == NULL){
        // start the parser
        //fluxAparser=@"http://www.endurance-info.com/version2/rssEnduranceInfoFr.php";
        fluxAparser=NSLocalizedString(@"Flux",nil);
        [rssParser parseRSSFeed:fluxAparser];
    }
    else{
        // start the parser
        [rssParser parseRSSFeed:categories];
        
    }
    
    //    rssParser = [[RssParser alloc] initWithController:self];
    //    NSString *fluxAparser;
    //	// start the parser
    //    fluxAparser=NSLocalizedString(@"Flux",nil);
    //    [NSThread detachNewThreadSelector:@selector(parseRSSFeed:)
    //                             toTarget:rssParser withObject:fluxAparser];
    
    
}


- (void)refreshTable{
    //    NSLog(@"refresh");
	//	//on charge les adresses mémorisées
	[self afficher];
	[self.tableView reloadData];
    
}

-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Actualisation...",nil)];
	[self afficher];
	[self.tableView reloadData];
    
    // custom refresh logic would be placed here...
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:NSLocalizedString(@"dd/MM 'à' HH:mm",nil)];
    NSString *lastActu = NSLocalizedString(@"Dernière actualisation le", nil);
    NSString *lastUpdated = [NSString stringWithFormat:@"%@ %@",lastActu,
                             [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"nb : %lu",(unsigned long)[listOfItems count]);
	return [listOfItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //supprimer si nécessaire
    return 56.0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    
    //supprimer le if si nécessaire
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
        NSLog(@"titre lu = %@", [[listOfNewsDejaLues objectAtIndex:i] objectForKey:@"category"]);
        if([[nextNewsItem objectForKey:@"category"] isEqualToString:[[listOfNewsDejaLues objectAtIndex:i] objectForKey:@"category"]]){
            NSLog(@"equals");
            cell.titleLabel.textColor=[UIColor grayColor];
        }
//        if ([nextNewsItem isEqualToDictionary:[listOfNewsDejaLues objectAtIndex:i]]) {
//            NSLog(@"equals");
//            cell.titleLabel.textColor=[UIColor grayColor];
//            
//        }
    }
    
    //image choice
    NSString *titre = [nextNewsItem objectForKey:@"category"];
    NSArray *listItems =[titre componentsSeparatedByString:@"]"];
    NSString *tag =[listItems objectAtIndex:0];
    //	NSLog(@"%@",tag);
    
    //	if ([tag isEqualToString:@"24H Nürburgring & VLN"]) {
    //		UIImage* theImage = [UIImage imageNamed:@"24Hnurburgring.png"];
    //		cell.imageView.image = theImage;
    //	}
    if (image!=NULL) {
        cell.imageView.image= [UIImage imageNamed:image];
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"24h nürburgring & vln"]) {
        UIImage* theImage = [UIImage imageNamed:@"24Hnurburgring.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"24H nÃŒrburgring & vln"]) {
        UIImage* theImage = [UIImage imageNamed:@"24Hnurburgring.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"adac gt masters"]) {
        UIImage* theImage = [UIImage imageNamed:@"AdacGtMasters.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"porsche matmut carrera cup"]) {
        UIImage* theImage = [UIImage imageNamed:@"porschematmutcarreracupbis.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"porsche carrera cup france"]) {
        UIImage* theImage = [UIImage imageNamed:@"porschematmutcarreracupbis.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"24h series"]) {
        UIImage* theImage = [UIImage imageNamed:@"24Hseries.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"american le mans series"]) {
        UIImage* theImage = [UIImage imageNamed:@"alms.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"asian le mans series"]) {
        UIImage* theImage = [UIImage imageNamed:@"asian.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"blancpain endurance series"]) {
        UIImage* theImage = [UIImage imageNamed:@"blancpain.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"brcc"]) {
        UIImage* theImage = [UIImage imageNamed:@"brcc.png"];
        cell.imageView.image = theImage;
    }
    
    
    else if ([[tag lowercaseString] isEqualToString:@"british gt"]) {
        UIImage* theImage = [UIImage imageNamed:@"britishgt.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"chroniques pilotes"]) {
        UIImage* theImage = [UIImage imageNamed:@"Chroniq_pilotes.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"city challenge baku"]) {
        UIImage* theImage = [UIImage imageNamed:@"citychallengebaku.jpg"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"classic endurance racing"]) {
        UIImage* theImage = [UIImage imageNamed:@"cer.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"divers"]) {
        UIImage* theImage = [UIImage imageNamed:@"divers.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"dtm"]) {
        UIImage* theImage = [UIImage imageNamed:@"DTM.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"endurance info"]) {
        UIImage* theImage = [UIImage imageNamed:@"ei.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"endurance vdev"]) {
        UIImage* theImage = [UIImage imageNamed:@"vdev.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"vdev"]) {
        UIImage* theImage = [UIImage imageNamed:@"vdev.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"fia gt1"]) {
        UIImage* theImage = [UIImage imageNamed:@"fia_gt.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"fia gt series"]) {
        UIImage* theImage = [UIImage imageNamed:@"fia_gt.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"fia gt2"]) {
        UIImage* theImage = [UIImage imageNamed:@"fia_gt2.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"fia gt3"]) {
        UIImage* theImage = [UIImage imageNamed:@"FIA_GT3.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"formula le mans cup"]) {
        UIImage* theImage = [UIImage imageNamed:@"flm.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"grand-am"]) {
        UIImage* theImage = [UIImage imageNamed:@"grand_am.png"];
        cell.imageView.image = theImage;
    }
    else if ([[tag lowercaseString] isEqualToString:@"green racing"]) {
        UIImage* theImage = [UIImage imageNamed:@"green.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"gt4 european cup"]) {
        UIImage* theImage = [UIImage imageNamed:@"GT4.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"guillaume moreau"]) {
        UIImage* theImage = [UIImage imageNamed:@"guillaumemoreau.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"intercontinental le mans cup"]) {
        UIImage* theImage = [UIImage imageNamed:@"ilmc.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"fia world endurance championship"]) {
        UIImage* theImage = [UIImage imageNamed:@"ilmc.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"tudor united sportscar championship"]) {
        UIImage* theImage = [UIImage imageNamed:@"USCR.jpg"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"united sportscar championship"]) {
        UIImage* theImage = [UIImage imageNamed:@"USCR.jpg"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"le casque de..."]) {
        UIImage* theImage = [UIImage imageNamed:@"Casque_pilotes2"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"le mans"]) {
        UIImage* theImage = [UIImage imageNamed:@"24h_du_mans.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"le mans classic"]) {
        UIImage* theImage = [UIImage imageNamed:@"lmc.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"maxi endurance 48"]) {
        UIImage* theImage = [UIImage imageNamed:@"maxiendurance48.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"le mans series"]) {
        UIImage* theImage = [UIImage imageNamed:@"LMS.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"european le mans series"]) {
        UIImage* theImage = [UIImage imageNamed:@"LMS.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"miniatures"]) {
        UIImage* theImage = [UIImage imageNamed:@"miniatures.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"nouveautés du livre"]) {
        UIImage* theImage = [UIImage imageNamed:@"livres.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"open gt"]) {
        UIImage* theImage = [UIImage imageNamed:@"GT_Open.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"petits cadeaux"]) {
        UIImage* theImage = [UIImage imageNamed:@"cadeau.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"portrait"]) {
        UIImage* theImage = [UIImage imageNamed:@"portrait.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"super gt"]) {
        UIImage* theImage = [UIImage imageNamed:@"super-GT.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"super série ffsa"]) {
        UIImage* theImage = [UIImage imageNamed:@"FFSA.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"supercar"]) {
        UIImage* theImage = [UIImage imageNamed:@"car.png"];
        cell.imageView.image = theImage;
    }
    
    else if ([[tag lowercaseString] isEqualToString:@"gt tour"]) {
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


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSMutableDictionary *dictio = [listOfItems objectAtIndex:indexPath.row];
    [listOfNewsDejaLues addObject:dictio];
    NSLog(@"listOfNewsDejaLues count = %lu", (unsigned long)[listOfNewsDejaLues count]);
	// Navigation logic may go here -- for example, create and push another view controller.
    NSString *descript = [dictio objectForKey:@"title"];
    NSLog(@"descript : %@",descript);
    //    descript = [descript stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    WebViewController *wVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    wVC.storyNewsItem = dictio;
    //hide tabbarcontroller
    wVC.hidesBottomBarWhenPushed = YES;
    NSLog(@"ici");
    [self.navigationController pushViewController:wVC animated:YES];
}


- (void) viewDidDisappear:(BOOL)animated{
    NSLog(@"on écrit le fichier");
    NSString *filePath = [self dataFilePath];
    [listOfItems writeToFile:filePath atomically:YES];
    
    NSString *filePath2 =  [self dataFilePath2];
    [listOfNewsDejaLues writeToFile:filePath2 atomically:YES];
}
@end
