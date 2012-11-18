package commands
{
	import model.ApplicationModel;
	import model.beans.ReportItem;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	
	import services.ServiceFactory;
	
	public class GetNavItems extends CommandAdapter
	{
		
		public override function execute() : void
		{
			var token:AsyncToken = ServiceFactory.getInstance().getNavService( this ).getData();
		}
		
		public override function result( data : Object ) : void
		{
			var appModel : ApplicationModel = ApplicationModel.getInstance();
			var navItems : ArrayCollection = new ArrayCollection();
			
			for each( var item : XML in data.result.report )
			{
				var reportItem : ReportItem = appModel.getReportDataById( item.@id );
				navItems.addItem( reportItem );
			}
			
			appModel.navItems = navItems;
		}
	}
}