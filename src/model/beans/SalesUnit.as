package model.beans
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.adobe.community.adobecrm.domain.SalesUnit")]
	public class SalesUnit
	{
		private var _salesManagers : ArrayCollection;
		
		private var _region : Region;
		
		private var _regionalSalesManager : RegionalSalesManager;
		
		/**
		 * @return
		 */
		public function get salesManagers () : ArrayCollection
		{
			return _salesManagers;
		}
	
		/**
		 * @param salesReps
		 */
		public function set salesManagers ( value : ArrayCollection ) : void
		{
			if ( !value )
			{
				return;
			}
			
			_salesManagers = value;
		}
	
		/**
	     * @return the region
	     */
	    public function get Region () : Region
	    {
		    return _region;
	    }
	    
		/**
	     * @param region the region to set
	     */
	    public function set Region ( value : Region ) : void
	    {
		    _region = value;
	    }
	
		/**
	     * @return the regionalSalesManager
	     */
	    public function get regionalSalesManager () : RegionalSalesManager
	    {
		    return _regionalSalesManager;
	    }
	    
		/**
	     * @param regionalSalesManager the regionalSalesManager to set
	     */
	    public function set regionalSalesManager ( value : RegionalSalesManager ) : void
	    {
	    	if ( !value )
	    	{
	    		return;
	    	}
	    	
		    _regionalSalesManager = value;
	    }
	
	}
}