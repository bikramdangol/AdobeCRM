package commands
{
	import model.ApplicationModel;
	import model.beans.Region;
	
	import services.ServiceFactory;
	
	public class GetTop10SalesRepForecastsByPercentOfQuotaCommand extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetTop10SalesRepForecastsByPercentOfQuotaCommand()
		{
			super();
		}
				
		public override function execute() : void
		{
			serviceFactory.getSalesForecastService( this ).getTop10SalesRepForecastsByPercentOfQuota();
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
		}
	}
}