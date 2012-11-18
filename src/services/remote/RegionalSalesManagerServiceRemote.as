package services.remote
{
	import model.beans.RegionalSalesManager;

	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	import services.IRegionalSalesManagerService;

	public class RegionalSalesManagerServiceRemote implements IRegionalSalesManagerService
	{
		private var service : AbstractService;
		private var resp : IResponder;

		public function RegionalSalesManagerServiceRemote( service : AbstractService , resp : IResponder )
		{
			this.service = service;
			this.resp = resp;
		}

		public function getRegionalSalesManagerById( regionalSalesManager : RegionalSalesManager ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getRegionalSalesManagerById" );
			abstractOp.arguments = [ regionalSalesManager ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getSalesUnitsByRegionalSalesManagerId( regionalSalesManager : RegionalSalesManager ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getSalesUnitsByRegionalSalesManagerId" );
			abstractOp.arguments = [ regionalSalesManager ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getAllRegionalSalesManagers() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getAllRegionalSalesManagers" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}
	}
}