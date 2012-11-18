package utils
{

	public class PropertyUtils
	{
		public function PropertyUtils()
		{
		}

		public static function parseObjectChain( objectChain : String , item : Object ) : Object
		{
			if ( !objectChain || !item )
			{
				return null;
			}

			var chain : Array = objectChain.split( "." );
			var chainLen : int = chain.length;
			var chainObj : Object;

			if ( chainLen > 0 )
			{
				for ( var i : int = 0 ; i < chainLen ; i++ )
				{
					if ( i == 0 )
					{
						chainObj = item[ chain[ i ] ];

						if ( !chainObj )
						{
							return null;
						}
					}
					else
					{
						chainObj = chainObj[ chain[ i ] ];

						if ( !chainObj )
						{
							return null;
						}
					}
				}

				return chainObj;
			}
			else
			{
				return objectChain;
			}
		}
	}
}