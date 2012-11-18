package commands
{
	import model.ApplicationModel;
	import model.beans.StatusType;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.rpc.events.ResultEvent;
	
	import services.ServiceFactory;

	public class GetTop10ClientDealsByStatusTypeID extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		private var statusType : StatusType;
		
		public function GetTop10ClientDealsByStatusTypeID( args : Array )
		{
			this.statusType = args[0] as StatusType;
		}
		
		public override function execute() : void
		{
			if ( !this.statusType )
				throw new Error( "You must supply a StatusType to the getClientDealsByStatus' constructor." );
			
			serviceFactory.getClientDealService( this ).getClientDealsByStatusTypeId( statusType );
		}
		
		override public function result( data : Object ) : void
		{
			// Do the processing for weeks
			
			var tempObject : ArrayCollection = filterDataForTop10( data );
			
			var resultEvent : ResultEvent = new ResultEvent( data.type, data.bubbles, data.cancelable, tempObject as Object );
			
			super.result( resultEvent );
		}
		
		protected function filterDataForTop10 ( data : Object ) : ArrayCollection
		{
			if ( !data || ! data.result )
			{
				return null;
			}
			
			var result : ArrayCollection = data.result as ArrayCollection;
			
			// 	Create sort and sort the arrayCollection
			//	based on estimatedRevenue
			
			var sortField : SortField = new SortField( "estimatedRevenue", true, true, true );
			
			var dealSortFields : Array = new Array();
			dealSortFields.push( sortField );
			
			var dealSort : Sort = new Sort();
			dealSort.fields = dealSortFields;
			
			result.sort = dealSort;
			result.refresh();
			
			// Take the top 10 ( if they exist) deals
			
			var filteredData : ArrayCollection = new ArrayCollection();
			var i : int = 0;
			
			while ( (i < 10) && i < result.length )
			{
				filteredData.addItem( result[i]);
				
				i++;
			}
			
			return filteredData;
		}
	
	}
}