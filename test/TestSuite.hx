import massive.munit.TestSuite;

import vast.Parser1Test;
import vast.Parser2Test;
import vast.Parser3Test;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(vast.Parser1Test);
		add(vast.Parser2Test);
		add(vast.Parser3Test);
	}
}
