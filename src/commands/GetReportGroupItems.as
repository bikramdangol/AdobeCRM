package commands
{
	import model.ApplicationModel;
	import model.beans.ReportGroup;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	
	import services.ServiceFactory;

	public class GetReportGroupItems extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		
		override public function execute():void
		{
			var token : AsyncToken = serviceFactory.getReportGroupsService( this ).getData();
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
			
			var appModel : ApplicationModel = ApplicationModel.getInstance();
			var temp : XMLList = data.result.reportGroups;
			var reportGroups : ArrayCollection = new ArrayCollection();
			var isRearrangeable : String;
			var addRemoveEnabled : String;
			
			for each( var item : XML in data.result.reportGroup )
			{
				var reportGroup : ReportGroup = new ReportGroup();
					
					reportGroup.reportGroupId = item.@id;
					
					isRearrangeable = item.@rearrangeable;
					addRemoveEnabled = item.@addRemoveEnabled;
					
					reportGroup.rearrangeable = isRearrangeable != "" ? true : false;
					reportGroup.addRemoveEnabled = addRemoveEnabled != "" ? true : false;
					
					reportGroup.reportIds = getReportIds( reportGroup, item.report );
					
					reportGroup.label = item.@label;
					
				reportGroups.addItem( reportGroup );
			}
			
			appModel.reportGroups = reportGroups;
			
		}
		
		protected function getReportIds( reportGroup : ReportGroup, reportsList : XMLList ) : Array
		{
			var reportIds : Array = new Array();
			
			for each ( var report : XML in reportsList )
			{
				var tempID : int =  report.@id;
				reportIds.push( tempID );
			}
			
			return reportIds;
		}
		
		public function GetReportGroupItems()
		{
			
		}	
		
	}
}