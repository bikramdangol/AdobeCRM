package services.remote
{
	import model.beans.User;

	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	import services.IUserService;

	public class UserServiceRemote implements IUserService
	{
		private var service : AbstractService;
		private var resp : IResponder;

		public function UserServiceRemote( service : AbstractService , resp : IResponder )
		{
			this.service = service;
			this.resp = resp;
		}

		public function getUserById( user : User ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getUserById" );
			abstractOp.arguments = [ user ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}
	}
}