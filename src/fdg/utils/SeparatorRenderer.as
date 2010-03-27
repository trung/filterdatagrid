package fdg.utils
{
import mx.controls.listClasses.ListItemRenderer;

public class SeparatorRenderer extends ListItemRenderer
{

	public function SeparatorRenderer()
	{
		super();
	}

	override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	{
		graphics.clear();
		super.updateDisplayList(unscaledWidth, unscaledHeight);
		if (data && data.hasOwnProperty("separator"))
		{
			label.visible = false;

			graphics.lineStyle(1, getStyle("color"));
			graphics.moveTo(0, unscaledHeight / 2);
			graphics.lineTo(unscaledWidth, unscaledHeight / 2);
		}
		else
			label.visible = true;
	}

}

}