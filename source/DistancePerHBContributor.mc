using Toybox.FitContributor;

const FIT_FIELD_RECORD_ID = 0;
const FIT_FIELD_LAP_ID = 1;
const FIT_FIELD_SESSION_ID = 2;

class DistancePerHBContributor {

	hidden var fitFieldRecord = null;
	hidden var fitFieldLap = null;
	hidden var fitFieldSession = null;
	
	hidden var lapSum  = 0;
	hidden var sessionSum  = 0;
	hidden var lapCount  = 0;
	hidden var sessionCount  = 0;
	hidden var active = true;

    function initialize(dataField) {
		var units; 
        var type = System.getDeviceSettings().distanceUnits;
        if( type == System.UNIT_STATUTE ) {
        	units = WatchUi.loadResource(Rez.Strings.UnitsStatute);
		} else {
        	units = WatchUi.loadResource(Rez.Strings.UnitsMetric);
		}

		fitFieldRecord = dataField.createField("Current", FIT_FIELD_RECORD_ID, FitContributor.DATA_TYPE_FLOAT, 
			{ :mesgType => FitContributor.MESG_TYPE_RECORD, :units => units });
    	fitFieldRecord.setData(0.0);
		fitFieldLap = dataField.createField("Lap", FIT_FIELD_LAP_ID, FitContributor.DATA_TYPE_FLOAT, 
			{ :mesgType => FitContributor.MESG_TYPE_LAP, :units => units });
    	fitFieldLap.setData(0.0);
		fitFieldSession = dataField.createField("Session", FIT_FIELD_SESSION_ID, FitContributor.DATA_TYPE_FLOAT, 
			{ :mesgType => FitContributor.MESG_TYPE_SESSION, :units => units });
    	fitFieldSession.setData(0.0);
    }
	
	function save(value) {
    	Debug.logMessage("DistancePerHBContributor", "save");
    	Debug.logVariable("DistancePerHBContributor", "active", active);

		if (active) {
			lapSum += value;
			lapCount++;
			sessionSum += value;
			sessionCount++;
		}

    	Debug.logVariable("DistancePerHBContributor", "value", active);
    	Debug.logVariable("DistancePerHBContributor", "lapAverage", lapSum / lapCount);
    	Debug.logVariable("DistancePerHBContributor", "sessionAverage", sessionSum / sessionCount);

		fitFieldRecord.setData(value);
		fitFieldLap.setData(lapSum / lapCount);
		fitFieldSession.setData(sessionSum / sessionCount);
	}
	
	function setActive(value) {
    	Debug.logMessage("DistancePerHBContributor", "setActive");
		active = value;
	}
	
	function reset() {
    	Debug.logMessage("DistancePerHBContributor", "reset");
		lapSum  = 0;
		sessionSum  = 0;
		lapCount  = 0;
		sessionCount  = 0;
	}
	
	function lapChange() {
    	Debug.logMessage("DistancePerHBContributor", "lapChange");
		lapSum  = 0;
		lapCount  = 0;
	}
}
