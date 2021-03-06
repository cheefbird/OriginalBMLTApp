DESCRIPTION
-----------

Project homepage: http://bmlt.magshare.net/

This project is a native BMLT client app for iOS (iPhones, iPads, iPod Touch, etc.). It is different from the Web-based
app, because most of the action happens in the device; not on the Web server or Web browser.

The app uses the XML export function of the BMLT root server (http://bmlt.magshare.net/semantic/) to gather data on
the BMLT root servers, and will, eventually, execute searches transparently across multiple servers.

The initial version of the app will be "tuned" to specific servers, as opposed to being a general-purpose app.

REQUIREMENTS
------------
This is an iOS app, made for iPhones and iPads. It is only available via the Apple App Store, and requires iOS 5.0 or above.

INSTALLATION
------------

This will be installed via the Apple App Store, and will be a free app.

LICENSE
-------
This is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

BMLT is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this code.  If not, see <http://www.gnu.org/licenses/>.

NOTE ON THE VERSION 2.7 PROJECT
-------------------------------

The chief difference is the addition of a "Where Am I Now?" button. If this is tapped, a search looks in the
immediate vicinity and time (+-90 minutes) for a meeting.
If it finds one, it immediately opens it. If it finds more than one, it shows a list response
(even if the app is set to prefer map responses).
This was done chiefly to afford the new "Send A Comment" feature.
This is where the BMLT Root Server can be set up to support email contacts about particular meetings
(must be server version 2.4.3+, with the feature turned on, and email addresses available).

NOTE ON THE VERSION 2.6 PROJECT
-------------------------------

This has been worked over to provide a better iOS 7 experience, with all the "skeuomorphism" now gone.
The minimum OS level is now 6.0, with the target being 7.0 and greater.
The biggest new feature is that the black markers will be draggable in all maps. This includes the map results in the iPhone version.

NOTE ON THE VERSION 2.5 PROJECT
-------------------------------

The biggest change with the 2.5 project, is that most the original "skeuomorphic" UX has been removed ("skeuomorphic" refers
to the appearance of real-world items and textures, such as leather and metal). The main reason for this (besides presenting
a more modern appearance) is that the app is now much, MUCH smaller, and will respond a great deal more quickly.

NOTE ON THE VERSION 2.0 PROJECT
-------------------------------

The Version 2.0 project is a major rewrite. It is starting from a fundamental re-architecture, based on a model more in line
with a traditional iOS program.

The main app is still a UITabController app, but the search specification has been broken away from the results, and everything
is being handled in a far more modeless (read: "buggy") manner.

There is now no cross-controller communication. Everything must go through the app delegate, which is a strict "fulcrum."

A bunch of stuff has been factored into abstract base classes and shared throughout.

This is an ARC program, and uses storyboards. It is now aimed at a minimum iOS 5.0 OS level. I still can't believe there's no leaks.
It feels...wrong.

The iPad and the iPhone now have drastically divergent user experiences. The iPad version now introduces a map with a draggable
marker as a search specification.

There are now more settings and preferences, including a slider that allows the user to select the density of the meetings returned
in proximity searches.

A fair bit of code from the 1.0 version has been adapted (none of it could come over straight, without modification), but the lions'
share of the code is new.

The variant now has the entire UX. This allows the app to be heavily customized and "skinned" (also making new variants more difficult
to produce). This is because Apple will no longer allow simple "reskins" of a central design. It will also allow the creation of a
richer user experience.

The "combined" Localized file is no more. We are back to a single Localizable.strings file.

The code has been anal-retentively commented with Doxygen comments.

The new app will read the prefs from the original, but this is really meant to be an entirely different app, as the UX is so different.

CHANGELIST
----------

***Version 2.7.6* ** *- TBD*

* Updated all targets to Xcode 8/iOS 8+ compatible.

*Version 2.7.5*

* June 8, 2015
* Added the NA Hawaii version.

*Version 2.7.4*

* May 26, 2015
* Now disable dragging the black marker in iPhone. Even the 6 Plus doesn't really make enough room to make the feature useful, and there's a minor bug that would need to be fixed. Not worth it.
* Fixed some deprecated calls that prevented an Xcode 6 compile.
* Made this document a markdown (.md) file, for better display on BitBucket.
* Fixed a couple of issues with the placement of the text items on the individual meeting display page.
* Changed the Root URI of the NA Australia variant.
* Raised minimum OS Support Level to 7.0.
* Fixed the display of the meeting details so that the map is displayed as large as possible.

*Version 2.7.3*

* September 1, 2014
* Added temporary variant for the Multi-Zonal Service Symposium

*Version 2.7*

* June 18, 2014
* Release of the final 2.7 version for NY, San Diego and Ireland

*Version 2.7b4*

* June 15, 2014
* Work to make the location more accurate.

*Version 2.7b2*

* June 11, 2014
* The black marker in meeting details screens was draggable. This is no longer the case.
* Added French localization.
* Added the ability to display a label over the simple search choices. This helps in some localization.
* Added support for an optional directions button under the Details map in iPhone.
* Added the capability to send "comments" (emails, really), concerning specific meetings, if the server supports it.
* Added a "Where Am I Now?" capability to the simple search. This will be helpful for the new comment feature.
* Made the handling of bad server connections a lot more robust.
* Added Ireland variant.
* The Advanced keyboard now puts itself away on finishing editing.

*Version 2.6*

* November 24, 2013
* No changes from the last beta. This is the official release.

*Version 2.6b1*

* November 24, 2013
* Fixed a cosmetic issue, where the advanced text field was cut off by the keyboard in 3.5 inch screens.
* Couple of minor cosmetic tweaks in the Advanced Search screen.
* Minor tweak to the "busy animation" screen.
* The initially-selected weekday for going into the "weekdays" mode of the advanced screen was not selecting the proper day for weeks starting on non-Sunday days. This is fixed.

*Version 2.6b0*

* November 23, 2013
* Fixed an issue with the cancel button during the animation screen. It is now a regular button, labeled "CANCEL."
* Made the font in the black marker popup a bit bigger.

*Version 2.6a3*

* November 23, 2013
* Added some "breathing room" around the new popup window for the black marker in the map results screen.
* Changed the color theme to a colored top and bottom bar (in iOS7), and darker backgrounds, because of the visibility issues introduced by iOS 7 buttons.
* Added a new Swedish translation for the black marker popup.
* Made the settings selection between simple and advanced preferred search type a bit more useful. Selecting advanced now gives nothing but the advanced, and simple gives simple, but with the ability to navigate to advanced.

*Version 2.6a1*

* November 16, 2013
* Changed the app to use a different type of checkbox. This one works better with iOS7, and reduces the size of the app.
* Several cosmetic changes to make the app work better with iOS7. No more fancy buttons. Makes the app smaller, too.
* Got rid of the usably useless location button in the Advanced screen of the iPad version.
* Added robustness to the location finding mechanism.
* Added robustness to the network checking mechanism.
* Fixed a rather nasty dragging bug that no one seems to have noticed (probably because they don't use the map marker drag).
* Added support for weeks starting on days of the week other than Sunday.
* Added the ability to do a new map search on iPads (and iPhones) by dragging the black marker to new places on the Map Search Results screen. You can't have "1-tap" in Map Search Results because that interferes with tapping on the result markers.
* Made the dragging marker more usable.

*Version 2.5.7*

* September 12, 2013
* SoCal NA Release

*Version 2.5.3*

* September 12, 2013
* NY NA Meetings iOS 7 Edition Release
* Added some spacing for the "Satellite View/Map View" button, as it jams up against the other nav buttons in iOS 7.

*Version 2.5.2*

* September 6, 2013
* SV NA Release

*Version 2.5.1*

* June 25, 2013
* AU NA Meetings Release
* Replaced the original Google geocoder with the built-in one (Should have done that ages ago). This affects the Advanced Search window.
* Fixed an old bug, in which pressing the "GO" button in the Advanced Search screen on an iPad ignored entered text (unless "Return" had been previously hit).

*Version 2.5.4*

* January 10, 2013
* MNNA Release.

*Version 2.5*

* December 28, 2012
* This includes a complete replacement of the original skeuomorphic UX with newer, "cleaner" UX.
* Rearranged the UX a bit, so that it is more obvious where we can switch between map and satellite view.
* Made handling of location errors a bit more robust.

*Version 2.0.5*

* December 17, 2012
* MNNA release

*Version 2.0.4*

* October 17, 2012
* Fixes a cosmetic bug introduced by iOS 6 maps (the center marker in the search map on iPads wasn't displaying correctly).

*Version 2.0.3*

* October 9, 2012
* MNNA release

*Version 2.0.2*

* October 9, 2012
* Updated to fully support the iPhone 5

*Version 2.0.1*

* May 13, 2012
* App Store release for the MNNA app.

*Version 2.0*

* May 6, 2012
* Official App Store release. No changes from b13, except for this note and the version number.

*Version 2.0b13*

* Cinco De Mayo
* Addressed a usability issue. The "brass" checkboxes are hard to see, as far as contrast between off (blank button) and "on" (green check). I addressed this by making "off" a red "X".

*Version 2.0b12*

* May 4, 2011
* Fixed a bug, in which the GO button in the advanced search would not respond, when entered for a second time (iPhone).

*Version 2.0b11*

* May 4, 2011
* Usability issue. When Any Day is selected in Advanced, every day should display a green check, not a red X.

*Version 2.0b10*

* May 2, 2012
* This fixes a small, annoying bug, in which switching away from an open single meeting details page, then coming back, would reset the map. This would wipe out satellite views and/or zooms.

*Version 2.0b9*

* May 2, 2012
* Fixed a bug, in which the sort header in the list results was sometimes out of kilter with the list. This could be demonstrated by selecting "Sort Search Results By List" in the prefs, doing a search, displaying as a list, then clicking on "Sort By Time." Then clear the search results, and do another search. The new search would be sorted by distance, but the header would say it is sorted by time.

*Version 2.0b8*

* May 2, 2012
* Refactored the search results array a bit, so that there is never more than the one central object.
* Fixed a bug, in which the "sort by distance" pref was being ignored first time through.

*Version 2.0b7*

* May 1, 2012
* Fixed a bug, in which zero-length durations were being shown as time-same time. Fixed by removing the duration completely. It is up to each meeting to make sure their duration is recorded properly.

*Version 2.0b6*

* May 1, 2012
* Had to retract the submission to the App Store, because I found a late bug that will require fairly substantial testing. The bug was that selecting "Weekdays" in the search, and then selecting multiple weekdays, then going to "Tomorrow," or "Later Today," the previously selected days would be included in the search. This requires pretty thorough testing of the app, so the release is being delayed.

*Version 2.0b5*

* April 30, 2012
* Fixed a bug, in which leaving a meetings detail opened in Map of List, then going to the other view, and opening meeting details, left the meeting details NavBar open on the previous view.

*Version 2.0b4*

* April 30, 2012
* Make sure that the print popover goes away when the screen is changed on the iPad (It was sticking around afte a window is dismissed using the Navigation Bar, as it is not really a true popover).

*Version 2.0b3*

* April 29, 2012
* The behavior of the app between invocations was incorrect, and inconsistent with the user settings. This change touches a fair bit of code, and requires a lot of testing. It may delay the release by a day or two.

*Version 2.0b2*

* April 28, 2012
* Fixed a small bug that prevented the settings tab from being reset on the iPhone, when restarting the app.

*Version 2.0b1*

* April 28, 2012
* Resized the iPhone meeting details comment text item to allow more text to be shown.

*Version 2.0b0*

* April 27, 2012
* Tweaked the shadow images in the iPad version to look a bit more "3D."
* This release will be made entirely through TestFlight.
* Switched to the new Team ID (TestFlight).
* The top shadow image was slightly misaligned. I moved it up 2 pixels.
* Increased the distance that requires individual (blue marker) meetings be combined into red markers. This is because close markers don't work well with chubby paws like mine.
* Added a slightly different button graphic for the "Update My Location" buttons, as the original one was a bit obtuse.
* A tiny bit of tweaking to reduce the cyclomatic complexity of a couple of routines. Nothing is actually very bad, and the only (about 6) routines above 15 would require a fairly substantial refactoring -not a good idea in beta.
* Added a bit of code to shove the formats over to the left a bit if they crowd the distance (mostly on iPhones).
* Removed one of the reachability callbacks, as it's not necessary (host is all we need), and it caused one of the high cyclo counts, and also showed "false positive" messages when the network was, indeed, reachable.

*Version 2.0a3*

* April 26, 2012
* Fixed a nasty stealth bug that only showed up when in connection trace debug.
* The duration wasn't being parsed correctly. It is now being parsed properly.
* Got the duration displaying well.
* Fixed a nasty bug, where selecting "Later Today," then another choice in Advanced, results in a truncated search.
* Added code for the testflightapp.com framework. Beta will use that.

*Version 2.0a2*

* April 25, 2012
* Fixed a couple of extremely minor cosmetic issues with displayed images and text.
* Now make the location update come in twice before setting the marker. Seems to be a scoche more accurate.
* Reduced the size of the map in the iPad Simple view, so we no longer have the problem of the map zoom changing every time we switch from simple to advanced and back again.
* Performed some optimization on the piggy splash screens, which brings the app down to a more reasonable 4MB.

*Version 2.0a1*

* April 24, 2012
* Made the lower shadow bar (on iPads) smaller.
* Refactored the map results view a bit to make it more robust.
* Gave the list popovers (on map view in iPad) the theme popover background.
* Added a Beanie "watermark" to the About view.
* Fixed a bug, in which alerts displayed during startup interfered with the search and location.
* Tweaked the Doxygen output slightly, so this file is included in the main page.

*Version 2.0a0*

* April 23, 2012
* Toned down the colors of the red and blue indicators in the list view to better match the color of the annotations they represent.
* Added the app icons.
* Added a basic, simple "steampunk" theme for the baseline. This involves creation of a number of graphical assets. This theme is designed to keep the file size down.
* Make sure that the address lookup doesn't happen when switching away from Advanced while the keyboard is open.

*Version 2.0d6*

* April 22, 2012
* Added a "Directions" button to the navbar on iPad.
* The meeting details kept appearing with leftover map stuff. I now establish the same view, each time.
* Moved the "find me" button for the advanced search out of the weekday collective, so it will stay in its corner, properly.

*Version 2.0d5*

* April 22, 2012
* Added the ability to tap in the search map to change the location of the marker (iPad only).

*Version 2.0d4*

* April 22, 2012
* Fixed a bug, where the settings title was wrong in the iPhone.
* Now set the search animation title at instantiation time, so it will be displayed.
* Fixed an iPhone bug, in which an advanced address could be carried back to the simple search.
* Stop the iPhone and iPad text entry fields from clearing their contents when editing begins.
* Improved the technical documentation.
* The default pref for results is map, for iPad (since the map featured so prominently in the search).
* All annotations highlight, now. Not just the red ones.

*Version 2.0d3*

* April 21, 2012
* Now hide the "find me" button for iPad if Location Services are unavailable.
* Fixed a bug, in which the search animation screen could get mixed up with the search screens.

*Version 2.0d2*

* April 21, 2012
* Now disable the simple searches and the advanced search "Near Me" if location services are disabled. This is for the iPhone only. The iPad can still use the map marker.

*Version 2.0d1*

* April 21, 2012
* Changed the way in which the annotation numbers are assigned, which improves the stability of those numbers. i.e. You will get the same numbers, over and over, for the same searches. The previous method would often yield different numbers, each time.
* Rearranged some of the localized strings, so they are now in the info.plist file. This makes it more practical to produce different variants.
* Stopped the text entry from registering an error if it is blank, in advanced search. This caused annoyance in the iPhone app.
* Made the animation load happen programmatically, as opposed to via storyboard.

*Version 2.0d0*

* April 19, 2012
* Major rewrite. This will be an entrirely new app. The model code, and some of the various supporting code will be used, but the app framework will be very different.

MAJOR VERSION UPGRADE
---------------------

*Version 1.3.2*

* TBD
* Made the search in progress animation a bit more modeless, as occasional "hiccups" seem to occur when an iPad is rotated.

*Version 1.3.1*

* February 29, 2012
* Now make sure that no new search is made at all if the "Start With Search" is OFF. The app retains its previous state.
* There was a bug, in which starting with no search on startup, resulted in a disabled intro screen.

*Version 1.3*

* February 27, 2012
* Fixed a very small temporary memory leak that was caused by some overly complex code. In reality, it wasn't a memory leak, but played one on TV.
* The error handler for the network issue was too "sticky." I had to change the way the driver was initialized, so using the app subsequent to a failure would "pick it up" again.
* Changed the way that the app checks the network connectivity and does its startup. It's much more asynchronous now.

*Version 1.2.1*

* February 17, 2012
* Added an error handler for being unable to find the server.
* Added a version for Georgia that is not meant for release. It is an internal testing-only version.

*Version 1.2*

* February 8, 2012
* Added a version for Minnesota that carries their branding, and is released through their account.

*Version 1.1.2*

* November 23, 2011
* Turned on the option to parse the comments field for phone numbers.
* Changed the "MD" variant to "MDC," and re-released it.

*Version 1.1.1*

* November 19, 2011
* Changes the app icon to bring the app in line with Apple App Store Policy (Each variant of the app now has a slightly different icon).

*Version 1.1*

* November 11, 2011
* Made it so that the quick search will be disabled if an initial location lookup is not done, but it will dynamically re-enable if a subsequent manual lookup is done.
* Added preferences for starting in a search, and for preferring an advanced search as the first choice (iPhone/iPod Touch only).
* Added Swedish localization. This will be available when BMLT-SV is released.
* Fixed a bug in the parser that manifested in Swedish, but could have affected other languages, as well. It would result in incomplete strings being displayed.
* Removed the "brass" checkboxes from the meeting sort row, and the whole row now acts as a big checkbox. This gives us a lot more room, and is more consistent with standard iPhone UI.
* Various cosmetic tweaks and fixes.
* Made the format buttons slightly more "3D," so they afford touching. I found people weren't touching them, as they seem display-only.
* Removed the sort header, to more easily afford touching, while still providing more room for the data display.
* Midnight and noon meetings are now reported with "Midnight" and "Noon."
* Removed the current location from the calculation of the map size, as this could cause extremely zoomed-out maps when using the typed-in address. The black marker is visible, but it may be offscreen.
* Fixed a bug in the Kilometer display (the units were not being converted to KM).
* Fixed a possible crash if there was an error in the parsing.
* This release introduces BMLT-CT and BMLT-MD.
* Fixed a couple of places where "(null)" could be displayed for strings.

*Version 1.0.1*

* October 27, 2011
* Simplified the parser calls in the BMLT_Server class.
* Starting up the app will put you at the search page for whichever search you select (list or map).
* Fixed an issue with weeks that start on Monday.
* This is the version that includes the BMLT-UK project.

*Version 1.0*

* October 17, 2011
* Oh, what the heck. Go for the gusto. I'll submit the following to the App. Store: BMLT-FL, BMLT-MN, BMLT-NY and BMLT-TXOX.

*Version 1.0RC0*

* October 17, 2011
* The green check image had a slight flaw (surrounding band the wrong color). It has been fixed.

*Version 1.0b2*

* October 16, 2011
* Reduced the file size slightly, by removing some unused images.
* Made the formats in the meeting detail view a bit bigger, so they will be easier for chubby fingers.

*Version 1.0b1*

* October 15, 2011
* If there is only 1 result in the list, the time/distance sort will not be shown.

*Version 1.0b0*

* October 14, 2011
* The localization for the settings items wasn't being done. That is now fixed.
* Added the ability to dynamically update the location from the settings dialog, including adding a new button.
* The tabs now reset to their root view when they are deselected. This prevents searches from being left open.
* The Settings tab really needs to be always portrait for iPhone.
* Made it easier to add new variants.

*Version 1.0a3*

* October 13, 2011
* Disable the swipes in the List and Map screens when there are search results present.
* in some cases, there may be no distance in the returned meetings. I now hide the distance sort and the invalid distance, if that happens.
* There was a bug in the Prefs screen, where touching the text for Prefer Distance Sort changed both it, and the one above. That has been fixed.

*Version 1.0a1*

* October 12, 2011
* Removed the dimming of the Prefer Distance Sort switch if Core Location services are unavailable, or if the Find My Location is off. It did not make sense.

*Version 1.0a0*

* October 11, 2011
