package services.remote
{
	import model.beans.User;

	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	import services.ISalesRepService;

	public class SalesRepServiceRemote implements ISalesRepService
	{
		private var service : AbstractService;
		private var resp : IResponder;

		public function SalesRepServiceRemote( service : AbstractService , resp : IResponder )
		{
			this.service = service;
			this.resp = resp;
		}

		public function getAllSalesReps() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getAllSalesReps" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getSalesRepByUserId( user : User ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getSalesRepByUserId" );
			abstractOp.arguments = [ user ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getTop10SalesRepsByPercentOfQuota() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getTop10SalesRepsByPercentOfQuota" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

	}
}