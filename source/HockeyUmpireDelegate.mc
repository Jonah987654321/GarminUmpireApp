import Toybox.Lang;
import Toybox.WatchUi;

class HockeyUmpireDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new HockeyUmpireMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}