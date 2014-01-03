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

@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSArray *domainSectionKeys;

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;

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
    
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor verizonLightGrey];
    
    if ([self.delegate respondsToSelector:@selector(domainsViewControllerRequestedDomainsFromServer)]) {
        [self.delegate domainsViewControllerRequestedDomainsFromServer];
    }
}

#pragma mark -
#pragma mark Custom Accessors

- (NSArray *)searchResults
{
    if (!_searchResults) {
        _searchResults = [NSArray new];
    }
    return _searchResults;
}

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
#pragma mark Search Methods

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.name contains[cd] %@",
                                    searchText];
    
    NSMutableArray *allDomains = [NSMutableArray array];
    for (NSArray *indexDomains in self.domains.allValues) {
        [allDomains addObjectsFromArray:indexDomains];
    }
    
    NSArray *filteredDomains = [allDomains filteredArrayUsingPredicate:resultPredicate];
    
    self.searchResults = [filteredDomains sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark -
#pragma mark Table View Protocols

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = (tableView == self.searchDisplayController.searchResultsTableView)? 1 : self.domainSectionKeys.count;
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    }
    
    NSString *sectionKey = self.domainSectionKeys[section];
    NSArray *sectionDomains = [self.domains objectForKey:sectionKey];
    return sectionDomains.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (tableView == self.searchDisplayController.searchResultsTableView)? 0.0f : 30.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    
    NSString *sectionKey = self.domainSectionKeys[section];
    
    return sectionKey;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    
    return self.domainSectionKeys;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (tableView == self.searchDisplayController.searchResultsTableView)? [self.tableView dequeueReusableCellWithIdentifier:kSTIPoCDomainCellIdentifier] :[self.tableView dequeueReusableCellWithIdentifier:kSTIPoCDomainCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Domain *domain = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        domain = self.searchResults[indexPath.row];
    }
    else {
        NSString *sectionKey = self.domainSectionKeys[indexPath.section];
        NSArray *sectionDomains = [self.domains objectForKey:sectionKey];
        domain = sectionDomains[indexPath.row];
    }
    
    DomainCell *domainCell = (DomainCell *)cell;
    domainCell.nameLabel.text = domain.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Domain *domain = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        domain = self.searchResults[indexPath.row];
    }
    else {
        NSString *sectionKey = self.domainSectionKeys[indexPath.section];
        NSArray *sectionDomains = [self.domains objectForKey:sectionKey];
        domain = sectionDomains[indexPath.row];
    }
    
    if ([self.delegate respondsToSelector:@selector(domainsViewControllerDidSelectDomain:)]) {
        [self.delegate domainsViewControllerDidSelectDomain:domain];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
