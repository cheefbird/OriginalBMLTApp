//
//  MeetingDisplayCellView.h
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

#import <UIKit/UIKit.h>
#import "BMLT_Meeting.h"
#import "BMLT_Format.h"
#import "A_SearchController.h"

#define List_Meeting_Name_Text_Size                 16
#define List_Meeting_Display_Text_Size              12

#define List_Meeting_Display_CellHeight             102
#define List_Meeting_Display_Line_Height            24
#define List_Meeting_Format_Circle_Size             24
#define List_Meeting_Format_Line_Padding            2

#define List_Meeting_Format_Distance_Label_Width    80
#define List_Meeting_Format_Weekday_Width           80
#define List_Meeting_Format_Time_Width              60
#define List_Meeting_Format_Town_Width              160

@interface BMLT_FormatButton : UIButton
{
    BMLT_Format         *myFormat;
}
- (id)initWithFrame:(CGRect)frame andFormat:(BMLT_Format *)theFormat;
- (void)setMyFormat:(BMLT_Format *)inFormat;
- (BMLT_Format *)getMyFormat;

@end

@interface MeetingDisplayCellView : UITableViewCell
{
    BMLT_Meeting        *myMeeting;
    A_SearchController  *myModalController;
    UIView              *wrapperView;
}
- (id)initWithMeeting:(BMLT_Meeting *)inMeeting andFrame:(CGRect)frame andReuseID:(NSString *)reuseID andIndex:(int)index;
- (void)setMeetingName;
- (void)setWeekdayAndTime;
- (void)setTownAndState;
- (void)setLocationAndAddress;
- (void)setDistance;
- (void)setFormats;
- (void)setMyModalController:(A_SearchController *)inController;
- (A_SearchController *)getMyModalController;
- (BMLT_Meeting *)getMyMeeting;
@end
