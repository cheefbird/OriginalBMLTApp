//
//  A_BMLT_ServiceBodyHierClass.m
//  BMLT
//
//  Created by MAGSHARE on 8/13/11.
//  Copyright 2011 MAGSHARE. All rights reserved.
//
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
/***************************************************************\**
 \file  A_BMLT_ServiceBodyHierClass.m
 \brief This file implements the class that holds instances of NA
        Service bodies.
 *****************************************************************/

#import "A_BMLT_ServiceBodyHierClass.h"

@implementation A_BMLT_ServiceBodyHierClass

#pragma mark - Override Functions -

/***************************************************************\**
 \brief     initializer
 \returns   self
 *****************************************************************/
- (id)init
{
    return [self initWithURI:nil andParent:nil andName:nil andDescription:nil];
}

/***************************************************************\**
 \brief un-initializer
 *****************************************************************/
- (void)dealloc
{
    [uri release];
    [bmlt_name release];
    [bmlt_description release];
    [cachedServiceBodies release];
    [super dealloc];
}

#pragma mark - Class-Specific Functions -

/***************************************************************\**
 \brief     Initializer with basic parameters
 \returns   self
 *****************************************************************/
- (id)initWithURI:(NSString *)inURI             ///< The URI of the Service body
        andParent:(NSObject *)inParentObject    ///< The parent object for this instance
          andName:(NSString *)inName            ///< The name of the Service body
   andDescription:(NSString *)inDescription     ///< A textual description of the Service body.
{
    self = [super initWithParent:inParentObject];
    
    if (self)
        {
        [self setURI:inURI];
        [self setBMLTName:inName];
        [self setBMLTDescription:inDescription];
        }
    
    return self;
}

/***************************************************************\**
 \brief Set the Service body URI
 *****************************************************************/
- (void)setURI:(NSString *)inURI    ///< The URI of the Service body
{
    [inURI  retain];
    [uri release];
    
    uri = nil;
    
    if ( inURI )
        {
        uri = inURI;
        }
}

/***************************************************************\**
 \brief     Get the Service body URI
 \returns   A string. The Service body URI.
 *****************************************************************/
- (NSString *)getURI
{
    return uri;
}

#pragma mark - Protocol Functions
#pragma mark - BMLT_ParentProtocol
/***************************************************************\**
 \brief     Returns an array of other Service bodies
 \returns   An array of objects.
 *****************************************************************/
- (NSArray *)getChildObjects
{
    return cachedServiceBodies;
}

#pragma mark - BMLT_NameDescProtocol
/***************************************************************\**
 \brief Set the name of this Service body
 *****************************************************************/
- (void)setBMLTName:(NSString *)inName  ///< The name, as a string
{
    [inName retain];
    [bmlt_name release];
    
    bmlt_name = nil;
    
    if ( inName )
        {
        bmlt_name = inName;
        }
}

/***************************************************************\**
 \brief Set the description of the Service body.
 *****************************************************************/
- (void)setBMLTDescription:(NSString *)inDescription    ///< The description
{
    [inDescription retain];
    [bmlt_description release];
    
    bmlt_description = nil;
    
    if ( inDescription )
        {
        bmlt_description = inDescription;
        }
}


/***************************************************************\**
 \brief     Get the Service body name.
 \returns   A string. The name
 *****************************************************************/
- (NSString *)getBMLTName
{
    return bmlt_name;
}

/***************************************************************\**
 \brief     Get the Service body description
 \returns   The description
 *****************************************************************/
- (NSString *)getBMLTDescription
{
    return bmlt_description;
}

@end