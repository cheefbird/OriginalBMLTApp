//
//  A_BMLT_SearchViewController.m
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

#import "A_BMLT_SearchViewController.h"
#import "BMLTAppDelegate.h"
#import "BMLT_Prefs.h"

/**************************************************************//**
 \class BMLT_Search_BlackAnnotationView
 \brief We modify the black annotation view to allow dragging.
 *****************************************************************/
@implementation BMLT_Search_BlackAnnotationView
@synthesize draggable;

/**************************************************************//**
 \brief We simply switch on the draggable bit, here.
 \returns self
 *****************************************************************/
- (id)initWithAnnotation:(id<MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
              coordinate:(CLLocationCoordinate2D)inCoordinate
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];

    if ( self )
        {
        [self setDraggable:YES];
        }

    return self;
}

/**************************************************************//**
 \brief Handles dragging.
 *****************************************************************/
- (void)setDragState:(MKAnnotationViewDragState)newDragState
            animated:(BOOL)animated
{
#ifdef DEBUG
    NSLog(@"BMLT_Search_BlackAnnotationView setDragState called with a drag state of %@.", newDragState);
#endif
    self.dragState = newDragState;
}

/**************************************************************//**
 \brief Accessor. Set the coordinate data member.
 *****************************************************************/
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
#ifdef DEBUG
    NSLog(@"BMLT_Search_BlackAnnotationView setCoordinate called with a drag state of (%f, %f).", newCoordinate.longitude, newCoordinate.latitude);
#endif
    coordinate = newCoordinate;
}

/**************************************************************//**
 \brief Accessor. Get the coordinate data member.
 \returns the coordinates of the marker.
 *****************************************************************/
- (CLLocationCoordinate2D)coordinate
{
    return coordinate;
}

@end

/**************************************************************//**
 \class A_BMLT_SearchViewController
 \brief This class acts as an abstract base for the two search dialogs.
        its only purpose is to handle the interactive map presented in
        the iPad version of the app.
 *****************************************************************/
@implementation A_BMLT_SearchViewController
@synthesize mapSearchView;

/**************************************************************//**
 \brief  Called just before the view will appear. We use it to set
         up the map (in an iPad).
 *****************************************************************/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpMap];
}

/**************************************************************//**
 \brief  If this is an iPad, we'll set up the map.
 *****************************************************************/
- (void)setUpMap
{
    if ( mapSearchView )    // This will be set in the storyboard.
        {
#ifdef DEBUG
        NSLog(@"A_BMLT_SearchViewController setUpIpadMap called (We're an iPad, baby!).");
#endif
        BMLTAppDelegate *myAppDelegate = [BMLTAppDelegate getBMLTAppDelegate];  // Get the app delegate SINGLETON
        
        CLLocationCoordinate2D  center;
#ifdef DEBUG
        NSLog(@"A_BMLT_SearchViewController setUpIpadMap We're using the canned coordinates.");
#endif
        center.latitude = [NSLocalizedString(@"INITIAL-MAP-LAT", nil) doubleValue];
        center.longitude = [NSLocalizedString(@"INITIAL-MAP-LONG", nil) doubleValue];
        
        if ( [myAppDelegate myLocation] )
            {
#ifdef DEBUG
            NSLog(@"A_BMLT_SearchViewController setUpIpadMap We know where we are, so we'll set the map to that.");
#endif
            center = [myAppDelegate myLocation].coordinate;
            }
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, 25000, 25000);
        
        [mapSearchView setRegion:region animated:NO];
        
        BMLT_Results_MapPointAnnotation *myMarker = [[BMLT_Results_MapPointAnnotation alloc] initWithCoordinate:center andMeetings:nil];
        
        [mapSearchView addAnnotation:myMarker];
        
        if ( [[BMLT_Prefs getBMLT_Prefs] keepUpdatingLocation] )    // If the user wants us to keep track of them, then we'll do so.
            {
            [mapSearchView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
            }
        else
            {
            [mapSearchView setUserTrackingMode:MKUserTrackingModeNone animated:NO];
            }
        }
}

#pragma mark - MkMapAnnotationDelegate Functions -

/**************************************************************//**
 \brief Returns the view for the marker in the center of the map.
 \returns an annotation view, representing the marker.
 *****************************************************************/
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id < MKAnnotation >)annotation
{
#ifdef DEBUG
    NSLog(@"A_BMLT_SearchViewController viewForAnnotation called.");
#endif
    static NSString* identifier = @"single_meeting_annotation";
    
    MKAnnotationView* ret = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if ( !ret )
        {
        ret = [[BMLT_Search_BlackAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier coordinate:[annotation coordinate]];
        }
    
    return ret;
}

@end