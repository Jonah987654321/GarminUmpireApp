import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.ActivityRecording;

class HockeyUmpireApp extends Application.AppBase {
    private var view;
    private var session = null;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        // Activity to use activity watch behavior (dnd+aod)
        if (Toybox has :ActivityRecording) {
            session = ActivityRecording.createSession({
                 :name=>"Umpiring",
                 :sport=>Activity.SPORT_GENERIC,
                 :subSport=>Activity.SUB_SPORT_GENERIC
           });
           session.start(); 
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        // Do not save yet, recording is only for behavior
        session.stop();
        session.discard();
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