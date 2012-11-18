package commands
{
	import model.ApplicationModel;
	import model.beans.Region;
	
	import mx.rpc.events.FaultEvent;
	
	import services.ServiceFactory;
	
	public class GetSalesUnitForecastsByRegionIdCommand extends CommandAdapter
	{
		private var region : Region;
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetSalesUnitForecastsByRegionIdCommand( args : Array )
		{
			this.region = args[0] as Region;
		}
				
		public override function execute() : void
		{
			serviceFactory.getSalesForecastService( this ).getSalesUnitForecastsByRegionId( this.region );
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