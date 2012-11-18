package components.reports.events
{
	import components.reports.IBaseReport;

	import flash.events.Event;

	public class ReportViewEvent extends Event
	{
		public static const MAXIMIZE : String = "maximize";
		public static const MINIMIZE : String = "minimize";

		/**
		 *
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 *
		 */
		public function ReportViewEvent( type : String , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
		}

		override public function clone() : Event
		{
			return new ReportViewEvent( this.type , this.bubbles );
		}
	}
}