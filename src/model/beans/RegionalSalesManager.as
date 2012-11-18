package model.beans
{
	import mx.collections.ArrayCollection;

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.RegionalSalesManager" )]
	public class RegionalSalesManager extends User
	{
		private var _salesUnits : ArrayCollection;

		public function get salesUnits() : ArrayCollection
		{
			return _salesUnits;
		}

		public function set salesUnits( value : ArrayCollection ) : void
		{
			if ( !value )
			{
				return;
			}

			_salesUnits = value;
		}

	}
}