package services
{
	import mx.rpc.AsyncToken;

	public interface IXMLHTTPLoader
	{
		function getData() : AsyncToken;
	}
}