//
//  CalendrierViewController2.m
//  Endurance-Info
//
//  Created by Eric on 15/11/2013.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "CalendrierViewController.h"


@implementation CalendrierViewController
@synthesize liveWebView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.title = NSLocalizedString(@"Calendar", nil);
    //    self.navigationController.navigationBar.tintColor= [[UIColor alloc] initWithRed:0.0/255 green:49.0/255 blue:83.0/255 alpha:1.0];
    
	url = [NSURL URLWithString:NSLocalizedString(@"AllEvents", nil)];
	NSURLRequest *requete = [NSURLRequest requestWithURL:url];
	[liveWebView loadRequest:requete];
	liveWebView.scalesPageToFit = TRUE;
    liveWebView.delegate = self;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}


- (IBAction)refresh{
    [liveWebView reload];
	liveWebView.scalesPageToFit = YES;
}

#pragma mark WEBVIEW delegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end