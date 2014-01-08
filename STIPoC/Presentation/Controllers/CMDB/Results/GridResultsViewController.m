//
//  GridResultsViewController.m
//  STIPoC
//
//  Created by Arturo Gamarra on 2/01/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "GridResultsViewController.h"
#import "GridResultCell.h"

@interface GridResultsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *gridTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *gridView;

@end

@implementation GridResultsViewController

#pragma mark -
#pragma mark View Lifecycle
- (void)viewDidLoad
{
    /*for testing only*/
    NSArray *arr1 = @[@"320234",@"2qwertyui",@"2012-12-12",@"sadsadas fdfghhjjg fdfsadg gfhgfgfeerttryf",@"sdffsgreewrewrr dfvc dsfdsfsdfdsfdf",@"ceewcrercwrwrwecds"];
    NSArray *arr2 = @[@"320235",@"234ewrewrwer",@"2012-12-12",@"cvbbvnbnvbn fdfghhjjg fdfsadg gfhgfgfeerttryf",@"vbnvbn dfvc dsfdsfsdfdsfdf",@"ceewcrercwrwrwecds"];
   self.queryResults = @[arr1, arr2];
    
    [super viewDidLoad];
    [self resizeScrollViewForOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Custom Accessors
- (void)setQueryResults:(NSArray *)queryResults
{
    if (_queryResults != queryResults) {
        _queryResults = queryResults;
        [self.gridTableView reloadData];
    }
}

- (void)setHeaderFields:(NSArray *)headerFields
{
    if (_headerFields != headerFields) {
        _headerFields = headerFields;
        [self.gridTableView reloadData];
    }
}

#pragma mark -
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.queryResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GridResultCell *cell = (GridResultCell *) [tableView dequeueReusableCellWithIdentifier:kSTIPoCGridDetailAttributeCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[GridResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSTIPoCGridDetailAttributeCellIdentifier];
    }
    cell.values = self.queryResults[indexPath.row];
    return cell;
}


#pragma mark -
#pragma UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GridResultCell *cell = (GridResultCell *) [tableView dequeueReusableCellWithIdentifier:kSTIPoCGridHeaderAttributeCellIdentifier];
    if (!cell) {
        cell = [[GridResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSTIPoCGridHeaderAttributeCellIdentifier];
    }
    cell.contentView.backgroundColor = [UIColor verizonRed];
    cell.values = self.headerFields;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GridResultCell *cell = (GridResultCell *) [tableView dequeueReusableCellWithIdentifier:kSTIPoCGridDetailAttributeCellIdentifier];
    int rowHeight = [cell calculatePreferedHeightForValues:self.queryResults[indexPath.row]];
    return rowHeight;
}

#pragma mark -
#pragma NotificationCenter
- (void)deviceOrientationDidChangeNotification:(NSNotification *)notification
{
    [self resizeScrollViewForOrientation];
}

#pragma mark -
#pragma Private methods
- (void)resizeScrollViewForOrientation
{
    //Remove control from super view to apply scrollview
    [self.gridView removeFromSuperview];
    [self.gridTableView removeFromSuperview];
    
    //Remove contrains to adjust the view to the scroll view
    [self.gridView removeConstraints:self.gridView.constraints];
    [self.gridTableView removeConstraints:self.gridTableView.constraints];
    
    //Set new frame size
    if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        self.gridView.frame = CGRectMake(0, 0, [self calculatePreferedWidthForTableView], self.scrollView.frame.size.height);
    } else {
        //TODO: calculate the 664
        self.gridView.frame = CGRectMake(0, 0, [self calculatePreferedWidthForTableView], 664);
    }
    
    //Apply autolayout resize for internal view and disable for external
    self.gridView.translatesAutoresizingMaskIntoConstraints = YES;
    self.gridTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Add views
    [self.gridView addSubview:self.gridTableView];
    [self.scrollView addSubview:self.gridView];
    
    //For internal views add normal constrains
    UITableView *tableview = self.gridTableView;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(tableview);
    [self.gridView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableview]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.gridView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableview]|" options:0 metrics: 0 views:viewsDictionary]];
    
    //Set scroll view content size
    [self.scrollView setContentSize:self.gridView.bounds.size];
}

- (float)calculatePreferedWidthForTableView
{
    float maxWidth = 0;
    for (NSArray *rowValue in self.queryResults) {
        maxWidth = [self getMaxWidthForRowValues:rowValue currentMaxWidth:maxWidth];
    }
    maxWidth = [self getMaxWidthForRowValues:self.headerFields currentMaxWidth:maxWidth];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        maxWidth = maxWidth < screenSize.width ? screenSize.width - 40 : maxWidth;
    } else {

        maxWidth = maxWidth < screenSize.height ? screenSize.height - 40 : maxWidth;
    }
    return maxWidth;
}

- (float)getMaxWidthForRowValues:(NSArray *)rowValues currentMaxWidth:(float)maxWidth
{
    GridResultCell *cell = (GridResultCell *) [self.gridTableView dequeueReusableCellWithIdentifier:kSTIPoCGridDetailAttributeCellIdentifier];
    float rowWidth = [cell calculatePreferedWidthForValues:rowValues];
    return (rowWidth > maxWidth) ? rowWidth : maxWidth;
}

@end
