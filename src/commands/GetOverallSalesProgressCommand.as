package commands
{
	import model.ApplicationModel;
	import model.beans.SalesQuota;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.ServiceFactory;

	[ResourceBundle("crm")]

	public class GetOverallSalesProgressCommand extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		private var clientDealsByCloseWeek : ArrayCollection;
		private var salesQuotas : ArrayCollection;
		
		public function GetOverallSalesProgressCommand()
		{
			super();
		}
				
		public override function execute() : void
		{
			// This is done so as to use the result handler to call a second service,
			// thereby retrieving the result of both calls in one command
			
			new GetAllClientDealsByCloseDateCommand().addCallBack( getAllClientDealsByCloseDate_resultHandler, getAllClientDealsByCloseDate_faultHandler ).execute();
		}
		
		private function getAllClientDealsByCloseDate_resultHandler( data : Object ) : void
		{
			if ( !data )
			{
				return;
			}
			
			var event : ResultEvent = data as ResultEvent;
			
			clientDealsByCloseWeek = event.result as ArrayCollection;
			
			serviceFactory.getSalesQuotaService( this ).getAllSalesQuotas();
		}
		
		private function getAllClientDealsByCloseDate_faultHandler( event : FaultEvent ) : void
		{
			super.logger.error( event.fault.message );
		}
		
		override public function result( data : Object ) : void
		{
			if ( !data )
			{
				return;
			}
			
			var event : ResultEvent = data as ResultEvent;
			
			salesQuotas = event.result as ArrayCollection;

			var sumOfQuotas : Number = 0;
			
			for each ( var tempQuota : SalesQuota in salesQuotas )
			{
				sumOfQuotas += tempQuota.quotaValue; 
			}
			
			var accumulatedRevenue : Number = 0;
			
			for each ( var closingWeek : Object in clientDealsByCloseWeek )
			{
				accumulatedRevenue += closingWeek.totalRevenue;
				
				closingWeek.accumulatedRevenue = accumulatedRevenue;
				
				closingWeek.sumOfQuotas = sumOfQuotas;
			}
			
			var resultEvent : ResultEvent = new ResultEvent( data.type, data.bubbles, data.cancelable, clientDealsByCloseWeek );
			
			super.result( resultEvent );
		}
	}
}