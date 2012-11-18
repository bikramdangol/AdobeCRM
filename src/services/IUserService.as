package services
{
	import model.beans.User;

	import mx.rpc.AsyncToken;

	public interface IUserService
	{
		function getUserById( user : User ) : AsyncToken;
	}
}