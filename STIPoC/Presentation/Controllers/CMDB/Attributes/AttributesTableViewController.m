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

#define DEFAULT_ATTRIBUTE_CELL_HEIGHT 60.0f

@implementation AttributesTableViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.editing = YES;
}

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
        selectedAttributeCell.delegate = self;
        
        Attribute *attribute = self.selectedAttributes[indexPath.row];
        
        [selectedAttributeCell changeOrderTypeButtonImageWithAttributeOrderType:(AttributeOrderType)attribute.orderType.integerValue];
        
        selectedAttributeCell.nameLabel.text = attribute.name;
        selectedAttributeCell.backgroundColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *destinationIndexPath = nil;
    
    if (indexPath.section == UNSELECTED_ATTRIBUTES_SECTION_INDEX) {
        Attribute *attribute = self.unselectedAttributes[indexPath.row];
        
        [self.unselectedAttributes removeObject:attribute];
        [self.selectedAttributes addObject:attribute];
        
        attribute.selected = @YES;
        attribute.orderType = @(AttributeOrderTypeNone);
        
        NSInteger newIndex = [self.selectedAttributes indexOfObject:attribute];
        attribute.selectOrder = @(newIndex);
        
        destinationIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:SELECTED_ATTRIBUTES_SECTION_INDEX];
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
        destinationIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:UNSELECTED_ATTRIBUTES_SECTION_INDEX];
    }

    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:destinationIndexPath];
    [self.tableView reloadRowsAtIndexPaths:@[destinationIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    return (section == SELECTED_ATTRIBUTES_SECTION_INDEX);
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Attribute *attribute = self.selectedAttributes[sourceIndexPath.row];
    attribute.selectOrder = @(destinationIndexPath.row);
    
    [self.selectedAttributes removeObjectAtIndex:sourceIndexPath.row];
    [self.unselectedAttributes insertObject:attribute atIndex:destinationIndexPath.row];
    attribute.selectOrder = nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.section == UNSELECTED_ATTRIBUTES_SECTION_INDEX) {
        NSInteger newRow = self.selectedAttributes.count - 1;
        return [NSIndexPath indexPathForRow:newRow inSection:SELECTED_ATTRIBUTES_SECTION_INDEX];
    }
    
    return proposedDestinationIndexPath;
}

#pragma mark -
#pragma mark Selected Attribute Cell Protocols

- (void)selectedAttributeCellDidChangeOrderType:(SelectedAttributeCell *)selectedAttributeCell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedAttributeCell];
    
    Attribute *attribute = self.selectedAttributes[indexPath.row];
    
    if (attribute.orderType.integerValue == AttributeOrderTypeNone) {
        attribute.orderType = @(AttributeOrderTypeAsc);
    }
    else if (attribute.orderType.integerValue == AttributeOrderTypeAsc) {
        attribute.orderType = @(AttributeOrderTypeDesc);
    }
    else {
        attribute.orderType = @(AttributeOrderTypeNone);
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
