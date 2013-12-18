//
//  DomainsViewController.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "DomainsViewController.h"
#import "DomainsService.h"
#import "DomainCell.h"
#import "Domain.h"

@interface DomainsViewController ()

@property (strong, nonatomic) NSDictionary *domains;
@property (strong, nonatomic) NSArray *domainSectionKeys;

@end

@implementation DomainsViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.sectionIndexColor = [UIColor verizonBlue];
    self.tableView.sectionIndexBackgroundColor = [UIColor colorWithColor:[UIColor verizonLightGrey] andAlpha:0.5];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithColor:[UIColor verizonGrey] andAlpha:0.5];
    
    [[DomainsService sharedService] getDomainsWithCompletionBlock:^(NSDictionary *domains) {
        self.domains = domains;
        self.domainSectionKeys = [[self.domains allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [self.tableView reloadData];
    } andFailureBlock:^(NSError *error) {
        UIAlertView *alertView = [[AlertViewFactory sharedFactory] createAlertViewWithError:error];
        [alertView show];
    }];
}

#pragma mark -
#pragma mark Custom Accessors

- (NSDictionary *)domains
{
    if (!_domains) {
        _domains = [NSDictionary new];
    }
    return _domains;
}

- (NSArray *)domainSectionKeys
{
    if (!_domainSectionKeys) {
        _domainSectionKeys = [NSArray new];
    }
    return _domainSectionKeys;
}

#pragma mark -
#pragma mark Table View Protocols

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = self.domainSectionKeys.count;
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionKey = self.domainSectionKeys[section];
    NSArray *sectionDomains = [self.domains objectForKey:sectionKey];
    return sectionDomains.count;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor verizonGrey]];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,-4,300,30)];
    titleLabel.textColor = [UIColor verizonDarkGrey];
    titleLabel.font = [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium size:17.0f];
    titleLabel.text = self.domainSectionKeys[section];
    
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionKey = self.domainSectionKeys[section];
    
    return sectionKey;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.domainSectionKeys;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSTIPoCDomainCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DomainCell *domainCell = (DomainCell *)cell;
    
    NSString *sectionKey = self.domainSectionKeys[indexPath.section];
    NSArray *sectionDomains = [self.domains objectForKey:sectionKey];
    Domain *domain = sectionDomains[indexPath.row];
    
    domainCell.nameLabel.text = domain.name;
}

@end
