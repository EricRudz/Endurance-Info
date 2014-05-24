//
//  WebViewController.m
//  EI
//
//  Created by Eric on 20/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Twitter/Twitter.h>
#import <social/Social.h>


@implementation WebViewController
@synthesize storyNewsItem, storyWebView, titre, auteurDate, scrollView, toolbar, img, compteur, langue;


int vue=0; //vue =0 si on est dans webviewcontroller 1 si on est dans webviewcontroller2

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    envoie = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(envoiFacebookOuTwitterOuMailOuSMS)];
    self.navigationItem.rightBarButtonItem = envoie;

	[titre setFont:[UIFont boldSystemFontOfSize:10.0]];
	titre.numberOfLines=2;
	titre.text= [storyNewsItem objectForKey:@"title"];
	self.navigationItem.titleView=titre;

	auteurDate.text = [NSString stringWithFormat:@"%@, %@", [storyNewsItem objectForKey:@"author"], [storyNewsItem objectForKey:@"pubDate"]];

//	storyWebView = [ [ UIWebView alloc ] init];//
	storyWebView.delegate = self;

	storyWebView.scalesPageToFit = TRUE;
	
	CGFloat hauteur = storyWebView.frame.size.height + 71;
	scrollView.contentSize = CGSizeMake(320, hauteur*0.63);
	[scrollView sizeToFit];
	
    NSURL *url=NULL;
	NSString *uerel = [storyNewsItem objectForKey:@"link"];
	[uerel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	uerel = [uerel stringByReplacingOccurrencesOfString:@" " withString:@""];
	uerel = [uerel stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    uerel=[NSString stringWithFormat:@"%@%@", @"http://ios.rudz.fr/iphone.php?url=", uerel];
    NSLog(@"uerel = %@",uerel);

    url = [NSURL URLWithString:uerel];
	if (url==NULL) {
		uerel =[uerel stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		uerel = [uerel stringByReplacingOccurrencesOfString:@"%09" withString:@""];
		url = [NSURL URLWithString:uerel];
	}
    //    NSLog(@"%@",url);
	NSURLRequest *requete = [NSURLRequest requestWithURL:url];
	[storyWebView loadRequest:requete];
	[super viewDidLoad];

}
-(void)viewDidAppear:(BOOL)animated{
    vue=0;
}


#pragma mark WEBVIEW delegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    compteur++;
//    if (compteur>1){
////        NSArray *items = [NSArray arrayWithObjects: buttongoback,fix,buttongoforward,flexible, nil];
////        [toolbar setItems:items animated:NO]; 
////        buttongoback.enabled= TRUE;
//    }
//    else{
//        NSArray *items = [NSArray arrayWithObjects: flexible, envoie, nil];
//        buttongoback.enabled= NO;
//        buttongoforward.enabled = (storyWebView.canGoForward);
//    }
////	NSLog(@"deb");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSURLRequest *currentRequest = [webView request];
//    NSURL *currentURL = [currentRequest URL];
////    NSLog(@"Current URL is %@", currentURL.absoluteString);
//    NSData *data = [NSData dataWithContentsOfURL:currentURL];
//    img = [[UIImage alloc] initWithData:data];
//    
//    if (img!=nil) {
//        UIBarButtonItem *imageSave = [[UIBarButtonItem alloc] init];
//        NSArray *items = [NSArray arrayWithObjects:flexible,imageSave, nil];
//    }
//    else if (compteur==1){
//        NSArray *items = [NSArray arrayWithObjects:flexible,envoie, nil];
//
//    }
//
////    NSLog(@"compteur = %i",compteur);
//    buttongoback.enabled = (storyWebView.canGoBack);
//    buttongoforward.enabled = (storyWebView.canGoForward);
////	NSLog(@"fin");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}





-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *reqSysVer = @"5.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL displayLinkSupported=false;
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending){
        displayLinkSupported=TRUE;
    }
    
    if ((buttonIndex == 0)&& (actionSheet.tag==1)) {
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    }
    else if ((buttonIndex == 0)&& (actionSheet.tag==2)) {
        [self passerAFacebook];
    }
    else if ((buttonIndex == 1)&& (actionSheet.tag==2)) {
        [self envoiMail];
    }
    else if ((buttonIndex == 2)&& (actionSheet.tag==2)&&displayLinkSupported) {
        displayLinkSupported=false;
        [self passerATwitter];
    }
}

-(void)envoiMail{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
    NSString *initialText = [storyNewsItem objectForKey:@"title"];
	[controller setSubject:initialText];
     initialText = [initialText stringByAppendingString:@" (via Endurance-Info Mobile)"];
    NSString *message = [NSString stringWithFormat:@"%@\n%@", initialText, [storyNewsItem objectForKey:@"link"]];
    [controller setMessageBody:message isHTML:YES];
    //	[controller setMessageBody:@"" isHTML:NO];
    vue=1;
    [self presentViewController:controller animated:YES completion:Nil];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void) passerAFacebook{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSString *uairhel = [storyNewsItem objectForKey:@"link"];
        //on enlève espaces et autres conneries
        NSString * noSpaces = [[uairhel componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
        
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            NSString *msg;
            if (result == SLComposeViewControllerResultCancelled) {
                msg = NSLocalizedString(@"Vous avez annulé l'écriture du message.", @"");
                
            } else{
                msg = NSLocalizedString(@"Le message a été posté sur Facebook !",@"");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        NSString *initialText = [storyNewsItem objectForKey:@"title"];
        initialText = [initialText stringByAppendingString:@" (via Endurance-Info Mobile)"];
        [controller setInitialText:initialText];
        [controller addURL:[NSURL URLWithString:[NSString stringWithString:noSpaces]]];
        //[controller addImage:[UIImage imageNamed:@"icone@114.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }
    
}


-(void)passerATwitter{
    // Create the view controller
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];

        NSString *uairhel = [storyNewsItem objectForKey:@"link"];
        //on enlève espaces et autres conneries
        NSString * noSpaces = [[uairhel componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
        
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            NSString *msg;
            if (result == SLComposeViewControllerResultCancelled) {
                msg = NSLocalizedString(@"Vous avez annulé l'écriture du message.", @"");
                
            } else{
                msg = NSLocalizedString(@"Le message a été posté sur Twitter !",@"");
            }
            
            [tweetSheet dismissViewControllerAnimated:YES completion:Nil];
        };
        tweetSheet.completionHandler =myBlock;
        NSString *initialText = [storyNewsItem objectForKey:@"title"];
        initialText = [initialText stringByAppendingString:@" (via Endurance-Info Mobile)"];
        [tweetSheet setInitialText:initialText];
        [tweetSheet addURL:[NSURL URLWithString:[NSString stringWithString:noSpaces]]];
        //[tweetSheet addImage:[UIImage imageNamed:@"icone@114.png"]];

        [self presentViewController:tweetSheet animated:YES completion:nil];
    }

    
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) viewDidDisappear:(BOOL)animated{
    if (vue==0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
}

#pragma mark webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

-(void)envoiFacebookOuTwitterOuMailOuSMS{
    NSString *reqSysVer = @"5.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL displayLinkSupported;
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending){
        displayLinkSupported = TRUE;
        UIActionSheet *partager = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Annuler",@"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Partager sur Facebook",@""), NSLocalizedString(@"Partager par Mail",@""), NSLocalizedString(@"Partager sur Twitter",@""), nil];
        partager.tag = 2;
        partager.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [partager showInView:self.view];
        
        
    }
    else{
        UIActionSheet *partager = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Annuler",@"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Partager sur Facebook",@""), NSLocalizedString(@"Partager par Mail",@""), nil];
        partager.tag = 2;
        partager.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [partager showInView:self.view];
        
    }
    
}






@end
