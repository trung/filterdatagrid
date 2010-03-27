package fdg.utils
{
import flash.events.MouseEvent;
import mx.controls.List;
import mx.controls.listClasses.IListItemRenderer;
import mx.core.ClassFactory;

public class SeparatorList extends List
{

	public function SeparatorList()
	{
		super();
		itemRenderer = new ClassFactory(SeparatorRenderer);
	}

    /**
     *  @private
     *  Determines if the itemrenderer is a separator. If so, return null to prevent separators
     *  from highlighting and emitting menu-level events. 
     */
    override protected function mouseEventToItemRenderer(event:MouseEvent):IListItemRenderer
    {
        var row:IListItemRenderer = super.mouseEventToItemRenderer(event);
        
        if (row && row.data && row.data.hasOwnProperty("separator"))
            return null;
        else return row;
    }

}

}