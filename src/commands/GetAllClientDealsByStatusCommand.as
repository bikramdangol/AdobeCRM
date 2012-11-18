package commands
{
	import model.ApplicationModel;
	
	import services.ServiceFactory;
	
	public class GetAllClientDealsByStatusCommand extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetAllClientDealsByStatusCommand()
		{
		}
				
		public override function execute() : void
		{
			serviceFactory.getClientDealService( this ).getAllClientDealsByStatus();
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
		}
		
	}
}