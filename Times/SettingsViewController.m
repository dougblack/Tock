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
    self.tableView.backgroundColor = [CommonCLUtility viewDarkBackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    [self.tableView registerClass:[SettingsCell class] forCellReuseIdentifier:@"Settings"];
    [self.view addSubview:self.tableView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] init];
    [settingsButton setAction:@selector(openSettings)];
    [settingsButton setTarget:self];
    settingsButton.title = @"\u2699";
    UIFont *f1 = [UIFont fontWithName:@"Helvetica" size:24.0];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:f1, UITextAttributeFont, nil];
    [settingsButton setTitleTextAttributes:dict forState:UIControlStateNormal];
    [toolbar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *startAllButton = [[UIBarButtonItem alloc] initWithTitle:@"START ALL" style:UIBarButtonItemStylePlain target:self action:@selector(startAll)];
    [startAllButton setTintColor:[UIColor colorWithRed:0.0 green:0.8 blue:0.3 alpha:1]];
    [startAllButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0 green:0.8 blue:0.3 alpha:1]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    NSArray *toolBarItems = [NSArray arrayWithObjects:startAllButton, flexibleSpace, settingsButton, nil];
    [toolbar setItems:toolBarItems];
    [self.view addSubview:toolbar];
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
