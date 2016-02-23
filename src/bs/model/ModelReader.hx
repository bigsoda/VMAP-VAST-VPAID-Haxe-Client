package bs.model;

import haxe.Json;
import haxe.macro.Expr.TypeDefinition;
import haxe.macro.Context;
import bs.model.ModelDescriptor;
#if macro
import sys.io.Process;

typedef DupaDef = haxe.macro.MacroType<[bs.model.ModelDescriptor.getFields()]>;
#end


//typedef VastFields = {
//	var dupa:String;
//	var cipa:Int;
//}

class ModelReader
{

	public static function main()
	{
		run();
	}

	macro public static function run()
	{
		var cntxType:haxe.macro.Type = Context.getType('bs.model.ModelReader.VastFields');
		Sys.print(cntxType);

//		readDescription('bs.model.vast.Vast');
//		readDescription('bs.model.vast.ad.Ad');
//		readDescription('bs.model.vast.ad.AdSystem');
//		readDescription('bs.model.vast.ad.Error');
//		readDescription('bs.model.vast.ad.Impresion');
//		readDescription('bs.model.vast.ad.Pricing');
//		readDescription('bs.model.vast.ad.creatives.AdParameters');
//		readDescription('bs.model.vast.ad.creatives.Click.hx');
//		readDescription('bs.model.vast.ad.creatives.Creative');
//		readDescription('bs.model.vast.ad.creatives.CreativeDetails');
//		readDescription('bs.model.vast.ad.creatives.CreativeExtension');
//		readDescription('bs.model.vast.ad.creatives.Resource');
//		readDescription('bs.model.vast.ad.creatives.Tracking');
//		readDescription('bs.model.vast.ad.creatives.companion.Companion');
//		readDescription('bs.model.vast.ad.creatives.linear.Icon');
//		readDescription('bs.model.vast.ad.creatives.linear.IconViewTracking');
//		readDescription('bs.model.vast.ad.creatives.linear.Linear');
//		readDescription('bs.model.vast.ad.creatives.linear.MediaFile');
//		readDescription('bs.model.vast.ad.creatives.nonlinears.NonLinear');
//		readDescription('bs.model.vast.ad.creatives.nonlinears.NonLinearAds');
		return Context.makeExpr(" - done - ", Context.currentPos());
	}

#if macro
	public static function readDescription(path:String):Void
	{
		Sys.print('---------------------');Sys.print('\n');
		Sys.print(["-cp", "src", "-main", path, "-D", "reader"].join(' '));Sys.print('\n');
		Sys.print('readDescription($path)\n');

		var process = new Process("haxe", ["-cp", "src", "-main", path, "-D", "reader"]);
		var error:String = process.stderr.readAll().toString();
		if (error.length > 0)
			Sys.print("stderr:\n" + error);
		else {
			var stdout:String = process.stdout.readAll().toString();
			printDescription(stdout);
		}
		process.close(); // close the process I/O

		Sys.print('---------------------');Sys.print('\n');
	}

	public static function printDescription(stdout:String):Void
	{
		stdout = StringTools.replace(stdout, "\n", "");
//		Sys.print(stdout);
		var data = Json.parse(stdout);
//		Sys.print(data);
		var name = Reflect.field(data ,'name');
		var fields:Array<Dynamic> = cast Reflect.field(data ,'fields');
		Sys.print('$name :');
		Sys.print('\n');
		for (field in fields) {
			var variable = Reflect.field(field ,'variable');
			var variableKind = Reflect.field(variable ,'kind');
			var variableName = Reflect.field(variable ,'name');
			var variableParams:String = Reflect.field(variable ,'params');
			var meta:Array<Dynamic> = cast Reflect.field(field ,'meta');
			var required = isInMeta(meta, 'required');

			if (variableParams != '')
				Sys.print(' - [required:$required] $variableName:$variableKind<$variableParams>');
			else
				Sys.print(' - [required:$required] $variableName:$variableKind');

			Sys.print('\n');
		}
	}

	public static function isInMeta(meta:Array<Dynamic>, name:String):Bool
	{
		for (mt in meta)
			if (Reflect.field(mt,'name') == name)
				return true;
		return false;
	}
#end
	public function new() {

	}
}
