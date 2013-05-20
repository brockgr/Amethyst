//
//  AMConfiguration.m
//  Amethyst
//
//  Created by Ian on 5/19/13.
//  Copyright (c) 2013 Ian Ynda-Hummel. All rights reserved.
//

#import "AMConfiguration.h"

#import "AMHotKeyManager.h"
#import "AMWindowManager.h"

#import <Carbon/Carbon.h>

@implementation AMConfiguration

- (void)setUpWithHotKeyManager:(AMHotKeyManager *)hotKeyManager windowManager:(AMWindowManager *)windowManager {
    [hotKeyManager registerHotKeyWithKeyCode:kVK_Space modifiers:NSCommandKeyMask | NSShiftKeyMask handler:^{
        [windowManager cycleLayout];
    }];

    // ANSI 1-3 are consecutive values in the virtual layout.
    // As far as I know Mac systems don't support more than three screens (laptop with 2 monitors) so this is probably fine
    for (NSUInteger screenIndex = 1; screenIndex <= 3; ++screenIndex) {
	UInt16 keyCode = kVK_ANSI_1 + (screenIndex - 1);
	[hotKeyManager registerHotKeyWithKeyCode:keyCode modifiers:NSControlKeyMask | NSShiftKeyMask handler:^{
	    [windowManager throwToScreenAtIndex:screenIndex];
	}];
    }
}

@end
