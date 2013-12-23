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

@property (strong, nonatomic) NSArray *domainSectionKeys;

@end

@implementation DomainsViewController

@synthesize domains = _domains;

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.sectionIndexColor = [UIColor verizonBlue];
    self.tableView.sectionIndexBackgroundColor = [UIColor colorWithColor:[UIColor verizonLightGrey] andAlpha:0.5];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithColor:[UIColor verizonGrey] andAlpha:0.5];
    
    if ([self.delegate respondsToSelector:@selector(domainsViewControllerRequestedDomainsFromServer)]) {
        [self.delegate domainsViewControllerRequestedDomainsFromServer];
    }
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

- (void)setDomains:(NSDictionary *)domains
{
    if (_domains != domains) {
        _domains = domains;
        
        self.domainSectionKeys = [[self.domains allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [self.tableView reloadData];
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionKey = self.domainSectionKeys[indexPath.section];
    NSArray *sectionDomains = [self.domains objectForKey:sectionKey];
    Domain *domain = sectionDomains[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(domainsViewControllerDidSelectDomain:)]) {
        [self.delegate domainsViewControllerDidSelectDomain:domain];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
