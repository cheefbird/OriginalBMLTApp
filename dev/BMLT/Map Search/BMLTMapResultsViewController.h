//
//  BMLTMapResultsViewController.h
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

#import <UIKit/UIKit.h>
#import "A_BMLTSearchResultsViewController.h"
#import <MapKit/MapKit.h>

@class BMLT_Meeting;

#define BMLT_Meeting_Distance_Threshold_In_Pixels   12

/**************************************************************//**
 \class  BMLTMapResultsViewController
 \brief  This class will control display of mapped results.
 *****************************************************************/
@interface BMLTMapResultsViewController : A_BMLTSearchResultsViewController <MKMapViewDelegate>
{
    BOOL                _map_initialized;
    IBOutlet MKMapView  *meetingMapView;
    MKCoordinateRegion  lastRegion;
}

- (void)setMapInit:(BOOL)isInit;
- (BOOL)isMapInitialized;
- (void)viewMeetingDetails:(BMLT_Meeting *)inMeeting;
- (void)viewMeetingList:(NSArray *)inList;
- (void)clearLastRegion;
- (void)clearMapCompletely;
- (void)displayMapAnnotations:(NSArray *)inResults;
- (NSArray *)mapMeetingAnnotations:(NSArray *)inResults;
- (void)determineMapSize:(NSArray *)inResults;
- (void)displayAllMarkersIfNeeded;

@end
