[] call reapercrew_training_fnc_startTraining;

_structuredTest ="
<font color='#ffc300' size='15'>Mission Briefing</font><br/>

Your mission is to collect troops from the field and bring them back to base. Marked on the map you'll see a task to 'Pickup Troops', make your way over towards the marker and locate a suitable landing spot. When you are closing on the LZ, troops on the ground will deploy a purple smoke so that you can see their current location. Once you touchdown, the infantry fireteam will make their way to your helicopter and embark. You'll then have to drop the fireteam back to HQ before being given further tasking.
<br/><br/>
If you or your helicopter recieve any damage, the mission will fail and you'll have to restart. Best of luck!
";

player createDiaryRecord ["Diary", ["Briefing", _structuredTest]]