//
//  AttributesMainViewController.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AttributesMainViewController.h"

#define DOMAINS_CONTAINER_OFFSET_X_HIDDEN -320.0f
#define DOMAINS_CONTAINER_OFFSET_X_DISPLAYED 0.0f

@interface AttributesMainViewController ()

@property (nonatomic) BOOL domainsContainerIsHidden;

- (void)setDomainsContainerIsHidden:(BOOL)domainsContainerIsHidden animated:(BOOL)animated;

@end

@implementation AttributesMainViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDomainsContainerIsHidden:YES animated:NO];
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
            } completion:^(BOOL finished) {
                if (finished) {
                    self.domainsContainer.hidden = !_domainsContainerIsHidden;
                    _domainsContainerIsHidden = domainsContainerIsHidden;
                }
            }];
        }
        else {
            self.domainsContainer.frame = endFrame;
            self.domainsContainer.hidden = !_domainsContainerIsHidden;
            _domainsContainerIsHidden = domainsContainerIsHidden;
        }
    }
}

#pragma mark -
#pragma mark IBOutlet

- (IBAction)toggleDomainsContainer:(id)sender
{
    [self setDomainsContainerIsHidden:!self.domainsContainerIsHidden animated:YES];
}

@end
