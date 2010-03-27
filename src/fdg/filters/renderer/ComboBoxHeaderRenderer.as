package fdg.filters.renderer
{
import fdg.filters.ComboBoxHeaderColumn;
import fdg.utils.SeparatorList;

import flash.events.Event;

import mx.controls.ComboBox;
import mx.controls.DataGrid;
import mx.core.ClassFactory;
import mx.events.DataGridEvent;

public class ComboBoxHeaderRenderer extends ComboBox
{

	public function ComboBoxHeaderRenderer()
	{
		super();
		addEventListener("change", changeHandler);
		dropdownFactory = new ClassFactory(SeparatorList);
	}

	private var _data:ComboBoxHeaderColumn;

	override public function get data():Object
	{
		return _data;
	}

	override public function set data(value:Object):void
	{
		_data = value as ComboBoxHeaderColumn;
		DataGrid(listData.owner).addEventListener(DataGridEvent.HEADER_RELEASE, sortEventHandler);
		dataProvider = _data.comboBoxDataProvider;
		selectedIndex = _data.selectedIndex;
	}

	private function sortEventHandler(event:DataGridEvent):void
	{
		if (event.itemRenderer == this)
			event.preventDefault();
	}

	private function changeHandler(event:Event):void
	{
		data.selectedIndex = selectedIndex;
		data.selectedItem = selectedItem;
		data.dispatchEvent(event);
	}

}

}