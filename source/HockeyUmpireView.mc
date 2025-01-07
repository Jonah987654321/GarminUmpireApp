import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;

class HockeyUmpireView extends WatchUi.View {

    // Vars & Elements for Score:
    private var _scoreTeam1;
    private var _scoreTeam2;

    private var _scoreTeam1Element;
    private var _scoreTeam2Element;


    // Timer
    private var _timeInPeriod;
    private var _currentPeriod;
    private var _totalPeriods;

    private var _periodDisplayElement;
    private var _timerElement;

    function initialize() {
        View.initialize();
        _scoreTeam1 = 0;
        _scoreTeam2 = 0;

        _currentPeriod = 1;
        _totalPeriods = 2;

        _timeInPeriod = 60*15;
    }

    public function updateScore(team) as Void {
        switch (team) {
            case 1:
                _scoreTeam1++;
                break;
            case 2:
                _scoreTeam2++;
                break;
        }

        WatchUi.requestUpdate();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _scoreTeam1Element = findDrawableById("scoreTeam1");
        _scoreTeam2Element = findDrawableById("scoreTeam2");

        _periodDisplayElement = findDrawableById("periodDisplay");
        _timerElement = findDrawableById("timer");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        _scoreTeam1Element.setText(_scoreTeam1.toString());
        _scoreTeam2Element.setText(_scoreTeam2.toString());

        _periodDisplayElement.setText(_currentPeriod+"/"+_totalPeriods);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    private function updateTimerDisplay() as Void {
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
