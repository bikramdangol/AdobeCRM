package services.remote
{
	import model.beans.Region;
	import model.beans.SalesManager;
	import model.beans.User;

	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	import services.ISalesForecastService;

	public class SalesForecastServiceRemote implements ISalesForecastService
	{
		private var service : AbstractService;
		private var resp : IResponder;

		public function SalesForecastServiceRemote( service : AbstractService , resp : IResponder )
		{
			this.service = service;
			this.resp = resp;
		}

		public function getAllSalesForecasts() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getAllSalesForecasts" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getAllRegionalSalesForecasts() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getAllRegionalSalesForecasts" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getSalesForecastsByUserId( user : User ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getSalesForecastsByUserId" );
			abstractOp.arguments = [ user ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getRegionalSalesForecastsByRegionId( region : Region ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getRegionalSalesForecastsByRegionId" );
			abstractOp.arguments = [ region ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getSalesUnitForecastsByRegionId( region : Region ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getSalesUnitForecastsByRegionId" );
			abstractOp.arguments = [ region ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getSalesRepSalesForecastsBySalesManagerId( salesManager : SalesManager ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getSalesRepSalesForecastsBySalesManagerId" );
			abstractOp.arguments = [ salesManager ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getTop10SalesRepForecastsByPercentOfQuota() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getTop10SalesRepForecastsByPercentOfQuota" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

	}
}