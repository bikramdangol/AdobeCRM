package components.navigation.events
{
	import flash.events.Event;
	
	import model.beans.ReportItem;

	public class ReportsDrawerEvent extends Event
	{
		public static const POPULATE : String = "populate";

		private var _report : ReportItem;

		public function get report() : ReportItem
		{
			return _report;
		}

		public function set report( value : ReportItem ) : void
		{
			if ( !value )
				return;

			_report = value;
		}

		override public function clone() : Event
		{
			return new ReportsDrawerEvent( this.type , this.report , this.bubbles );
		}

		public function ReportsDrawerEvent( type : String , report : ReportItem , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );

			_report = report;
		}
	}
}