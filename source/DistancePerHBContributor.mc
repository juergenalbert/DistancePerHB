using Toybox.FitContributor;

const FIT_FIELD_ID = 0;

class DistancePerHBContributor {

	hidden var fitField = null;

    function initialize(dataField) {
		fitField = dataField.createField("mPerHB", FIT_FIELD_ID, FitContributor.DATA_TYPE_FLOAT, 
			{ :mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"m/heartbeat" });
    	fitField.setData(0.0);
    }
	
	function save(value) {
		fitField.setData(value);
	}
}
