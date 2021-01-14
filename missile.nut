donut("std/actors.nut");

::Missile <- class extends Actor
{
	hspeed = 0.0;
	vspeed = 0.0;
	smoketimer = 5;

	function run()
	{
		if(smoketimer > 0) smoketimer--;
		else
		{
			smoketimer = 5;
			newActor(Smoke, x, y);
		};

		//Track mouse
		local dir = pointAngle(x, y, mouseX(), mouseY());
		hspeed += lendirX(0.5, dir);
		vspeed += lendirY(0.5, dir);

		x += hspeed;
		y += vspeed;

		setDrawColor(0xffff);
		drawCircle(x, y, 4, true);

		if(distance2(x, y, mouseX(), mouseY()) <= 8) deleteActor(id);
	};
};

::Smoke <- class extends Actor
{
	r = 6.0;

	function run()
	{
		r -= 0.5;
		if(r <= 0) deleteActor(id);
	};
};

::quit <- false;

while(!quit)
{
	setDrawColor(0xff00ff);
	drawCircle(mouseX(), mouseY(), 4, true);
	if(keyPress(k_space)) newActor(Missile, 160, 120);
	if(keyPress(k_escape)) quit = true;
	runActors();
	update();
}