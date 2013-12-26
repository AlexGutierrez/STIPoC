//
//  AttributesTableViewController.m
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AttributesTableViewController.h"
#import "UnselectedAttributeCell.h"
#import "Attribute.h"
#import "Domain.h"

@interface AttributesTableViewController ()

@property (strong, nonatomic) NSMutableArray *selectedAttributes;
@property (strong, nonatomic) NSMutableArray *unselectedAttributes;

@end

#define SELECTED_ATTRIBUTES_SECTION_INDEX 0
#define UNSELECTED_ATTRIBUTES_SECTION_INDEX 1

@implementation AttributesTableViewController

#pragma mark -
#pragma mark Custom Accessors

- (void)setSelectedDomain:(Domain *)selectedDomain
{
    if (_selectedDomain != selectedDomain) {
        
        _selectedDomain = selectedDomain;
        
        [self.selectedAttributes removeAllObjects];
        self.unselectedAttributes = [NSMutableArray arrayWithArray:[[self.selectedDomain.attributes allObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]]];
        [self.tableView reloadData];
    }
}

- (NSMutableArray *)unselectedAttributes
{
    if (!_unselectedAttributes) {
        _unselectedAttributes = [NSMutableArray array];
    }
    
    return _unselectedAttributes;
}

- (NSMutableArray *)selectedAttributes
{
    if (!_selectedAttributes) {
        _selectedAttributes = [NSMutableArray array];
    }
    
    return _selectedAttributes;
}

#pragma mark -
#pragma mark Table View Protocols

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = (section == SELECTED_ATTRIBUTES_SECTION_INDEX) ? self.selectedAttributes.count : self.unselectedAttributes.count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = (indexPath.section == SELECTED_ATTRIBUTES_SECTION_INDEX)? kSTIPoCUnselectedAttributeCellIdentifier : kSTIPoCUnselectedAttributeCellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == UNSELECTED_ATTRIBUTES_SECTION_INDEX) {
        UnselectedAttributeCell *unselectedAttributeCell = (UnselectedAttributeCell *)cell;
        
        Attribute *attribute = self.unselectedAttributes[indexPath.row];
        
        unselectedAttributeCell.nameLabel.text = attribute.name;
    }
}

@end
