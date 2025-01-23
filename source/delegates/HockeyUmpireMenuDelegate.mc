import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class HockeyUmpireMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        switch (item.getId()) {
            case :menuSelectGamePreset:
                System.println("menuSelectGamePreset");
                break;
            case :menuNewGame:
                var messageId = Rez.Strings.mainMenuNewGameConfirmation;
                var message = Application.loadResource(messageId);
                var confirmation = new WatchUi.Confirmation(message);
                WatchUi.pushView(confirmation, new newGameConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
                break;
            case :menuExitApp:
                System.exit();
        }
    }

}