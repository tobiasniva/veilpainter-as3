package view.layout
{
	import view.Gui;

	public interface IGuiLayout
	{
		function apply(gui:Gui, m:LayoutMetrics):void;
	}
}
