import Toybox.Lang;
import Toybox.WatchUi;

class HockeyUmpireDelegate extends WatchUi.BehaviorDelegate {
    private var _view;

    function initialize(view) {
        BehaviorDelegate.initialize();
        self._view = view;
    }

    function onSelect() as Boolean {
        self._view.toggleTimer();
        return true;
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new HockeyUmpireMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onNextPage() as Boolean {
        self._view.updateScore(2);
        return true;
    }

    function onPreviousPage() as Boolean {
        self._view.updateScore(1);
        return true;
    }

    function onBack() as Boolean {
        self._view.nextPeriodButton();
        return true;
    }

}