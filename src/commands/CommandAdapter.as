package commands
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.IMXMLObject;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	use namespace mx_internal;
	
	public class CommandAdapter extends EventDispatcher implements ICommand, IMXMLObject
	{

		protected var asyncToken : AsyncToken;
		protected var logger : ILogger;
		protected var responders : Array;

		protected var document : Object;
		public var id : String;
		
		public function CommandAdapter()
		{
			logger = Log.getLogger( getLoggerFriendlyClassName( this ) );
			responders = new Array();
			asyncToken = new AsyncToken( null );
		}

		/**
		 * 
		 * @param document
		 * @param id
		 * 
		 * 						Add suport for IMXMLObject so that I can be 
		 * 						used in MXML, should you like.
		 */
		public function initialized( document : Object, id : String ) : void
		{
			this.id = id;
			this.document = document;
		}

		public function execute() : void
		{
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function result( data : Object ) : void
		{
			var event:ResultEvent = data as ResultEvent;

			logger.info( "Result Received" );
			dispatchEvent( event );

			asyncToken.applyResult( event ); 
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function fault( info : Object ) : void
		{
			var event : FaultEvent = info as FaultEvent;
			
			logger.warn( "Fault Received {0}", event.fault.message );
			dispatchEvent( event );
			asyncToken.applyFault( event );
		}
		
		/**
		 * 
		 * @param result
		 * @param fault
		 * @return 
		 * 
		 */
		public function addCallBack( result : Function, fault : Function = null ) : CommandAdapter
		{
			var responder : Responder = new Responder( result, ( fault != null ) ? fault : unhandledFault );
			
			asyncToken.addResponder( responder );
			
			return this;
		}

		/**
		 * 
		 * @param responder
		 * @return 
		 * 
		 */
		public function addResponder( responder : IResponder ) : CommandAdapter
		{
			asyncToken.addResponder( responder );
			
			return this;
		}
		
		/**
		 * 
		 * @param info	
		 * 
		 * 				Generic fault when you don't want to provide a 
		 * 				fault to the addCallBack method.
		 */
		private function unhandledFault( info : Object ) : void
		{
		}
		
		/**
		 * 
		 * @param instance
		 * @return 
		 * 
		 */
		public function getLoggerFriendlyClassName( instance : Object ) : String
		{
			var periodReplace : RegExp = /\./g;
			var colonReplace : RegExp = /::/g;

			var fullname : String = getQualifiedClassName( instance );
			fullname = fullname.replace( periodReplace, "_" );
			fullname = fullname.replace( colonReplace, "_" );

			return fullname;
		}
	}
}