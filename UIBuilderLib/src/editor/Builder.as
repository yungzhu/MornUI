package editor{
	public class Builder{
		/**对组件进行重置*/
		public static function init():void{
			App.stage = Sys.stage;
			App.asset = new BuilderResManager();
		}
	}
}