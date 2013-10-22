/* global bind, api, shell, reloadConfig */

// Zephyros configuration
//
// To enable this file as the zephyros config:
// 0) Download and install Zephyros to /Applications
// 1) Save as ~/.zephyros.js
// 2) Open Zephyros Preferences, and enter the following as the Bash command:
//      /Applications/Zephyros.app/Contents/MacOS/zephjs ~/.zephyros.js
//
// For config docs, options, and examples, see:
// https://github.com/sdegutis/zephyros
// https://github.com/sdegutis/zephyros/blob/master/Docs/JavaScript.md
// https://github.com/sdegutis/zephyros/wiki/Sizeup

var MOD_COMBO = ['cmd', 'alt', 'ctrl']; // Modifiers to use for all bindings
var LEFT_TO_RIGHT_RATIO = 0.6;          // Make windows on the left side wider

var MAPPINGS = {
    // Copied/adapted from SizeUp:
    'PAD4': 'pushLeft',
    'PAD5': 'fullscreen',
    'PAD6': 'pushRight',
    'PAD0': 'toNextScreen',

    // Experimental:
    'PAD9': 'showClipboard',
    's':    'runShell',
    'r':    'reloadConfig'
};


// Move a window, as specified by a given frame transformation function.
// This is a utility fn from the Zephyros docs
function moveWindow(fn) {
    var win = api.focusedWindow();
    var frame = win.screen().frameWithoutDockOrMenu();
    if (fn) fn(frame);
    win.setFrame(frame);
}

// Move a window to the given screen.
// This is a utility fn from the Zephyros docs
function moveToScreen(win, screen) {
    if (!screen) return;

    var frame = win.frame();
    var oldScreenRect = win.screen().frameWithoutDockOrMenu();
    var newScreenRect = screen.frameWithoutDockOrMenu();

    var xRatio = newScreenRect.w  / oldScreenRect.w;
    var yRatio = newScreenRect.h / oldScreenRect.h;

    win.setFrame({
      x: Math.round((frame.x - oldScreenRect.x) * xRatio) + newScreenRect.x,
      y: Math.round((frame.y - oldScreenRect.y) * yRatio) + newScreenRect.y,
      w: Math.round(frame.w * xRatio),
      h: Math.round(frame.h * yRatio)
    });
}


// A collection of actions, each suitable to be bound to a keystroke:
var actions = {
    fullscreen: function() {
        api.focusedWindow().maximize();
    },

    toNextScreen: function() {
        var win = api.focusedWindow();
        moveToScreen(win, win.screen().nextScreen());
    },

    pushRight: function() {
        moveWindow(function(frame) {
            var leftWidth = frame.w*LEFT_TO_RIGHT_RATIO;
            frame.x += leftWidth;   // assume window was left-aligned previously
            frame.y = 0;
            frame.w = frame.w - leftWidth;
        });
    },

    pushLeft: function() {
        moveWindow(function(frame) {
            frame.y = 0;
            frame.w = frame.w*LEFT_TO_RIGHT_RATIO;
        });
    },

    reloadConfig: function() { reloadConfig(); },

    // Experimental shit:
    runShell: function() {
        var out = shell('/usr/bin/env', ['ls']);
        alert(out.stdout);
    },

    showClipboard: function() {
        var text = api.clipboardContents();
        alert(text, 1);     // Second param is how many second to show alert
    }
};

// Create bindings from the MAPPINGS object:
for (var k in MAPPINGS) {
    var actionName = MAPPINGS[k];
    bind(k, MOD_COMBO, actions[actionName]);
}
