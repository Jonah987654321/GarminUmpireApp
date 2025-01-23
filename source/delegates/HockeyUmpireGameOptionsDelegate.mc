import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class HockeyUmpireGameOptionsDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        switch (item.getId()) {
            case :menuAdjustGoals:
                System.println("Adjust goals");
                break;
            case :menuAdjustTime:
                System.println("Adjust time");
                break;
        }
    }

}