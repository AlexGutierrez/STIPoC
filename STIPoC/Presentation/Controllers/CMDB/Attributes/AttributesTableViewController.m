//
//  AttributesTableViewController.m
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AttributesTableViewController.h"
#import "UnselectedAttributeCell.h"
#import "SelectedAttributeCell.h"
#import "Attribute.h"
#import "Domain.h"

@interface AttributesTableViewController ()

@property (strong, nonatomic) NSMutableArray *selectedAttributes;
@property (strong, nonatomic) NSMutableArray *unselectedAttributes;

@end

#define SELECTED_ATTRIBUTES_SECTION_INDEX 0
#define UNSELECTED_ATTRIBUTES_SECTION_INDEX 1

#define DEFAULT_ATTRIBUTE_CELL_HEIGHT 60.0f

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEFAULT_ATTRIBUTE_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = (section == SELECTED_ATTRIBUTES_SECTION_INDEX) ? self.selectedAttributes.count : self.unselectedAttributes.count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = (indexPath.section == SELECTED_ATTRIBUTES_SECTION_INDEX)? kSTIPoCSelectedAttributeCellIdentifier : kSTIPoCUnselectedAttributeCellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == UNSELECTED_ATTRIBUTES_SECTION_INDEX) {
        UnselectedAttributeCell *unselectedAttributeCell = (UnselectedAttributeCell *)cell;
        
        Attribute *attribute = self.unselectedAttributes[indexPath.row];
        
        unselectedAttributeCell.nameLabel.text = attribute.name;
        unselectedAttributeCell.backgroundColor = [UIColor verizonGrey];
    }
    else {
        SelectedAttributeCell *selectedAttributeCell = (SelectedAttributeCell *)cell;
        
        Attribute *attribute = self.selectedAttributes[indexPath.row];
        
        selectedAttributeCell.nameLabel.text = attribute.name;
        selectedAttributeCell.backgroundColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *newIndexPath = nil;
    
    if (indexPath.section == UNSELECTED_ATTRIBUTES_SECTION_INDEX) {
        Attribute *attribute = self.unselectedAttributes[indexPath.row];
        
        [self.unselectedAttributes removeObject:attribute];
        [self.selectedAttributes addObject:attribute];
        
        attribute.selected = @YES;
        
        NSInteger newIndex = [self.selectedAttributes indexOfObject:attribute];
        attribute.selectOrder = @(newIndex);
        
        newIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:SELECTED_ATTRIBUTES_SECTION_INDEX];
    }
    else {
        Attribute *attribute = self.selectedAttributes[indexPath.row];
        
        [self.selectedAttributes removeObject:attribute];
        
        attribute.selected = @NO;
        
        NSInteger newIndex = 0;
        for (int i = 0; i < self.unselectedAttributes.count; i++) {
            Attribute *indexAttribute = self.unselectedAttributes[i];
            if ([indexAttribute.name compare:attribute.name] == NSOrderedDescending || [indexAttribute.name compare:attribute.name] == NSOrderedSame) {
                break;
            }
            newIndex++;
        }
        [self.unselectedAttributes insertObject:attribute atIndex:newIndex];
        attribute.selectOrder = nil;
        newIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:UNSELECTED_ATTRIBUTES_SECTION_INDEX];
    }

    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    [self.tableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == SELECTED_ATTRIBUTES_SECTION_INDEX;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

@end
