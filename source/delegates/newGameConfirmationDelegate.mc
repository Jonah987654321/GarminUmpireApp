import Toybox.WatchUi;
import Toybox.System;

class newGameConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_YES) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            Application.getApp().reset();
            return true;
        } else {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.pushView(new Rez.Menus.MainMenu(), new HockeyUmpireMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return true;
        }
    }
}
