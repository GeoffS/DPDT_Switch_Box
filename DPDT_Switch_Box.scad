include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

switchOD = 12.3;
switchNotchX = 1.5;
switchNotchY = 0.8;

boxInteriorX = 42;
boxInteriorY = 38 + 6;
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

mountingScrewHoleDia = 3.8;
mountingScrewHeadRecesssDia = 10.5;
mountingScrewHeadRecesssExtDia = mountingScrewHeadRecesssDia + 5;

mountingScrewHoleCtrX = boxInteriorX + mountingScrewHeadRecesssExtDia/2 + 4;

module itemModule()
{
	difference() 
	{
		cornerX = (boxExteriorX - boxExteriorDia)/2;
		cornerY = (boxExteriorY - boxExteriorDia)/2;

		// Basic box:
		translate([0,0,boxInteriorZ]) mirror([0,0,1]) difference()
		{
			// Exterior:
			hull() 
			{
				doubleX() doubleY() translate([cornerX, cornerY, 0]) simpleChamferedCylinder(d=boxExteriorDia, h=boxExteriorZ, cz=boxExteriorCZ);
				doubleX() translate([mountingScrewHoleCtrX/2, 0, 0]) simpleChamferedCylinder(d=mountingScrewHeadRecesssExtDia, h=boxExteriorZ, cz=boxExteriorCZ);
			}

			// Interior:
			hull() doubleX() doubleY() translate([cornerX, cornerY, -100+(boxExteriorZ-boxWallZ)]) simpleChamferedCylinder(d=boxInteriorDia, h=100, cz=boxInteriorCZ);

			doubleX() translate([mountingScrewHoleCtrX/2,0,0])
			{
				tcy([0,0,-100], d=mountingScrewHoleDia, h=200);
				tcy([0,0,4], d=mountingScrewHeadRecesssDia, h=200);
			}
		}

		// Switch hole:
		translate([0,0,boxInteriorZ/2]) difference()
		{
			// Hole:
			rotate([-90,0,0]) tcy([0,0,0], d=switchOD, h=100);

			// // Notch:
			// tcu([switchOD/2-switchNotchY, 10, -switchNotchX/2], [10, 20, switchNotchX]);
		}
	}
}

module clip(d=0)
{
	// tc([-200, -400-d, -200], 400);
	// tcu([-200, -200, boxInteriorZ/2-d], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}
