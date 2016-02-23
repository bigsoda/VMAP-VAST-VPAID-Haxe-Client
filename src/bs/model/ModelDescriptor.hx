package bs.model;

import haxe.Json;
import haxe.macro.Type.ClassType;
import haxe.macro.Expr.Field;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.ComplexType.TPath;

class ModelDescriptor
{

	macro public static function getFields():haxe.macro.Type
	{
		return declare('DupaDef', [mkField('dupaValue', mkType('String'))]);
	}

	#if macro
	public static function declare(name:String, fields:Array<Field>, ?superType:TypePath):Void
	{
		Context.defineType({
			pos: Context.currentPos(), //the position the type is associated with - should probably point to your XML file
			params: [], //we have no type parameters in this example
			pack: [], //no package
			name: name,
			fields: [], //we use a different mechanism to add fields, so we pass none here
			isExtern: false, //not extern
			meta: [], //no metadata
			kind: TDAlias(
			 	//here we "alias" (which is what a typedef does) to a fitting ComplexType
				if (superType == null)
					TAnonymous(fields)
				else
					TExtend(superType, fields)
			)
		});

	}
	public static function mkPath(name:String):TypePath {
		var parts = name.split('.');
		return {
			sub: null,
			params: [],
			name: parts.pop(),
			pack: parts
		}
	}
	public static function mkType(s:String):ComplexType
		return TPath(mkPath(s));

	public static function mkField(name:String, type:ComplexType):Field
		return {
			pos: Context.currentPos(),
			name: name,
			meta: [],
			kind: FVar(type),
			doc: null,
			access: []
		}

#end





    macro public static inline function build():Array<Field>
    {
        var c:ClassType = cast Context.getLocalClass();
        var bf:Array<Field> = Context.getBuildFields();

        var desc = {name:c+'', fields:[] };
        for (f in bf) {
            var kind = parseKind(f);
            var meta = parseMeta(f);
            if (kind != null && meta != null)
                desc.fields.push({variable:kind, meta:meta});

        }
        Sys.print("\n");
        Sys.print(Json.stringify(desc));
        return null;
    }
#if macro
    public static function parseKind(f:Field):Dynamic
    {
        var t:Null<ComplexType>;
        var e:Expr;

        switch (f.kind) {
            case FVar(t, e):
                var p:TypePath;
                switch (t) {
                    case TPath(p):
                        return {name: f.name, kind: p.name, params:parseParams(f.kind) };
                    case _:
//do nothing
                }
            case _:
//do nothing
        }

        return null;
    }
//
    public static function parseParams(ft:FieldType):String
    {
        var t:Null<ComplexType>;
        var e:Expr;
        switch (ft) {
            case FVar(t, e):
                var p:TypePath;
                switch (t) {
                    case TPath(p):
                        var ct:ComplexType;
                        for (param in p.params){
                            switch(param){
                                case TPType(ct):
                                    var tp:TypePath;
                                    switch(ct){
                                        case TPath(tp):
                                            return tp.name;//tp.pack.join('.')+'.'+tp.name;
                                        case _:
//do nothing
                                    }
                                case _:
//do nothing
                            }
                        }
                    case _:
//do nothing
                }
            case _:
//do nothing
        }
        return "";
    }

    public static function parseMeta(f:Field):Dynamic
    {
        var t:Null<ComplexType>;
        var e:Expr;
        var v:Dynamic;
        var fields:Array<Dynamic> = [];

        for (m in f.meta) {
            var fieldInfo:Dynamic = {};
            fieldInfo.name = m.name;
            fieldInfo.values = [];
            for (p in m.params) {
                switch (p.expr) {
                    case EConst(t):
                        switch t {
                            case CString(v):
                                fieldInfo.values.push(v);
                            case CFloat(v):
                                fieldInfo.values.push(v);
                            case CInt(v):
                                fieldInfo.values.push(v);
                            case CIdent(v):
                                fieldInfo.values.push(v);
                            case _:
//do nothing
                        }
                    case _:
//do nothing
                }
            }
            fields.push(fieldInfo);
        }

        return fields;
    }

//    public static function parseMacroVariable(cls:String, variable:String):String
//    {
//        var macroPlugin:Dynamic = null;
//        switch (Context.getType(cls)) {
//            case TInst(cl,_) :
//                macroPlugin = cl.get().meta.extract(variable);
//                Sys.print(cl.get().meta);
//                Sys.print('\n');
//            case _ :
//                macroPlugin = null;
//        }
//        if (macroPlugin != null) {
//            var macroPluginParams:Array<Expr> = cast Reflect.field(macroPlugin[0],'params');
//            if (macroPluginParams != null) {
//                switch (macroPluginParams[0].expr) {
//                    case EConst(t):
//                        switch t {
//                            case CString(v) : return v;
//                            case _://do nothing
//                        }
//                    case _://do nothing
//                }
//            }
//        }
//        return null;
//    }
#end
}

