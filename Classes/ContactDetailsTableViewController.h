/* ContactDetailsTableViewController.h
 *
 * Copyright (C) 2012  Belledonne Comunications, Grenoble, France
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or   
 *  (at your option) any later version.                                 
 *                                                                      
 *  This program is distributed in the hope that it will be useful,     
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of      
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       
 *  GNU General Public License for more details.                
 *                                                                      
 *  You should have received a copy of the GNU General Public License   
 *  along with this program; if not, write to the Free Software         
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */ 

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

#import "ContactDetailsLabelViewController.h"
#import "UIContactDetailsHeader.h"
#import "UIContactDetailsFooter.h"

@interface ContactDetailsTableViewController : UITableViewController<UIModalViewDelegate, UITextFieldDelegate> {
@private
    ABRecordRef contact;
    NSMutableArray *dataCache;
    ContactDetailsLabelViewController *contactDetailsLabelViewController;
    NSMutableArray *labelArray;
    NSIndexPath *editingIndexPath;
@public
    UIContactDetailsHeader *headerController;
    UIContactDetailsFooter *footerController;
}

@property (nonatomic, assign) ABRecordRef contact;

- (void)addSipField:(NSString*)address;

@end
