package commands
{
	import mx.rpc.IResponder;

	public interface ICommand extends IResponder
	{
		function execute() : void;
	}
}