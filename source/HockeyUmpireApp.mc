import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class HockeyUmpireApp extends Application.AppBase {
    private var view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    function reset() {
        view.reset();
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var view = new HockeyUmpireView();
        self.view = view;
        return [view, new HockeyUmpireDelegate(view) ];
    }

}

function getApp() as HockeyUmpireApp {
    return Application.getApp() as HockeyUmpireApp;
}