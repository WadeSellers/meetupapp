//
//  WebViewController.m
//  MeetUpApp
//
//  Created by Wade Sellers on 10/13/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];

    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;

}
- (IBAction)backButton:(id)sender
{
    [self.webView goBack];
}

- (IBAction)forwardButton:(id)sender
{
    [self.webView goForward];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self checkIfWebViewCanGoOrForward];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) checkIfWebViewCanGoOrForward {
    if (self.webView.canGoBack){
        self.backButton.enabled = YES;
    }
    else {
        self.backButton.enabled = NO;
    }

    if (self.webView.canGoForward) {
        self.forwardButton.enabled = YES;
    }
    else {
        self.forwardButton.enabled = NO;
    }
}

@end
