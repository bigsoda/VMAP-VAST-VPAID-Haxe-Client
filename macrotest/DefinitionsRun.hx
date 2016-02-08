package ;

import haxe.macro.Expr.TypeDefinition;
import haxe.macro.Context;

class DefinitionsRun {

    public static function main()
    {
        trace('DefinitionsRun.main()');
        run();
    }

    macro public static function run()
    {
        Sys.print('DefinitionsRun.run()\n');
        var process = new sys.io.Process("haxe", "-cp src -main DefinitionData -D read".split(" "));
        Sys.print("exitcode: " + process.exitCode() + " process id: " + process.getPid());
        Sys.print('\n');
        Sys.print('||||||||||||||||||||');Sys.print('\n');
        // read everything from stderr
        var error = process.stderr.readAll().toString();
        Sys.print("stderr:\n" + error);
        Sys.print('||||||||||||||||||||');Sys.print('\n');
        // read everything from stdout
        var stdout = process.stdout.readAll().toString();
        Sys.print("stdout:\n" + stdout);
        Sys.print('||||||||||||||||||||');Sys.print('\n');
        process.close(); // close the process I/O
        return Context.makeExpr(" - done - ", Context.currentPos());
    }

    public function new() {

    }
}
