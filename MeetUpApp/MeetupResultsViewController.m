//
//  ViewController.m
//  MeetUpApp
//
//  Created by Wade Sellers on 10/13/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import "MeetupResultsViewController.h"
#import "DetailsViewController.h"

@interface MeetupResultsViewController() <UITableViewDelegate, UITableViewDataSource>
@property NSArray *meetups;
@property (weak, nonatomic) IBOutlet UITableView *meetupsDataTableView;
@property NSArray *arrayFromResultsDictionary;
@property NSDictionary *meetupResultsDictionary;

@end

@implementation MeetupResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //This magic takes a web address and produces a big JSON file.

    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=23667e048391366f57334782b4d4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
         NSLog(@"%@", connectionError);
        //This stores the big ass json file
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        NSLog(@"%@", jsonString);

         NSError *jsonError = nil;

        //this digs me down deep enough to reach the values I want to display because I have access to their keys.
        self.meetupResultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        //This digs down and produces us with the dictionary within the results array
        self.arrayFromResultsDictionary = [self.meetupResultsDictionary objectForKey:@"results"];

        NSLog(@"%@", self.arrayFromResultsDictionary);

        [self.meetupsDataTableView reloadData];

         NSLog(@"Connection error: %@", connectionError);
         NSLog(@"JSON error: %@", jsonError);
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Sets the number of rows in our table to the number of items in the results array
    return self.arrayFromResultsDictionary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //This helps us grab the right item within the results array
    NSDictionary *meetup = [self.arrayFromResultsDictionary objectAtIndex:indexPath.row];
    //This gives us access to the key/value pairs within the venue dictionary
    NSDictionary *venue = [meetup objectForKey:@"venue"];
    //For each cell in the row, fill it with the corresponding name and address info from the meetup dictionary
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellId"];
    cell.textLabel.text = [meetup objectForKey:@"name"];
    cell.detailTextLabel.text = [venue objectForKey:@"address_1"];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailsViewController *detailsViewController = segue.destinationViewController;
    //Get the indexPath of the tableView where you touched... sender is the touch
    NSIndexPath *cellPath = [self.meetupsDataTableView indexPathForCell:sender];
    //pass the dictionary.  This is weird because it looks like you are passing an array object which you are but that array item is actually a dictionary... Because it comes from an array of dictionary objects.
    detailsViewController.resultsDictionary = [self.arrayFromResultsDictionary objectAtIndex:cellPath.row];

}






@end
