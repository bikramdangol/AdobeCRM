package commands
{
	import model.ApplicationModel;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	import services.ServiceFactory;
	
	public class GetAllSalesManagersCommand extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetAllSalesManagersCommand()
		{
		}
				
		/**
		 * 
		 * 
		 */
		override public function execute() : void
		{
			serviceFactory.getSalesManagerService( this ).getAllSalesManagers();
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		override public function result( data : Object ) : void
		{
			super.result( data );
			
			appModel.salesManagers = data.result as ArrayCollection;
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		override public function fault( info : Object) : void
		{
			super.fault( info );
			
			trace( ( info as FaultEvent ).message );
		}
	}
}