//
//  ResultsViewController.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "ResultsViewController.h"
#import "GridResultsViewController.h"
#import "Attribute.h"

#define DEFAULT_PAGE_SIZE 10

static NSString *const kSTIPoCSegueEmbedResultsTableViewController = @"ResultsTableViewControllerEmbedSegue";

@interface ResultsViewController ()

@end

@implementation ResultsViewController

-(int)pageSize
{
    if (_pageSize == 0)
        _pageSize = DEFAULT_PAGE_SIZE;
    return _pageSize;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    int count = [self.results count];
    int pages = (count / self.pageSize) + (count % self.pageSize  == 0 ? 0 : 1);
    self.title = [NSString stringWithFormat:@"%d of %d", self.pageNumber, pages];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedResultsTableViewController]) {
        NSArray *headFields = [self getGridHeaderFiledsFromAttributes];
        [segue.destinationViewController setHeaderFields:headFields];
        [segue.destinationViewController setQueryResults:[self getQueryResultsForFields:headFields]];
    }
}

- (NSArray *)getGridHeaderFiledsFromAttributes
{
    NSMutableArray *fields = [[NSMutableArray alloc] init];
    for (Attribute *attribute in self.headAttributes) {
        [fields addObject:attribute.name];
    }
    return fields;
}

- (NSArray *)getQueryResultsForFields:(NSArray *)fields
{
    NSMutableArray *queryResults = [[NSMutableArray alloc] init];
    for (NSDictionary *instance in self.results) {
        NSMutableArray *rowResults = [[NSMutableArray alloc] init];
        for (NSString *headField in fields) {
            [rowResults addObject:[instance objectForKey:headField]];
        }
        [queryResults addObject:rowResults];
    }
    return queryResults;
}

@end
