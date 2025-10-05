include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

swtichOD = 12;
switchNotchX = 1.5;
switchNotchY = 0.8;

boxInteriorX = 42;
boxInteriorY = 38;
boxInteriorZ = 28;

boxInteriorDia = 4;
boxInteriorCZ = 1;

boxExteriorCZ = 2;
boxWallXY = 3;
boxWallZ = 3;
boxExteriorDia = boxInteriorDia + 2*boxWallXY;

boxExteriorX = boxInteriorX + 2*boxWallXY;
boxExteriorY = boxInteriorY + 2*boxWallXY;
boxExteriorZ = boxInteriorZ + boxWallZ;

echo(str("boxExteriorX/2 = ", boxExteriorX/2));
echo(str("boxInteriorX/2 = ", boxInteriorX/2));

module itemModule()
{
	cornerX = (boxExteriorX - boxExteriorDia)/2;
	cornerY = (boxExteriorY - boxExteriorDia)/2;
	difference()
	{
		// Exterior:
		mirror([0,0,1]) hull() doubleX() doubleY() translate([cornerX, cornerY, 0]) simpleChamferedCylinder(d=boxExteriorDia, h=boxExteriorZ, cz=boxExteriorCZ);

		// Interior:
		mirror([0,0,1]) hull() doubleX() doubleY() translate([cornerX, cornerY, -100+(boxExteriorZ-boxWallZ)]) simpleChamferedCylinder(d=boxInteriorDia, h=100, cz=boxInteriorCZ);
	}
}

module clip(d=0)
{
	tc([-200, -400-d, -200], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}
