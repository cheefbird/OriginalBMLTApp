//
//  BMLT_Parser.m
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

#import "BMLT_Parser.h"


/***************************************************************\**
 \class BMLT_Parser
 \brief This is a special overload of the NSXMLParser class that is
 designed specifically for use as a background thread parser.
 
 This is necessary, because NSXMLParser leaks like a rusty bucket,
 and needs NSAutoReleasePools to be set up in the executing thread.
 Since NSXMLParser doesn't let you overload a whole lot, I set this
 class up as a "proxy" for the delegate, and intercept the various
 NSXMLParserDelegate calls. I use these to start a pool and to take
 it down. I also add a timeout, and do all the stuff that is necessary
 to manage a separate timer thread.
 
 NOTE: This does not switch any calls to the main thread! All callbacks
 occur in the parser thread, so it is up to the delegate to switch
 UI calls to the main thread.
 *****************************************************************/

@implementation BMLT_Parser

#pragma mark - Overload Functions -
/***************************************************************\**
 \brief Releases all retains, and also kills the timeout process.
 *****************************************************************/
- (void)dealloc
{
    [self cancelTimeout];
    [super dealloc];
}

/***************************************************************\**
 \brief We intercept the delegate setting, so we can retain the
 first delegate, which is informed of the timeout. This allows us
 to do the "delegate tree" walk, yet send timeouts to the root.
 *****************************************************************/
- (void)setDelegate:(id<NSXMLParserDelegate>)delegate   ///< The delegate to be assigned. The first delegate is retained for the lifetime of the object.
{
    [self setBMLTDelegate:(NSObject<NSXMLParserDelegate> *)delegate];
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (BOOL)parse
{
    myAutoReleasePool = [[NSAutoreleasePool alloc] init];
    return [super parse];
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)abortParsing
{
    [self cancelTimeout];
    [super abortParsing];
}

#pragma mark - Custom Functions -
/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)cancelTimeout
{
    [currentElement release];
    currentElement = nil;
    [myServer release];
    myServer = nil;
    [myFirstDelegate release];
    myFirstDelegate = nil;
    [myCurrentDelegate release];
    myCurrentDelegate = nil;
    [myAutoReleasePool release];
    myAutoReleasePool = nil;
    [super setDelegate:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

/***************************************************************\**
 \brief This is our custom funtion for setting the delegate. The
 delegate must be an NSObject, and the first delegate is retained.
 All delegates are retained, then released when a new delegate is
 presented, with the exception of the first delegate, which is
 retained twice, and the second retain is released in dealloc.
 *****************************************************************/
- (void)setBMLTDelegate:(NSObject<NSXMLParserDelegate> *)inDelegate
{
    [inDelegate retain];
    [myCurrentDelegate release];
    myCurrentDelegate = inDelegate;
        // We keep track of our first delegate, as that is who we squeal to when a timeout happens.
    if ( !myFirstDelegate && inDelegate )
        {
        myFirstDelegate = [myCurrentDelegate retain];
        }
    [super setDelegate:inDelegate ? self : nil];
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)setCurrentElement:(NSObject *)inObject
{
    [inObject retain];
    [currentElement release];
    currentElement = inObject;
}

/***************************************************************\**
 \brief We allow the parser to retain a server, to be accessible
 by delegate callbacks.
 *****************************************************************/
- (void)setMyServer:(BMLT_Server *)inServerObject   ///< The server object. It is retained for the lifetime of the object.
{
    [inServerObject retain];
    [myServer release];
    myServer = inServerObject;
}

/***************************************************************\**
 \brief 
 \returns 
 *****************************************************************/
- (BMLT_Server *)getMyServer
{
    return myServer;
}

/***************************************************************\**
 \brief 
 \returns 
 *****************************************************************/
- (NSObject<NSXMLParserDelegate> *)getMyFirstDelegate
{
    return myFirstDelegate;
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parseAsync:(BOOL)isAsync WithTimeout:(int)inSeconds
{
    if ( inSeconds )
        {
        [self performSelector:@selector(timeoutHandler) withObject:nil afterDelay:inSeconds];
        }
    
    if ( isAsync )
        {
        [self performSelectorInBackground:@selector(parse) withObject:nil];
        }
    else
        {
        [self parse];
        }
}

#pragma mark - NSXMParserDelegate Functions
/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parserDidStartDocument:)] )
        {
        [myCurrentDelegate parserDidStartDocument:parser];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parserDidEndDocument:)] )
        {
        [myCurrentDelegate parserDidEndDocument:parser];
        }
    
    [self cancelTimeout];
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundNotationDeclarationWithName:(NSString *)name
      publicID:(NSString *)publicID
      systemID:(NSString *)systemID
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:foundNotationDeclarationWithName:publicID:systemID:)] )
        {
        [myCurrentDelegate parser:parser foundNotationDeclarationWithName:name publicID:publicID systemID:systemID];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundUnparsedEntityDeclarationWithName:(NSString *)name
      publicID:(NSString *)publicID
      systemID:(NSString *)systemID
  notationName:(NSString *)notationName
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:foundUnparsedEntityDeclarationWithName:publicID:systemID:)] )
        {
        [myCurrentDelegate parser:parser foundUnparsedEntityDeclarationWithName:name publicID:publicID systemID:systemID notationName:notationName];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundAttributeDeclarationWithName:(NSString *)attributeName
    forElement:(NSString *)elementName
          type:(NSString *)type
  defaultValue:(NSString *)defaultValue
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:foundAttributeDeclarationWithName:forElement:type:defaultValue:)] )
        {
        [myCurrentDelegate parser:parser foundAttributeDeclarationWithName:attributeName forElement:elementName type:type defaultValue:defaultValue];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundElementDeclarationWithName:(NSString *)elementName
         model:(NSString *)model
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:foundElementDeclarationWithName:model:)] )
        {
        [myCurrentDelegate parser:parser foundElementDeclarationWithName:elementName model:model];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundInternalEntityDeclarationWithName:(NSString *)name
         value:(NSString *)value
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:foundInternalEntityDeclarationWithName:value:)] )
        {
        [myCurrentDelegate parser:parser foundInternalEntityDeclarationWithName:name value:value];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundExternalEntityDeclarationWithName:(NSString *)name
      publicID:(NSString *)publicID
      systemID:(NSString *)systemID
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:foundExternalEntityDeclarationWithName:publicID:systemID:)] )
        {
        [myCurrentDelegate parser:parser foundExternalEntityDeclarationWithName:name publicID:publicID systemID:systemID];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:didStartElement:namespaceURI:qualifiedName:attributes:)] )
        {
        [myCurrentDelegate parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:didEndElement:namespaceURI:qualifiedName:)] )
        {
        [myCurrentDelegate parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
didStartMappingPrefix:(NSString *)prefix
         toURI:(NSString *)namespaceURI
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:didStartMappingPrefix:toURI:)] )
        {
        [myCurrentDelegate parser:parser didStartMappingPrefix:prefix toURI:namespaceURI];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
didEndMappingPrefix:(NSString *)prefix
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:didEndMappingPrefix:)] )
        {
        [myCurrentDelegate parser:parser didEndMappingPrefix:prefix];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:foundCharacters:)] )
        {
        [myCurrentDelegate parser:parser foundCharacters:string];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundIgnorableWhitespace:(NSString *)whitespaceString
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser:foundIgnorableWhitespace:)] )
        {
        [myCurrentDelegate parser:parser foundIgnorableWhitespace:whitespaceString];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
foundProcessingInstructionWithTarget:(NSString *)target
          data:(NSString *)data
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser: foundProcessingInstructionWithTarget: data:)] )
        {
        [myCurrentDelegate parser:parser foundProcessingInstructionWithTarget:target data:data];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
  foundComment:(NSString *)comment
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser: foundComment:)] )
        {
        [myCurrentDelegate parser:parser foundComment:comment];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
    foundCDATA:(NSData *)CDATABlock
{
    if ( myCurrentDelegate && [myCurrentDelegate respondsToSelector:@selector(parser: foundCDATA:)] )
        {
        [myCurrentDelegate parser:parser foundCDATA:CDATABlock];
        }
}

/***************************************************************\**
 \brief 
 \returns 
 *****************************************************************/
- (NSData *)parser:(NSXMLParser *)parser
resolveExternalEntityName:(NSString *)name
          systemID:(NSString *)systemID
{
    if ( myCurrentDelegate )
        {
        return [myCurrentDelegate parser:parser resolveExternalEntityName:name systemID:systemID];
        }
    
    return nil;
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
parseErrorOccurred:(NSError *)parseError
{
    if ( myCurrentDelegate )
        {
        [myCurrentDelegate parser:parser parseErrorOccurred:parseError];
        }
}

/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)parser:(NSXMLParser *)parser
validationErrorOccurred:(NSError *)validationError
{
    if ( myCurrentDelegate )
        {
        [myCurrentDelegate parser:parser validationErrorOccurred:validationError];
        }
    
    [self cancelTimeout];
}

#pragma mark - Timeout Handler -
/***************************************************************\**
 \brief 
 *****************************************************************/
- (void)timeoutHandler
{
    if ( myFirstDelegate )
        {
        [myFirstDelegate parser:self parseErrorOccurred:[NSError errorWithDomain:@"BMLT_Parser Timeout" code:-1 userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"PARSER-TIMEOUT-SEARCH",nil) forKey:NSLocalizedDescriptionKey]]];
        }
    [self cancelTimeout];
}
@end;
