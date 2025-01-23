using Toybox.ActivityRecording;

class ActivityManager {
    private var sessionRunning;
    private var sessionCreated;
    private var session;
    private var activitiesEnabled;

    function initialize() {
        sessionRunning = false;
        sessionCreated = false;
        activitiesEnabled = Toybox has :ActivityRecording;
    }

    public function startSession() {
        if (activitiesEnabled) {
            if (!sessionCreated) {
                _createSession();
                sessionCreated = true;
            }
            session.start();
        }
    }

    public function stopSession() {
        if (sessionCreated) {
            session.stop();
            session.discard();

            sessionCreated = false;
        }
    }

    private function _createSession() {
        if (activitiesEnabled) {
            session = ActivityRecording.createSession({
                 :name=>"Umpiring",
                 :sport=>Activity.SPORT_GENERIC,
                 :subSport=>Activity.SUB_SPORT_GENERIC
           });
        }
    }
}