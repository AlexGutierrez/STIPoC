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
#import "AttributesService.h"
#import "Domain.h"
#import "SelectedAttributeCell.h"

static NSString *const kSTIPoCOrderPriorityPopoverViewControllerIdentifier = @"OrderPriorityPopoverViewController";

@interface AttributesTableViewController ()

@property (strong, nonatomic) NSMutableArray *selectedAttributes;
@property (strong, nonatomic) NSMutableArray *unselectedAttributes;
@property (strong, nonatomic) UIPopoverController *orderPriorityPopoverController;

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
    NSString *cellIdentifier = nil;
    
    if (indexPath.section == SELECTED_ATTRIBUTES_SECTION_INDEX) {
        
        Attribute *attribute = self.selectedAttributes[indexPath.row];
        
        if (attribute.orderType && (attribute.orderType.integerValue != AttributeOrderTypeNone)) {
            cellIdentifier = kSTIPoCSelectedOrderedAttributeCellIdentifier;
        }
        else {
            cellIdentifier = kSTIPoCSelectedAttributeCellIdentifier;
        }
    }
    else {
        cellIdentifier = kSTIPoCUnselectedAttributeCellIdentifier;
    }
    
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
        [selectedAttributeCell changeOrderPriorityTextWithOrderPriority:attribute.orderPriority.integerValue];
        
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
    [self.tableView reloadRowsAtIndexPaths:@[destinationIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    [self.selectedAttributes insertObject:attribute atIndex:destinationIndexPath.row];
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
        attribute.orderPriority = [[AttributesService sharedService] orderPriorityForNewOrdererdAttributeWithinSelectedAttributes:self.selectedAttributes];
        attribute.orderType = @(AttributeOrderTypeAsc);
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (attribute.orderType.integerValue == AttributeOrderTypeAsc) {
        attribute.orderType = @(AttributeOrderTypeDesc);
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        
        [[AttributesService sharedService] updateOrderPrioritiesForSelectedAttributes:self.selectedAttributes withUnorderedAttribute:attribute];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SELECTED_ATTRIBUTES_SECTION_INDEX] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)selectedAttributeCellDidTapOrderPriorityButton:(SelectedAttributeCell *)selectedAttributeCell
{
    OrderPriorityPopoverViewController *orderPriorityPopoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:kSTIPoCOrderPriorityPopoverViewControllerIdentifier];
    orderPriorityPopoverViewController.maxPriority = [[AttributesService sharedService] currentMaxOrderPriorityWithinSelectedAttributes:self.selectedAttributes];
    orderPriorityPopoverViewController.delegate = self;
    
    self.orderPriorityPopoverController = [[UIPopoverController alloc] initWithContentViewController:orderPriorityPopoverViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedAttributeCell];
    orderPriorityPopoverViewController.popoverAttribute = self.selectedAttributes[indexPath.row];
    
    [self.orderPriorityPopoverController presentPopoverFromRect:selectedAttributeCell.orderPriorityButton.frame inView:selectedAttributeCell.orderPriorityButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)selectedAttributeCellDidTapFiltersButton:(SelectedAttributeCell *)selectedAttributeCell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedAttributeCell];
    
    Attribute *attribute = self.selectedAttributes[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(attributesTableViewControllerDidRequestFilterChangeForAttribute:)]) {
        [self.delegate attributesTableViewControllerDidRequestFilterChangeForAttribute:attribute];
    }
}

#pragma mark -
#pragma mark Order Priority Popover View Protocols

- (void)orderPriorityPopoverViewController:(OrderPriorityPopoverViewController *)orderPriorityPopoverViewController didSelectNewPriority:(NSInteger)newOrderPriority
{
    [[AttributesService sharedService] updateOrderPrioritiesForSelectedAttributes:self.selectedAttributes withAttributeToUpdate:orderPriorityPopoverViewController.popoverAttribute withNewOrderPriority:newOrderPriority];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:SELECTED_ATTRIBUTES_SECTION_INDEX] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.orderPriorityPopoverController dismissPopoverAnimated:YES];
}

@end
