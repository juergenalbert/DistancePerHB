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
		var result = "-";
        Debug.logVariable("compute", "info.currentHeartRate", info.currentHeartRate);
        Debug.logVariable("compute", "info.currentSpeed", info.currentSpeed);
		if (info.currentSpeed != null && info.currentHeartRate != null) {
			result = info.currentSpeed * 60 / info.currentHeartRate;
			fitContibutor.save(result);
		} 
        Debug.logVariable("compute", "m per heartbeat", result);
        return result;
    }

}