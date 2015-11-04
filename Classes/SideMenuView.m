//
//  SideMenuViewController.m
//  linphone
//
//  Created by Gautier Pelloux-Prayer on 28/07/15.
//
//

#import "SideMenuView.h"
#import "LinphoneManager.h"
#import "PhoneMainView.h"

@implementation SideMenuView

- (void)updateHeader {
	LinphoneProxyConfig *default_proxy = linphone_core_get_default_proxy_config([LinphoneManager getLc]);

	if (default_proxy != NULL) {
		const LinphoneAddress *addr = linphone_proxy_config_get_identity_address(default_proxy);
		[ContactDisplay setDisplayNameLabel:_nameLabel forAddress:addr];
		char *as_string = linphone_address_as_string(addr);
		[_addressButton setTitle:[NSString stringWithUTF8String:as_string] forState:UIControlStateNormal];
		ms_free(as_string);
		[_addressButton setImage:[StatusBarView imageForState:linphone_proxy_config_get_state(default_proxy)]
						forState:UIControlStateNormal];
	} else {
		_nameLabel.text = @"No account";
		[_addressButton setTitle:NSLocalizedString(@"No address", nil) forState:UIControlStateNormal];
		[_addressButton setImage:nil forState:UIControlStateNormal];
	}
	_avatarImage.image = [LinphoneUtils selfAvatar];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(registrationUpdateEvent:)
												 name:kLinphoneRegistrationUpdate
											   object:nil];

	[self updateHeader];
	[_sideMenuTableViewController.tableView reloadData];
}

- (IBAction)onLateralSwipe:(id)sender {
	[PhoneMainView.instance.mainViewController hideSideMenu:YES];
}

- (IBAction)onHeaderClick:(id)sender {
	[PhoneMainView.instance changeCurrentView:SettingsView.compositeViewDescription];
	[PhoneMainView.instance.mainViewController hideSideMenu:YES];
}

- (IBAction)onAvatarClick:(id)sender {
	// hide ourself because we are on top of image picker
	[PhoneMainView.instance.mainViewController hideSideMenu:YES];
	[ImagePickerView SelectImageFromDevice:self atPosition:CGRectNull inView:nil];
}

- (void)registrationUpdateEvent:(NSNotification *)notif {
	[self updateHeader];
	[_sideMenuTableViewController.tableView reloadData];
}

#pragma mark - Image picker delegate

- (void)imagePickerDelegateImage:(UIImage *)image info:(NSDictionary *)info {
	NSURL *url = [info valueForKey:UIImagePickerControllerReferenceURL];
	[LinphoneManager.instance lpConfigSetString:url.absoluteString forKey:@"avatar"];
	[PhoneMainView.instance.mainViewController hideSideMenu:NO];
}

@end