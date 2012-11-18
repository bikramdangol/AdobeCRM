package services.remote
{
	import model.beans.User;

	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	import services.ISalesManagerService;

	public class SalesManagerServiceRemote implements ISalesManagerService
	{
		private var service : AbstractService;
		private var resp : IResponder;

		public function SalesManagerServiceRemote( service : AbstractService , resp : IResponder )
		{
			this.service = service;
			this.resp = resp;
		}

		public function getAllSalesManagers() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getAllSalesManagers" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getSalesManagerByUserId( user : User ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getSalesManagerByUserId" );
			abstractOp.arguments = [ user ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getSalesRepsBySalesManagerUserId( user : User ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getSalesManagerByUserId" );
			abstractOp.arguments = [ user ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

	}
}