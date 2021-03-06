package game.util
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.entities.MapLayer;
	import game.entities.Player;
	import game.entities.Tile;

	public class Functions
	{
		public function Functions()
		{
			
		}
			
		public static function randomNumber(low:Number=NaN, high:Number=NaN):Number
		{
			var low:Number = low;
			var high:Number = high;
			
			if(isNaN(low))
			{
				throw new Error("low must be defined");
			}
			
			if(isNaN(high))
			{
				throw new Error("high must be defined");
			}
			
			return Math.round(Math.random() * (high - low)) + low;
		}
		
		public static function duplicateDisplayObject(source:DisplayObject, autoAdd:Boolean = false):DisplayObject
		{
			// create duplicate
			var sourceClass:Class = Object(source).constructor;
			var duplicate:DisplayObject = new sourceClass();
			
			// duplicate properties
			duplicate.transform = source.transform;
			duplicate.filters = source.filters;
			duplicate.cacheAsBitmap = source.cacheAsBitmap;
			duplicate.opaqueBackground = source.opaqueBackground;
			if (source.scale9Grid) 
			{
				var rect:Rectangle = source.scale9Grid;
				// WAS Flash 9 bug where returned scale9Grid is 20x larger than assigned
				// rect.x /= 20, rect.y /= 20, rect.width /= 20, rect.height /= 20;
				duplicate.scale9Grid = rect;
			}
			
			// add to source parent's display list
			// if autoAdd was provided as true
			if (autoAdd && source.parent) 
			{
				source.parent.addChild(duplicate);
			}
			return duplicate;
		}
		
		public static function removeChild(source:MovieClip, object:MovieClip):Boolean			
		{			
			if (source.contain(object) == true)
			{
				source.removeChild(object);
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public static function getFilenameFromUrl(url:String):String
		{
			var letters:Array= [];
			var charPosition:int= url.length;
			var currentCharacter:String;
			
			while(currentCharacter != '/' && currentCharacter != '\\') {
				currentCharacter = url.charAt(charPosition);
				letters.push( currentCharacter);
				charPosition--;
			}
			letters = letters.reverse();
			letters.shift();
			var filename:String = letters.join('');
			return filename;
		}
		
		public static function removeExtensionFromFilename(filename:String):String
		{
			return filename.slice(0, filename.lastIndexOf('.'));
		}
		
		public static function getPlayerById(id:String):Player
		{
			for (var x:int = 0; x < GameObjects.PLAYERS.length; x++)
			{
				if ( (GameObjects.PLAYERS[x] as Player).playerId == id )
				{
					return (GameObjects.PLAYERS[x] as Player);
				}
			}
			
			return null;
		}
		
		public static function collideWithLayer(player:Player, posX:int, posY:int):Boolean
		{
			for each(var tile:Tile in GameObjects.TILES)
			{
				if ( player.collideWith(tile, posX, posY) ) 
				{
					return true;
				}
			}
		
			return false;			
		}

	}
}