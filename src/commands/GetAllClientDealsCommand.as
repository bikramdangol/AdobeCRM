package commands
{
	import model.ApplicationModel;
	
	import services.ServiceFactory;
	
	public class GetAllClientDealsCommand extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetAllClientDealsCommand()
		{
		}
				
		public override function execute() : void
		{
			serviceFactory.getClientDealService( this ).getAllClientDeals();
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
		}
		
	}
}