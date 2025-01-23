import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class HockeyUmpireApp extends Application.AppBase {
    private var view;
    private var activityManager;

    function initialize() {
        AppBase.initialize();
        activityManager = new ActivityManager();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        activityManager.startSession();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        activityManager.stopSession();
    }

    function reset() {
        view.reset();
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var view = new GameView();
        self.view = view;
        return [view, new HockeyUmpireDelegate(view) ];
    }

}

function getApp() as HockeyUmpireApp {
    return Application.getApp() as HockeyUmpireApp;
}