import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Time;

class HockeyUmpireDelegate extends WatchUi.InputDelegate {
    private var _downPressStart;

    function initialize() {
        InputDelegate.initialize();
    }

    function onKey(key as WatchUi.KeyEvent) as Boolean {
        if (key.getKey() == WatchUi.KEY_MENU) {
            WatchUi.pushView(new Rez.Menus.MainMenu(), new HockeyUmpireMenuDelegate(), WatchUi.SLIDE_UP);
            return true;
        }
        if (Application.getApp().getGameState() != 0) {
            switch(key.getKey()) {
                case WatchUi.KEY_UP:
                    Application.getApp().getView().updateScore(1);
                    return true;
                case WatchUi.KEY_ESC:
                    Application.getApp().getView().nextPeriodButton();
                    return true;
                case WatchUi.KEY_ENTER:
                    Application.getApp().getView().toggleTimer();
                    return true;
                default:
                    return false;
            }
        }
        return false;
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        if (key.getKey() == WatchUi.KEY_DOWN) {
            _downPressStart = Time.now();
            return true;
        }
        return false;
    }

    function onKeyReleased(key as WatchUi.KeyEvent) as Boolean {
        if (Application.getApp().getGameState() != 0) {
            if (key.getKey() == WatchUi.KEY_DOWN) {
                if (Time.now().value() - _downPressStart.value() > 0) {
                    // Button long press => Quick game options
                    WatchUi.pushView(new Rez.Menus.QuickGameOptions(), new HockeyUmpireGameOptionsDelegate(), WatchUi.SLIDE_UP);
                } else {
                    // Button quick press => Add goal
                    Application.getApp().getView().updateScore(2);
                }
                return true;
            }
        }
        return false;
    }

    // Prevent touch behavior
    function onRelease(clickEvent as WatchUi.ClickEvent) {
        return true;
    }

}