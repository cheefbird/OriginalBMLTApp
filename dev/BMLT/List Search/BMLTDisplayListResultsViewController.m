//
//  BMLTDisplayListResultsViewController.m
//  BMLT
//
//  Created by MAGSHARE.
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  BMLT is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with this code.  If not, see <http://www.gnu.org/licenses/>.
//

#import "BMLTDisplayListResultsViewController.h"
#import "BMLTMeetingDisplayCellView.h"
#import "BMLTAppDelegate.h"
#import "BMLT_Prefs.h"

#define kSortHeaderHeight           30  ///< The height of the "Sort By" header for lists of more than one result.

/**************************************************************//**
 \class  BMLTDisplayListResultsViewController
 \brief  This class handles display of listed search results.
 *****************************************************************/
@implementation BMLTDisplayListResultsViewController

@synthesize dataArray = _dataArray;

/**************************************************************//**
 \brief G'night...
 *****************************************************************/
- (void)dealloc
{
    [_dataArray removeAllObjects];
    _dataArray = nil;
}

/**************************************************************//**
 \brief Called after the view has loaded.
 *****************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    [(UITableView *)[self view] reloadData];
}

/**************************************************************//**
 \brief Overload the implicit call, because we trigger a redraw, and
        we want to be able to use a regular array, not a mutable one.
 *****************************************************************/
- (void)setDataArrayFromData:(NSArray *)dataArray   ///< The array of data to be used for this view.
{
    if ( !_dataArray )
        {
        _dataArray = [[NSMutableArray alloc] init];
        }
    
    [_dataArray removeAllObjects];
    [_dataArray setArray:dataArray];
    [(UITableView *)[self view] reloadData];
}

#pragma mark - Sort Functions -

/**************************************************************//**
 \brief Sorts the meeting search results.
 *****************************************************************/
- (IBAction)sortMeetings:(id)sender        ///< The Segmented Control
{
    if ( [(UISegmentedControl *)sender selectedSegmentIndex] )
        {
#ifdef DEBUG
        NSLog(@"BMLTDisplayListResultsViewController::sortMeetings Sorting Meetings By Weekday and Time.");
#endif
        [[BMLTAppDelegate getBMLTAppDelegate] sortMeetingsByWeekdayAndTime];
        }
    else
        {
#ifdef DEBUG
        NSLog(@"BMLTDisplayListResultsViewController::sortMeetings Sorting Meetings By Distance.");
#endif
        [[BMLTAppDelegate getBMLTAppDelegate] sortMeetingsByDistance];
        }
    
    [self setDataArrayFromData:[[BMLTAppDelegate getBMLTAppDelegate] searchResults]];
    [(UITableView *)[self view] reloadData];
}

#pragma mark - Table Data Source Functions -

/***************************************************************\**
 \brief We have two sections in this table. This returns 2.
 \returns 2
 *****************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ([[self dataArray] count] > 1) ? 2 : 1;
}

/***************************************************************\**
 \brief Returns the appropriate title for each section header.
 \returns a string, with the appropriate title.
 *****************************************************************/
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - UITableViewDataSource Delegate Required Methods -
/**************************************************************//**
 \brief Called to provide a single cell contents.
 \returns a table cell view, with all the data and primed for action.
 *****************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView ///< The table view in question.
         cellForRowAtIndexPath:(NSIndexPath *)indexPath ///< The index path for the cell.
{
    UITableViewCell *ret = nil;
    
    // If we are populating the header, then we simply generate a new 
    if ( ([self numberOfSectionsInTableView:tableView] > 1) && ([indexPath section] == 0) )
        {
        ret = [tableView dequeueReusableCellWithIdentifier:@"LIST-SORT-HEADER"];
        if ( !ret )
            {
            NSArray *sortChoices = [NSArray arrayWithObjects:NSLocalizedString(@"SEARCH-RESULTS-SORT-DISTANCE", nil), NSLocalizedString(@"SEARCH-RESULTS-SORT-TIME", nil), nil];
            UISegmentedControl  *sortControl = [[UISegmentedControl alloc] initWithItems:sortChoices];
            [sortControl setSegmentedControlStyle:UISegmentedControlStyleBar];
            CGRect  bounds = [tableView bounds];
            bounds.origin = CGPointZero;
            bounds.size.height = kSortHeaderHeight;
            [sortControl setFrame:bounds];
            [sortControl setSelectedSegmentIndex:[BMLT_Prefs getPreferDistanceSort] ? 0 : 1];
            [sortControl addTarget:self action:@selector(sortMeetings:) forControlEvents:UIControlEventValueChanged];
            ret = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LIST-SORT-HEADER"];
            [ret addSubview:sortControl];
#ifdef DEBUG
            NSLog(@"Creating A Row For the sort header.");
#endif
            }
#ifdef DEBUG
        else
            {
            NSLog(@"Reusing the sort header row,");
            }
#endif
        }
    else
        {
        BMLT_Meeting    *theMeeting = (BMLT_Meeting *)[_dataArray objectAtIndex:[indexPath row]];
        
        if ( theMeeting )
            {
            // We deliberately don't reuse, because we need to update the "striping" of meeting cells when we re-sort.
            NSString    *reuseID = [NSString stringWithFormat: @"BMLT_Search_Results_Row_%d", [theMeeting getMeetingID]];
            if ( !ret )
                {
#ifdef DEBUG
                NSLog(@"Creating A Row For Meeting ID %d, named \"%@\"", [theMeeting getMeetingID], [theMeeting getBMLTName]);
#endif
                BMLTMeetingDisplayCellView *ret_cast = [[BMLTMeetingDisplayCellView alloc] initWithMeeting:theMeeting andFrame:[tableView bounds] andReuseID:reuseID andIndex:[indexPath row]];
                [ret_cast setMyModalController:self];
                
                ret = ret_cast;
                }
#ifdef DEBUG
            else
                {
                NSLog(@"Reusing A Row For Meeting ID %d, named \"%@\"", [theMeeting getMeetingID], [theMeeting getBMLTName]);
                }
#endif
            }
#ifdef DEBUG
        else
            {
            NSLog(@"ERROR: Cannot get a reliable meeting object for index %d!", [indexPath row]);
            }
#endif
        }
    
    return ret;
}

/**************************************************************//**
 \brief Called to indicate the number of active rows in the display.
 \returns an integer. The number of active rows.
 *****************************************************************/
- (NSInteger)tableView:(UITableView *)tableView ///< The table view in question.
 numberOfRowsInSection:(NSInteger)section       ///< The section index.
{
    return ((section == 0) && ([[self dataArray] count] > 1)) ? 1 : [[self dataArray] count];
}

/**************************************************************//**
 \brief 
 \returns 
 *****************************************************************/
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (([self numberOfSectionsInTableView:tableView] > 1) && ([indexPath section] == 0)) ? kSortHeaderHeight : List_Meeting_Display_CellHeight;
}

@end
