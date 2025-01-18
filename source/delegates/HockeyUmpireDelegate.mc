import Toybox.Lang;
import Toybox.WatchUi;

class HockeyUmpireDelegate extends WatchUi.InputDelegate {
    private var _view;

    function initialize(view) {
        InputDelegate.initialize();
        self._view = view;
    }

    function onKey(key as WatchUi.KeyEvent) as Boolean {
        switch(key.getKey()) {
            case WatchUi.KEY_UP:
                self._view.updateScore(1);
                return true;
            case WatchUi.KEY_DOWN:
                self._view.updateScore(2);
                return true;
            case WatchUi.KEY_ESC:
                self._view.nextPeriodButton();
                return true;
            case WatchUi.KEY_ENTER:
                self._view.toggleTimer();
                return true;
            case WatchUi.KEY_MENU:
                WatchUi.pushView(new Rez.Menus.MainMenu(), new HockeyUmpireMenuDelegate(), WatchUi.SLIDE_UP);
                return true;
            default:
                return false;
        }
    }

    // Prevent touch behavior
    function onRelease(clickEvent as WatchUi.ClickEvent) {
        return true;
    }

}