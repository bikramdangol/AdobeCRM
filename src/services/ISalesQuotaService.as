package services
{
	import model.beans.User;
	
	import mx.rpc.AsyncToken;

	public interface ISalesQuotaService
	{
		
		/**
		 * 
		 * @param user
		 * @return 
		 * 
		 */
		function getSalesQuotasByUserId ( user : User ) : AsyncToken;
			
			
		/**
		 * 
		 * @return 
		 * 
		 */
		function getAllSalesQuotas() : AsyncToken;
	}
}