import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Time;

class HockeyUmpireDelegate extends WatchUi.InputDelegate {
    private var _view;
    private var _downPressStart;

    function initialize(view) {
        InputDelegate.initialize();
        self._view = view;
    }

    function onKey(key as WatchUi.KeyEvent) as Boolean {
        switch(key.getKey()) {
            case WatchUi.KEY_UP:
                self._view.updateScore(1);
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

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        if (key.getKey() == WatchUi.KEY_DOWN) {
            _downPressStart = Time.now();
            return true;
        }
        return false;
    }

    function onKeyReleased(key as WatchUi.KeyEvent) as Boolean {
        if (key.getKey() == WatchUi.KEY_DOWN) {
            if (Time.now().value() - _downPressStart.value() > 0) {
                // Button long press => Quick game options
                WatchUi.pushView(new Rez.Menus.QuickGameOptions(), new HockeyUmpireGameOptionsDelegate(), WatchUi.SLIDE_UP);
            } else {
                // Button quick press => Add goal
                self._view.updateScore(2);
            }
            return true;
        }
        return false;
    }

    // Prevent touch behavior
    function onRelease(clickEvent as WatchUi.ClickEvent) {
        return true;
    }

}