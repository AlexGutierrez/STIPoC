//
//  AttributesMainViewController.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AttributesMainViewController.h"
#import "AttributesTableViewController.h"
#import "Domain.h"
#import "DomainsService.h"

#define DOMAINS_CONTAINER_OFFSET_X_HIDDEN -320.0f
#define DOMAINS_CONTAINER_OFFSET_X_DISPLAYED 0.0f

#define SIDE_MENU_COLLAPSER_BUTTON_ALPHA_HIDDEN 0.0f
#define SIDE_MENU_COLLAPSER_BUTTON_ALPHA_DISPLAYED 0.3f

static NSString *const kSTIPoCSegueEmbedAttributesTableViewController = @"AttributesTableViewControllerEmbedSegue";
static NSString *const kSTIPoCSegueEmbedDomainsViewController = @"DomainsViewControllerEmbedSegue";

@interface AttributesMainViewController ()

@property (nonatomic) BOOL domainsContainerIsHidden;

@property (strong, nonatomic) AttributesTableViewController *attributesTableViewController;
@property (strong, nonatomic) DomainsViewController *domainsViewController;
@property (strong, nonatomic) UIView *currentDisplayedMenu;

- (void)setDomainsContainerIsHidden:(BOOL)domainsContainerIsHidden animated:(BOOL)animated;

@end

@implementation AttributesMainViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sideMenuCollapserButton.alpha = 0.0f;
    
    self.domainsContainerIsHidden = (self.attributesTableViewController.selectedDomain == nil);
    [self setDomainsContainerIsHidden:(self.attributesTableViewController.selectedDomain != nil) animated:YES];
    self.domainsContainerTogglingButton.enabled = (self.attributesTableViewController.selectedDomain != nil);
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedAttributesTableViewController]) {
        self.attributesTableViewController =(AttributesTableViewController *)segue.destinationViewController;
    }
    else if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedDomainsViewController]) {
        self.domainsViewController = (DomainsViewController *)segue.destinationViewController;
        self.domainsViewController.delegate = self;
    }
}

#pragma mark -
#pragma mark Custom Accessors

- (void)setDomainsContainerIsHidden:(BOOL)domainsContainerIsHidden animated:(BOOL)animated
{
    if (_domainsContainerIsHidden != domainsContainerIsHidden) {
        
        CGRect startFrame = self.domainsContainer.frame;
        startFrame.origin.x = (_domainsContainerIsHidden)? DOMAINS_CONTAINER_OFFSET_X_HIDDEN : DOMAINS_CONTAINER_OFFSET_X_DISPLAYED;
        self.domainsContainer.frame = startFrame;
        self.domainsContainer.hidden = NO;
        
        CGRect endFrame = self.domainsContainer.frame;
        endFrame.origin.x = (_domainsContainerIsHidden)? DOMAINS_CONTAINER_OFFSET_X_DISPLAYED : DOMAINS_CONTAINER_OFFSET_X_HIDDEN;
        
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                self.domainsContainer.frame = endFrame;
                self.sideMenuCollapserButton.alpha = (_domainsContainerIsHidden)? SIDE_MENU_COLLAPSER_BUTTON_ALPHA_DISPLAYED : SIDE_MENU_COLLAPSER_BUTTON_ALPHA_HIDDEN;
            } completion:^(BOOL finished) {
                if (finished) {
                    self.domainsContainer.hidden = !_domainsContainerIsHidden;
                    self.currentDisplayedMenu = (_domainsContainerIsHidden)? self.domainsContainer : nil;
                    _domainsContainerIsHidden = domainsContainerIsHidden;
                    
                }
            }];
        }
        else {
            self.domainsContainer.frame = endFrame;
            self.sideMenuCollapserButton.alpha = (_domainsContainerIsHidden)? SIDE_MENU_COLLAPSER_BUTTON_ALPHA_DISPLAYED : SIDE_MENU_COLLAPSER_BUTTON_ALPHA_HIDDEN;
            self.domainsContainer.hidden = !_domainsContainerIsHidden;
            self.currentDisplayedMenu = (_domainsContainerIsHidden)? self.domainsContainer : nil;
            _domainsContainerIsHidden = domainsContainerIsHidden;
        }
    }
}

#pragma mark -
#pragma mark Domains View Controller Protocols

- (void)domainsViewControllerDidSelectDomain:(Domain *)selectedDomain
{
    self.title = selectedDomain.name;
    self.attributesTableViewController.selectedDomain = selectedDomain;
    self.domainsContainerTogglingButton.enabled = YES;
    [self setDomainsContainerIsHidden:YES animated:YES];
}

- (void)domainsViewControllerRequestedDomainsFromServer
{
    [self showOverlayWithMessage:NSLocalizedString(@"Loading Domains...", nil)];
    
    [[DomainsService sharedService] getDomainsWithCompletionBlock:^(NSDictionary *domains) {
        [self dismissOverlay];
        self.domainsViewController.domains = domains;
    } andFailureBlock:^(NSError *error) {
        [self dismissOverlay];
        UIAlertView *alertView = [[AlertViewFactory sharedFactory] createAlertViewWithError:error];
        [alertView show];
    }];
}

#pragma mark -
#pragma mark IBOutlet

- (IBAction)collapseSideMenus:(UIButton *)sender
{
    if ([self.currentDisplayedMenu isEqual:self.domainsContainer] && (self.attributesTableViewController.selectedDomain != nil)) {
        [self toggleDomainsContainer:nil];
    }
}

- (IBAction)toggleDomainsContainer:(UIBarButtonItem *)sender
{
    [self setDomainsContainerIsHidden:!self.domainsContainerIsHidden animated:YES];
}

@end
