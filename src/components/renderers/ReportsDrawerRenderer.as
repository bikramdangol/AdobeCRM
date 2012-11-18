package components.renderers
{
	import spark.components.supportClasses.ItemRenderer;

	public class ReportsDrawerRenderer extends ItemRenderer 
	{
		/** OVERRIDDEN METHODS **/
		
		override protected function commitProperties() : void
		{
			super.commitProperties();

			this.styleName = this.className;
		}
	}
}