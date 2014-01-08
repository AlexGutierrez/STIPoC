//
//  AttributesMainViewController.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AttributesMainViewController.h"
#import "AttributesTableViewController.h"
#import "ResultsViewController.h"
#import "Domain.h"
#import "DomainsService.h"
#import "AttributesService.h"

#define FILTERS_CONTAINER_OFFSET_X_HIDDEN -320.0f
#define FILTERS_CONTAINER_OFFSET_X_DISPLAYED 0.0f

#define DOMAINS_CONTAINER_OFFSET_X_HIDDEN -320.0f
#define DOMAINS_CONTAINER_OFFSET_X_DISPLAYED 0.0f

#define SIDE_MENU_OFFSET_Y_START_LANDSCAPE -64.0f;
#define SIDE_MENU_COLLAPSER_BUTTON_ALPHA_HIDDEN 0.0f
#define SIDE_MENU_COLLAPSER_BUTTON_ALPHA_DISPLAYED 0.3f

static NSString *const kSTIPoCSegueEmbedAttributesTableViewController = @"AttributesTableViewControllerEmbedSegue";
static NSString *const kSTIPoCSegueEmbedDomainsViewController = @"DomainsViewControllerEmbedSegue";

static NSString *const kSTIPoCSeguePushResultsViewController = @"ResultsViewControllerPushSegue";

@interface AttributesMainViewController ()

@property (nonatomic) BOOL domainsContainerIsHidden;
@property (nonatomic) BOOL filtersContainerIsHidden;

@property (strong, nonatomic) AttributesTableViewController *attributesTableViewController;
@property (strong, nonatomic) DomainsViewController *domainsViewController;
@property (strong, nonatomic) UIView *currentDisplayedMenu;

- (void)setDomainsContainerIsHidden:(BOOL)domainsContainerIsHidden animated:(BOOL)animated;
- (void)setFiltersContainerIsHidden:(BOOL)domainsContainerIsHidden animated:(BOOL)animated;

@end

@implementation AttributesMainViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sideMenuCollapserButton.alpha = 0.0f;
    
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        CGRect domainsContainerFrame = self.domainsContainer.frame;
        domainsContainerFrame.origin.y = SIDE_MENU_OFFSET_Y_START_LANDSCAPE;
        self.domainsContainer.frame = domainsContainerFrame;
        
        CGRect filtersContainerFrame = self.filtersContainer.frame;
        filtersContainerFrame.origin.y = SIDE_MENU_OFFSET_Y_START_LANDSCAPE;
        self.filtersContainer.frame = filtersContainerFrame;
    }
    
    self.domainsContainerIsHidden = (self.attributesTableViewController.selectedDomain == nil);
    [self setDomainsContainerIsHidden:(self.attributesTableViewController.selectedDomain != nil) animated:YES];
    [self setFiltersContainerIsHidden:YES animated:NO];
    
    self.domainsContainerTogglingButton.enabled = (self.attributesTableViewController.selectedDomain != nil);
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedAttributesTableViewController]) {
        self.attributesTableViewController = (AttributesTableViewController *)segue.destinationViewController;
        self.attributesTableViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedDomainsViewController]) {
        self.domainsViewController = (DomainsViewController *)segue.destinationViewController;
        self.domainsViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:kSTIPoCSeguePushResultsViewController]) {
        [segue.destinationViewController setHeadAttributes:self.attributesTableViewController.selectedAttributes];
        [segue.destinationViewController setDomain:self.attributesTableViewController.selectedDomain];
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
        
        CGRect endFrame = startFrame;
        endFrame.origin.x = (_domainsContainerIsHidden)? DOMAINS_CONTAINER_OFFSET_X_DISPLAYED : DOMAINS_CONTAINER_OFFSET_X_HIDDEN;
        
        CGRect filtersEndFrame = self.filtersContainer.frame;
        filtersEndFrame.origin.x = (_filtersContainerIsHidden)? self.view.frame.size.width - self.filtersContainer.frame.size.width : self.view.frame.size.width;
        
        if (animated) {
            [UIView animateWithDuration:0.3f animations:^{
                self.domainsContainer.frame = endFrame;
                
                self.sideMenuCollapserButton.alpha = (_domainsContainerIsHidden)? SIDE_MENU_COLLAPSER_BUTTON_ALPHA_DISPLAYED : SIDE_MENU_COLLAPSER_BUTTON_ALPHA_HIDDEN;
                
                if (!domainsContainerIsHidden) {
                    self.filtersContainer.frame = filtersEndFrame;
                }
                
            } completion:^(BOOL finished) {
                if (finished) {
                    if (!domainsContainerIsHidden) {
                        self.filtersContainer.hidden = YES;
                        _filtersContainerIsHidden = YES;
                    }
                    
                    self.domainsContainer.hidden = !_domainsContainerIsHidden;
                    _domainsContainerIsHidden = domainsContainerIsHidden;
                }
            }];
        }
        else {
            self.domainsContainer.frame = endFrame;
            self.sideMenuCollapserButton.alpha = (_domainsContainerIsHidden)? SIDE_MENU_COLLAPSER_BUTTON_ALPHA_DISPLAYED : SIDE_MENU_COLLAPSER_BUTTON_ALPHA_HIDDEN;
            self.domainsContainer.hidden = !_domainsContainerIsHidden;
            _domainsContainerIsHidden = domainsContainerIsHidden;
        }
    }
}

- (void)setFiltersContainerIsHidden:(BOOL)filtersContainerIsHidden animated:(BOOL)animated
{
    if (_filtersContainerIsHidden != filtersContainerIsHidden) {
        
        CGRect startFrame = self.filtersContainer.frame;
        startFrame.origin.x = (_filtersContainerIsHidden)? self.view.frame.size.width : self.view.frame.size.width - self.filtersContainer.frame.size.width;
        self.filtersContainer.frame = startFrame;
        self.filtersContainer.hidden = NO;
        
        CGRect endFrame = startFrame;
        endFrame.origin.x = (_filtersContainerIsHidden)? self.view.frame.size.width - self.filtersContainer.frame.size.width : self.view.frame.size.width;
        
        if (animated) {
            [UIView animateWithDuration:0.3f animations:^{
                self.filtersContainer.frame = endFrame;
                self.sideMenuCollapserButton.alpha = (_filtersContainerIsHidden)? SIDE_MENU_COLLAPSER_BUTTON_ALPHA_DISPLAYED : SIDE_MENU_COLLAPSER_BUTTON_ALPHA_HIDDEN;
            } completion:^(BOOL finished) {
                if (finished) {
                    self.filtersContainer.hidden = !_filtersContainerIsHidden;
                    _filtersContainerIsHidden = filtersContainerIsHidden;
                    
                }
            }];
        }
        else {
            self.filtersContainer.frame = endFrame;
            self.sideMenuCollapserButton.alpha = (_filtersContainerIsHidden)? SIDE_MENU_COLLAPSER_BUTTON_ALPHA_DISPLAYED : SIDE_MENU_COLLAPSER_BUTTON_ALPHA_HIDDEN;
            self.filtersContainer.hidden = !_filtersContainerIsHidden;
            _filtersContainerIsHidden = filtersContainerIsHidden;
        }
    }
}

#pragma mark -
#pragma mark Domains View Controller Protocols

- (void)domainsViewControllerDidSelectDomain:(Domain *)selectedDomain
{
    [self showOverlayWithMessage:NSLocalizedString(@"Loading Attributes...", nil)];
    
    [[AttributesService sharedService] getAttributesForDomain:selectedDomain
                                          withCompletionBlock:^(NSArray *attributes) {
                                              [self dismissOverlay];
                                              selectedDomain.attributes = [NSSet setWithArray:attributes];
                                              self.title = selectedDomain.name;
                                              self.attributesTableViewController.selectedDomain = selectedDomain;
                                              self.domainsContainerTogglingButton.enabled = YES;
                                              [self setDomainsContainerIsHidden:YES animated:YES];
                                          }
                                              andFailureBlock:^(NSError *error) {
                                                  [self dismissOverlay];
                                                  UIAlertView *alertView = [[AlertViewFactory sharedFactory] createAlertViewWithError:error];
                                                  [alertView show];
                                                  
                                          }];
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
#pragma mark Attributes Table View Controller Protocols

- (void)attributesTableViewControllerDidRequestFilterChangeForAttribute:(Attribute *)attribute
{
    [self setFiltersContainerIsHidden:NO animated:YES];
}

#pragma mark -
#pragma mark IBOutlet

- (IBAction)collapseSideMenus:(UIButton *)sender
{
    [self setDomainsContainerIsHidden:YES animated:YES];
    [self setFiltersContainerIsHidden:YES animated:YES];
}

- (IBAction)toggleDomainsContainer:(UIBarButtonItem *)sender
{
    [self setDomainsContainerIsHidden:!self.domainsContainerIsHidden animated:YES];
}

@end
