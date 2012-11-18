package commands
{
	import model.ApplicationModel;
	import model.beans.SalesManager;
	
	import mx.rpc.events.FaultEvent;
	
	import services.ServiceFactory;
	
	public class GetSalesRepSalesForecastsBySalesManagerIdCommand extends CommandAdapter
	{
		private var salesManager : SalesManager;
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetSalesRepSalesForecastsBySalesManagerIdCommand( args : Array )
		{
			this.salesManager = args[0] as SalesManager;
		}
				
		public override function execute() : void
		{
			serviceFactory.getSalesForecastService( this ).getSalesRepSalesForecastsBySalesManagerId( this.salesManager );
		}
		
		public override function result( data : Object ) : void
		{
			super.result( data );
		}
		
		override public function fault( info : Object) : void
		{
			super.fault( info );
			trace( ( info as FaultEvent ).message );
		}
	}
}