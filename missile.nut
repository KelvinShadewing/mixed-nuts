donut("std/actors.nut");
setResolution(640, 360);

::Missile <- class extends Actor
{
	hspeed = 0.0;
	vspeed = 0.0;
	smoketimer = 5;

	constructor(_x, _y)
	{
		x = _x;
		y = _y;

		local dir = pointAngle(x, y, mouseX(), mouseY());
		dir -= 10;
		dir += randInt(20);

		hspeed = -lendirX(6, dir);
		vspeed = -lendirY(6, dir);
	}

	function run()
	{
		if(smoketimer > 0) smoketimer--;
		else
		{
			smoketimer = 2;
			newActor(Smoke, x, y);
		};

		//Track mouse
		local dir = pointAngle(x, y, mouseX(), mouseY());
		hspeed += lendirX(0.5, dir);
		vspeed += lendirY(0.5, dir);

		//Cap speed
		if(distance2(0, 0, hspeed, vspeed) > 8)
		{
			dir = pointAngle(0, 0, hspeed, vspeed);
			hspeed = lendirX(8, dir);
			vspeed = lendirY(8, dir);
		};

		foreach(i in actor)
		{
			if(typeof i == "Missile")
			{
				if(i.id != id)
				{
					if(distance2(x, y, i.x, i.y) < 16)
					{
						dir = pointAngle(x, y, i.x, i.y);
						hspeed -= lendirX(1, dir);
						vspeed -= lendirY(1, dir);
					};
				};
			};
		};

		x += hspeed;
		y += vspeed;

		setDrawColor(0xffff);
		drawCircle(x, y, 4, true);

		if(distance2(x, y, mouseX(), mouseY()) <= 8) deleteActor(id);
	};

	function _typeof() {return "Missile";};
};

::Smoke <- class extends Actor
{
	r = 6.0;

	function run()
	{
		setDrawColor(0xffffff80);
		drawCircle(x, y, r, true);
		r -= 0.5;
		if(r <= 0) deleteActor(id);
	};
};

::quit <- false;

while(!quit)
{
	setDrawColor(0xff0000ff);
	drawCircle(320, 180, 4, true);
	setDrawColor(0xff00ff);
	drawCircle(mouseX(), mouseY(), 4, true);
	if(keyDown(k_space)) newActor(Missile, 320, 180);
	if(keyPress(k_escape)) quit = true;
	runActors();
	update();
}