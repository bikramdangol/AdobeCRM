package commands
{
	import model.ApplicationModel;
	
	import services.ServiceFactory;
	
	public class GetTop10ClientDealsCommand extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetTop10ClientDealsCommand()
		{
		}
				
		public override function execute() : void
		{
			serviceFactory.getClientDealService( this ).getTop10ClientDeals();
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
			
		}
		
	}
}