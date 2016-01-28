import massive.munit.TestSuite;

import vast.Vast1Test;
import vast.Vast2Test;
import vast.Vast3Test;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(vast.Vast1Test);
		add(vast.Vast2Test);
		add(vast.Vast3Test);
	}
}
