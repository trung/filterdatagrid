package fdg.filters.renderer {
import fdg.filters.TextInputHeaderColumn;

import flash.events.Event;

import mx.binding.utils.BindingUtils;
import mx.containers.VBox;
import mx.controls.DataGrid;
import mx.controls.HRule;
import mx.controls.Text;
import mx.controls.TextInput;
import mx.controls.listClasses.BaseListData;
import mx.controls.listClasses.IDropInListItemRenderer;
import mx.events.DataGridEvent;

public class TextInputHeaderRenderer extends VBox implements IDropInListItemRenderer
{

	private var filter:TextInput;
	
	private var header:Text;

	public function TextInputHeaderRenderer() {
		super();				
		super.horizontalScrollPolicy = "off";
		super.verticalScrollPolicy = "off";
		super.setStyle("verticalGap", "1");
		filter = new TextInput();
		filter.addEventListener("change", changeHandler);
		filter.percentWidth = 100;
		filter.setStyle("textAlign", "left");
		addChild(filter);
		var hrule:HRule = new HRule();
		hrule.percentWidth = 100;
		addChild(hrule);
		header = new Text();
		BindingUtils.bindProperty(header, "width", super, "explicitWidth");
		header.setStyle("textAlign", "center");
		header.setStyle("verticalAlign", "middle");
		header.selectable = false;		
		addChild(header);		
	}

	private var _data:TextInputHeaderColumn;
	
	private var _listData:BaseListData;
	
	public function get listData():BaseListData
	{
		return _listData;
	}

	/**
	 *  @private
	 */
	public function set listData(value:BaseListData):void
	{
		_listData = value;
		invalidateProperties();
	}

	override public function get data():Object
	{
		return _data;
	}

	override public function set data(value:Object):void
	{
		_data = value as TextInputHeaderColumn;
		DataGrid(listData.owner).addEventListener(DataGridEvent.HEADER_RELEASE, sortEventHandler);
		BindingUtils.bindProperty(filter, "text", _data, "_filterText");
		// filter.text = _data.filterValue;
		header.text = _data.headerText;
		header.width = super.explicitWidth;
		filter.setStyle("textAlign", "left");
		header.setStyle("textAlign", "center");
		header.setStyle("verticalAlign", "middle");
	}

	private function sortEventHandler(event:DataGridEvent):void
	{
		if (event.itemRenderer == this)
			event.preventDefault();
	}

	private function changeHandler(event:Event):void
	{
		data._filterText = filter.text;
		data.dispatchEvent(event);
	}
}

}