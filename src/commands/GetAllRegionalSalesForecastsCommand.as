package commands
{
	import model.ApplicationModel;

	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;

	import services.ServiceFactory;

	public class GetAllRegionalSalesForecastsCommand extends CommandAdapter
	{
		private var path : String;
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();

		public function GetAllRegionalSalesForecastsCommand()
		{
			this.path = path;
		}

		public override function execute() : void
		{
			serviceFactory.getSalesForecastService( this ).getAllRegionalSalesForecasts();
		}

		public override function result( data : Object ) : void
		{
			super.result( data );
		}

		override public function fault( info : Object ) : void
		{
			super.fault( info );
			trace(( info as FaultEvent ).message );
		}
	}
}