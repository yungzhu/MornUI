package view {
	import game.ui.comps.ViewStackTestUI;
	
	/**视图容器示例*/
	public class ViewStackTest extends ViewStackTestUI {
		
		public function ViewStackTest() {
			tab.selectHandler = viewStack.setIndexHandler;
		}
	}
}