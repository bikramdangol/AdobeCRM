package components.navigation
{
	import components.navigation.events.ReportsDrawerEvent;
	
	import model.ApplicationModel;
	import model.beans.ReportItem;
	
	import spark.components.ComboBox;
	import spark.components.DropDownList;
	import spark.components.Group;
	import spark.events.IndexChangeEvent;

	public class ReportsDrawer extends Group
	{
		/** UI ELEMENTS **/

		[Bindable]
		public var chartComboBox : DropDownList;

		/** MISC PROPERTIES **/
		[Bindable]
		protected var appModel : ApplicationModel = ApplicationModel.getInstance();

		/** HANDLER METHODS **/

		protected function chartComboBox_changeHandler( event : IndexChangeEvent) : void
		{
			var tempTarget : DropDownList = event.target as DropDownList;
			
			var report : ReportItem = tempTarget.selectedItem as ReportItem;
			
			tempTarget.selectedIndex = -1;
			
			dispatchEvent( new ReportsDrawerEvent( ReportsDrawerEvent.POPULATE, report ) );
		}
		
	}
}