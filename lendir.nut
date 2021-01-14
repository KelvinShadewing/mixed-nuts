len <- 0;
dir <- 0;
quit <- false;
setDrawColor(0xff0000ff);

while(!quit)
{
	drawLine(160, 120, 160 + lendirX(len, dir), 120 + lendirY(len, dir));
	if(keyPress(k_up)) len += 8;
	if(keyPress(k_down) && len > 0) len -= 8;
	if(keyPress(k_left)) dir += 8;
	if(keyPress(k_right)) dir -= 8;
	if(keyPress(k_space)) print("X: " + lendirX(len, dir).tostring() + "\nY: " + lendirY(len, dir).tostring());
	update();
};