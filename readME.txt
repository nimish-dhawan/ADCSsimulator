%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CUonOrbit ADCS Simulator v2.0 
========================================================
Copyright
Nimish Dhawan 2025
========================================================

RUN ON MATLAB 2024b

**Please ensure you do the following in the correct order:**


1. Make a copy of this folder and call it "CUonOrbit_ADCS_app_FirstnameLastname" and paste it in your MATLAB environment.
2. Run "adcsInitializer.m" to set initial conditions and run the GUI.
3. Once the GUI loads, configure the simulation parameters under the "Setup" panel. 
4. The "Setup" panel allows you to:
	- Define the pointing mode
	- Toggle torque free environment 
	- Tune controller
	- Change initial conditions
	- Change orbit elements
	- Set simulation runtime
	- It is not recommended to not change S/C bus parameters

5. Press "Load Simulink Model" to load in the model. It should open the Simulink file as a new window.
6. Once the model is up, press "Run Simulation" to run the simulation. 
7. Animation tab lets you view the results and see the motion of the spacecraft.
9. The vertical slider allows you to speed up or down the playback. Horizontal scrubber allows you to go back and forth the animation.
10. Output tab will allow you to plot MATLAB figures for the simulation data and generate a '.a' file for STK.

Lastly please do not copy paste the code you see here for any projects outside the club (especially for school courses). 
May the force be with you (because you are going to need it). 

Feel free to reach out to me at nimishdhawan@cmail.carleton.ca or on discord @CUonOrbit server if you have any questions (or if something breaks).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CHANGELOG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V.2 Release 3: 
1. WMM 2025 functional now. COF file added to the package. (It makes the simulation very slow so please bear with it)
2. Fixed Roll-Pitch-Yaw angles for Spacecraft Attitude and Pointing Error.
3. Pointing error plot added to the GUI.
4. Moment of inertia of wheels can be now set in the GUI.
5. Atmosphere density model fixed. Now goes up to 900 km altitude. (min. 400 km)

V.2 Release 2:
1. Updated GUI - Dark mode.
2. The angular momentum plot is now fully coded along with magnetic moment for rods!
3. Few minor bugs fixed and some wrong math in the Simulink model corrected.

V.2 Release 1:
1. Went back to WMM 2024 since it is much faster run simulations with.
2. Updated the GUI and decluttered it.
3. Slew rate is now a tunable limiting factor based on rate of change of command torque.
4. Output tab is functional. Can plot MATLAB figures now for the simulation data under "Output" tab.

