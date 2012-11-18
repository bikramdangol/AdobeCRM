package model.beans
{
	import mx.collections.ArrayCollection;

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.SalesManager" )]
	public class SalesManager extends User
	{
		private var _salesReps : ArrayCollection;

		public function set salesReps( value : ArrayCollection ) : void
		{
			_salesReps = value;
		}

		public function get salesReps() : ArrayCollection
		{
			return _salesReps;
		}
	}
}