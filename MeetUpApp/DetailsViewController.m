//
//  DetailsViewController.m
//  MeetUpApp
//
//  Created by Wade Sellers on 10/13/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import "DetailsViewController.h"
#import "WebViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *rsvpAmount;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *groupInfoTextView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *groupDictionary = [self.resultsDictionary objectForKey:@"group"];

    self.eventName.text = [self.resultsDictionary objectForKey:@"name"];
    self.rsvpAmount.text = [[self.resultsDictionary objectForKey:@"yes_rsvp_count"] stringValue];
    self.groupInfoTextView.text = [groupDictionary objectForKey:@"name"];

    //A cool way to load HTML coded text so that it puts it out looking sharp.  Put it in a webView and use this line to make it snazzy
    [self.webView loadHTMLString:[self.resultsDictionary objectForKey:@"description"] baseURL:nil];


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *webViewController = segue.destinationViewController;
    webViewController.urlString = [self.resultsDictionary objectForKey:@"event_url"];

}



@end
