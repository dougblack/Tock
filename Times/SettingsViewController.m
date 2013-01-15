//
//  SettingsViewController.m
//  Tock
//
//  Created by Douglas Black on 1/9/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "SettingsViewController.h"
#import "TimesViewController.h"
#import "CommonCLUtility.h"
#import "SettingsCell.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)init
{
    self = [super init];
    if (self) {

        self.settingNames = [NSMutableArray arrayWithObjects:@"Show Laps", @"Order by Lap", @"Time from Lap", nil];
        NSNumber *settingTypeSwitch = [NSNumber numberWithInt:SettingTypeSwitch];
        self.settingType = [NSMutableArray arrayWithObjects:settingTypeSwitch, settingTypeSwitch, settingTypeSwitch, nil];
    }
    return self;
}

-(void)saveAndClose
{
    [self.timesViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadView
{
    [super loadView];
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    int frameHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, frameHeight-navBarHeight)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [navBarLabel setText:@"Settings"];
    [navBarLabel setBackgroundColor:[UIColor clearColor]];
    [navBarLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [navBarLabel setTextAlignment:NSTextAlignmentCenter];
    [navBarLabel setTextColor:[UIColor whiteColor]];
    [navBarLabel setOpaque:YES];
    [self.navigationItem setTitleView:navBarLabel];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_back.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    [self.tableView registerClass:[SettingsCell class] forCellReuseIdentifier:@"Settings"];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingNames.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *SettingsCellIdentifier = @"Settings";
    
    SettingsCell *settingsCell = [tableView dequeueReusableCellWithIdentifier:SettingsCellIdentifier];
    
    if (settingsCell == nil)
    {
        settingsCell = [[SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettingsCellIdentifier];
    }
    settingsCell.settingName = [self.settingNames objectAtIndex:indexPath.row];
    settingsCell.settingType = [[self.settingType objectAtIndex:indexPath.row] intValue];
    settingsCell.selectionStyle = UITableViewCellSeparatorStyleNone;
    [settingsCell refresh];
    
    
    return settingsCell;
}

@end
