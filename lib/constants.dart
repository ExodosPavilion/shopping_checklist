import 'package:flutter/material.dart';

// ========== SCREEN NAMES ==========
// START

const kChecklistScreen = 'Checklist';
const kHistoryScreen = 'History';
const kPresetScreen = 'Presets';
const kPresetAppDrawer = 'ItemGroup'; //since prests file name is itemgroup
const kSettingsScreen = 'Settings';

// END
// ========== SCREEN NAMES ==========

// ========== SORT ORDER TITLES ==========
// START

const kSortOrder0 = 'Sort by Name (A -> Z)';
const kSortOrder1 = 'Sort by Name (Z -> A)';
const kSortOrder2 = 'Sort by Priority (high -> low)';
const kSortOrder3 = 'Sort by Priority (low -> high)';
const kSortOrder4 = 'Custom order';

//END
// ========== SORT ORDER TITLES ==========

// ========== MULTI-SCREEN CONSTANTS ==========
// START

const kDropDownMenuHigh = 'High';
const kDropDownMenuMedium = 'Medium';
const kDropDownMenuLow = 'Low';

// END
// ========== MULTI-SCREEN CONSTANTS ==========

// ========== CHECKLIST SCREENSTRING CONSTANTS ==========
// START

const kNewItemDialogTitle = 'Enter item info:';

// END
// ========== CHECKLIST SCREENSTRING CONSTANTS ==========

// ========== ITEMGROUP (PRESET) SCREEN STRING CONSTANTS ==========
// START

const kNewPresetDialogTitle = 'Enter preset info:';

const kNewPresetDialogNameHint = 'Enter the preset name';
const kNewPresetDialogInvalidNameError = 'Please enter something';

const kNewPresetDialogAddItemsTitle = 'Add Items';

const kNewPresetDialogNewRowButtonText = 'Add New Item';
const kNewPresetDialogDelRowButtonText = 'Remove Last Item';

const kNewPresetDialogSubmitButtonText = 'Submit';

const kShowPresetAddToCheckListButtonText = 'Add to Check List';

// END
// ========== ITEMGROUP (PRESET) SCREEN STRING CONSTANTS ==========

// ========== SETTINGS SCREEN STRING CONSTANTS ==========
// START

const kDarkModeSwitchTitle = 'Toggle switch to go between light and dark mode';
const kDarkModeSwtichText = 'Dark Mode';

const kUseCardStyleSwitchTitle =
    'Display the list in the checklist screen using cards or not';
const kUseCardStyleSwitchText = 'Use card style';

const kPriorityColorChangerTitle =
    'You can change the default colors used for the prioratized items below';
const kPriorityColorChangerHigh = 'High Priority';
const kPriorityColorChangerMedium = 'Medium Priority';
const kPriorityColorChangerLow = 'Low Priority';

const kChecklistToHistoryCardTitle = 'Move checked items to History';
const kChecklistToHistoryCardWarning =
    'Please note that once you leave this screen the items in the checklist will move to history according to the set time interval';
const kChecklistToHistoryCardCheckTitle = 'Immediately';
const kChecklistToHistoryCardDropDownTitle = 'Select the time interval';
const kChecklistToHistoryCardDropDownItemText = ' Hours';

const kHistoryDeleteCardTitle = 'Delete items older than x months from History';
const kHistoryDeleteCardWarning =
    'Please note that once you leave this screen the items in history will be deleted permanently according to the set time interval';
const kHistoryDeleteCardDropDownTitle = 'Delete Items after';
const kHistoryDeleteCardDropDownITem = ' Months';

const kColorPickerDialogTitle = 'Pick a Color';

// END
// ========== SETTINGS SCREEN STRING CONSTANTS ==========

// ========== SHARED PREFERENCES' KEYS ==========
// START

// key for whether the app theme should be light or dark theme
const kIsDarkTheme = 'isDarkTheme';

// keys for dark theme's priority colors
const kDarkHighPriority = 'darkHighPriority';
const kDarkMediumPriority = 'darkMediumPriority';
const kDarkLowPriority = 'darkLowPriority';

// keys for light theme's priority colors
const kLightHighPriority = 'lightHighPriority';
const kLightMediumPriority = 'lightMediumPriority';
const kLightLowPriority = 'lightLowPriority';

// key for the sort order of the checklist screen
const kSortOrder = 'sortOrder';

// key for the last available index position for the checklist
const kAvailablePosition = 'availablePosition';

// key for determining if the checklist should be card style or not
const kUseCardStyle = 'useCardStyle';

// key for the amount of time that needs to elaspe before the checked items are moved to history
const kTimeIntervalCheckToHistory = 'timeIntervalCheckToHistory';

const kTimeIntervalHistoryDeletion = 'timeIntervalHistoryDeletion';

// key for whether the shared preferences values are set
const kDefaultPreferencesSet = 'defaultPreferencesSet';

// END
// ========== SHARED PREFERENCES' KEYS ==========

// ========== SHARED PREFERENCES' DEFAULTS ==========
// START

// === Color Defaults ===
//
// dark priority colors
const Color kDefaultDarkHighPriority = Color(0xffc62828);
const Color kDefaultDarkMediumPriority = Color(0xffef6c00);
const Color kDefaultDarkLowPriority = Color(0xfff9a825);

// light priority colors
const Color kDefaultlightHighPriority = Color(0xffef5350);
const Color kDefaultlightMediumPriority = Color(0xffffa726);
const Color kDefaultlightLowPriority = Color(0xffffee58);

// shade amount applied for each material pririty color
// refer to the link below to look at what shade is
// https://api.flutter.dev/flutter/material/Colors-class.html
const int kDarkPriorityColorShade = 800;
const int kLightPriorityColorShade = 400;

// === Color Defaults ===

// default sort order, high to low priority
const kDefSortOrder = 2;

// default available positions, 0 since there should be no items yet
const kDefAvailablePositions = 0;

// default time between checking and moving an item to history
// 24 hours later
const kDefCheckToHistoryTimeInterval = 24;

// default time between adding to history and deleting the item
// 1 month later
const kDefHistoryClearTimeIntercal = 1;

// END
// ========== SHARED PREFERENCES' DEFAULTS ==========
