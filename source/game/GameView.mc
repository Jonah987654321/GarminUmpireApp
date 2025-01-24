import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Math;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Attention;

class GameView extends WatchUi.View {

    // Vars & Elements for Score:
    private var _scoreTeam1;
    private var _scoreTeam2;

    private var _scoreTeam1Element;
    private var _scoreTeam2Element;


    // Vars & Elements for Timer:
    private var _timer;
    private var _timerRunning;
    private var _timeInPeriod;
    private var _currentPeriodIndex;
    private var _currentPeriod;
    private var _allPeriods as Array<Period>?;

    private var _periodDisplayElement;
    private var _timerElement;

    private var _skipPeriodInit;
    private var _skipPeriodElement;


    // Class setup
    function initialize() {
        View.initialize();
        _initValues();
    }

    private function _initValues() as Void {
        _scoreTeam1 = 0;
        _scoreTeam2 = 0;

        _currentPeriodIndex = -1;
        _currentPeriod = 0;
        _allPeriods = [new Period(PeriodType.RegularPeriod, 15*60), new Period(PeriodType.BreakPeriod, 5*60), new Period(PeriodType.RegularPeriod, 15*60)];

        _timer = new Timer.Timer();
        _timerRunning = false;
        _skipPeriodInit = false;
    }

    public function reset() as Void {
        _stopTimer(false);
        _initValues();
        nextPeriod();
        requestUpdate();
    }

    // Function for delegate to manage timer
    public function toggleTimer() as Void {
        if (_timerRunning) {
            _stopTimer(true);
        } else {
            _startTimer(true);
        }

        requestUpdate();
    }

    // Function for delegate to get to next period
    public function nextPeriodButton() as Void {
        if (_currentPeriodIndex < _getPeriodAmount()) {
            if (_skipPeriodInit) {
                _skipPeriodElement.setVisible(false);
                nextPeriod();
                _skipPeriodInit = false;
            } else {
                _skipPeriodElement.setVisible(true);
                _skipPeriodInit = true;
                new Timer.Timer().start(method(:disablePeriodSkip), 1000, false);
            }

            requestUpdate();
        }
    }

    public function disablePeriodSkip() as Void {
        _skipPeriodElement.setVisible(false);
        _skipPeriodInit = false;

        requestUpdate();
    }

    
    public function nextPeriod() as Void {
        if (_currentPeriodIndex < _getPeriodAmount()) {
            _stopTimer(false);
            _currentPeriodIndex++;

            var newPeriod = _allPeriods[_currentPeriodIndex];
            _timeInPeriod = newPeriod.length;
            _updateTimerDisplay();

            if (newPeriod.type == PeriodType.RegularPeriod) {
                _currentPeriod++;
            }
            var periodText = (newPeriod.type == PeriodType.RegularPeriod)?_currentPeriod+"/"+_getPeriodAmount():Rez.Strings.BreakText;
            _periodDisplayElement.setText(periodText);

            requestUpdate();
        }
    }

    // Function for delegate to add goals
    public function updateScore(team) as Void {
        switch (team) {
            case 1:
                _scoreTeam1++;
                break;
            case 2:
                _scoreTeam2++;
                break;
        }
        inputChangeAttention();

        requestUpdate();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.GameViewLayout(dc));

        _scoreTeam1Element = findDrawableById("scoreTeam1");
        _scoreTeam2Element = findDrawableById("scoreTeam2");

        _periodDisplayElement = findDrawableById("periodDisplay");
        _timerElement = findDrawableById("timer");

        _skipPeriodElement = findDrawableById("nextPeriodAttention");

        nextPeriod();
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

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Get amount of regular periods
    private function _getPeriodAmount() {
        var count = 0;
        for (var i=0;i<_allPeriods.size();i++) {
            if (_allPeriods[i].type == PeriodType.RegularPeriod) {
                count++;
            }
        }
        return count;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }



    // --------------------------------------------
    // -------Functions to control the timer-------
    // --------------------------------------------

    private function inputChangeAttention() as Void {
        if (Attention has :vibrate) {
                var vibeData =
                [
                    new Attention.VibeProfile(100, 150)
                ];
                Attention.vibrate(vibeData);
            }
    }

    private function _stopTimer(vibrate) as Void {
        _timer.stop();
        if (vibrate) {
            inputChangeAttention();
        }
        _timerElement.setColor(Graphics.COLOR_RED);
        _timerRunning = false;
    }

    private function _startTimer(vibrate) as Void {
        if (_timeInPeriod > 0) {
            _timer.start(method(:timerTick), 1000, true);
            if (vibrate) {
                inputChangeAttention();
            }
            _timerElement.setColor(Graphics.COLOR_GREEN);
            _timerRunning = true;
        }
    }

    // Timer tick, called once every second as long as the timer is running
    public function timerTick() as Void {
        _timeInPeriod--;

        if (_timeInPeriod == 0) {
            if (Attention has :vibrate) {
                var vibeData =
                [
                    new Attention.VibeProfile(100, 500),
                    new Attention.VibeProfile(0, 100),
                    new Attention.VibeProfile(100, 500),
                    new Attention.VibeProfile(0, 100),
                    new Attention.VibeProfile(100, 1000)
                ];
                Attention.vibrate(vibeData);
            }
            _stopTimer(false);

            if (_currentPeriodIndex == _allPeriods.size()-1) {
                _periodDisplayElement.setText(@Rez.Strings.FinishText);
            }
        }

        _updateTimerDisplay();
        requestUpdate();
    }

    // Update timer on screen
    private function _updateTimerDisplay() as Void {
        var minutes = Math.floor(_timeInPeriod/60);
        var seconds = _timeInPeriod%60;
        _timerElement.setText((minutes>9?minutes.toString():"0"+minutes.toString())+":"+(seconds>9?seconds.toString():"0"+seconds.toString()));
    }
}
