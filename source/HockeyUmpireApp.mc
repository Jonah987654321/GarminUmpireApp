import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class HockeyUmpireApp extends Application.AppBase {
    private var baseView;
    private var gameView;
    private var gameState;
    private var activityManager;

    function initialize() {
        AppBase.initialize();
        activityManager = new ActivityManager();
        gameState = 0;
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        activityManager.startSession();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        activityManager.stopSession();
    }

    function getGameState() {
        return gameState;
    }

    function getView() {
        if (gameState == 0) {
            return baseView;
        } else {
            return gameView;
        }
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var view = new BaseView();
        self.baseView = view;
        return [view, new HockeyUmpireDelegate()];
    }

    function newGameView() {
        if (gameState == 0) {
            self.gameState = 1;
            var view = new GameView();
            self.gameView = view;
            WatchUi.pushView(view, new HockeyUmpireDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
    }

}

function getApp() as HockeyUmpireApp {
    return Application.getApp() as HockeyUmpireApp;
}