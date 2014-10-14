//
//  DetailsViewController.m
//  MeetUpApp
//
//  Created by Wade Sellers on 10/13/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import "DetailsViewController.h"
#import "WebViewController.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *rsvpAmount;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *groupInfoTextView;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //This helps us grab the right item within the results array
    NSDictionary *singleComment = [self.commentsDictionary objectAtIndex:indexPath.row];
    //This gives us access to the key/value pairs within the venue dictionary
    //NSDictionary *venue = [meetup objectForKey:@"venue"];
    //For each cell in the row, fill it with the corresponding name and address info from the meetup dictionary
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellId"];
    cell.textLabel.text = [meetup objectForKey:@"name"];
    cell.detailTextLabel.text = [venue objectForKey:@"address_1"];
    return cell;
}









-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *webViewController = segue.destinationViewController;
    webViewController.urlString = [self.resultsDictionary objectForKey:@"event_url"];

}




@end
