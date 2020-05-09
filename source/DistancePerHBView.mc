using Toybox.WatchUi;
using Toybox.System;
using Toybox.FitContributor;

class DistancePerHBView extends WatchUi.SimpleDataField {

	hidden var fitContibutor;

    function initialize() {
        SimpleDataField.initialize();        
        
        label = WatchUi.loadResource(Rez.Strings.Label);
        fitContibutor = new DistancePerHBContributor(self);
    }

    function compute(info) {
    	Debug.logMessage("DistancePerHBView", "compute");
		var result = "-.--";
		if (info.currentSpeed != null && info.currentHeartRate != null) {
			result = info.currentSpeed * 60 / info.currentHeartRate;
			fitContibutor.save(result);
		} 
        return result;
    }

    function onTimerLap()
    {
    	Debug.logMessage("DistancePerHBView", "onTimerLap");
		fitContibutor.lapChange();
    }

    function onTimerStart()
    {
    	Debug.logMessage("DistancePerHBView", "onTimerStart");
        fitContibutor.setActive(true);
    }

    function onTimerStop()
    {
    	Debug.logMessage("DistancePerHBView", "onTimerStop");
        fitContibutor.setActive(false);
    }

    function onTimerPause()
    {
    	Debug.logMessage("DistancePerHBView", "onTimerPause");
        fitContibutor.setActive(false);
    }

    function onTimerResume()
    {
     	Debug.logMessage("DistancePerHBView", "onTimerResume");
        fitContibutor.setActive(true);
    }

    function onTimerReset()
    {
    	Debug.logMessage("DistancePerHBView", "onTimerReset");
        fitContibutor.setActive(false);
        fitContibutor.reset();
    }
}