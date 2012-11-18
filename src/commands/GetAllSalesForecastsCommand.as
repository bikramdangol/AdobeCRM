package commands
{
	import model.ApplicationModel;
	import model.beans.SalesForecast;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	import services.ServiceFactory;
	
	public class GetAllSalesForecastsCommand extends CommandAdapter
	{
		private var path : String;
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetAllSalesForecastsCommand()
		{
			this.path = path;
		}
				
		public override function execute() : void
		{
			serviceFactory.getSalesForecastService( this ).getAllSalesForecasts();
		}
		
		public override function result( data : Object ) : void
		{
			super.result( data );
			appModel.salesForecasts = data.result as ArrayCollection;
			
			for each ( var item : Object in appModel.salesForecasts )
			{
				item = item as SalesForecast;
			}
		}
		
		override public function fault( info : Object) : void
		{
			super.fault( info );
			trace( ( info as FaultEvent ).message );
		}
	}
}