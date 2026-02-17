%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CUonOrbit ADCS Simulator v2.0 
========================================================
Copyright
Nimish Dhawan 2025
========================================================

RUN ON MATLAB 2025b

**Please ensure you do the following in the correct order:**

REQUIRED TOOLBOX:
	- Aerospace Toolbox
	- Aerospace Blockset

1. Make a copy of this folder and call it "CUonOrbit_ADCS_app_FirstnameLastname" and paste it in your MATLAB environment.
2. In the command window enter "ADCS_gui". This command loads up the GUI.
3. The Setup tab allows users to confiigure the parameters of the simulation.
	- Bus panel allows users to configure the mass and structure properties and visualize them.
	- Orbit panel allows users to define the orbit of the spacecraft.
	- Attitude panel allows users to difine the initial conditions of the simulation.
	- The Hardware panel allows users to configure the hardware on-board the spacecraft for the simulation.
	- GNC panel allows users to tune the controller gains and configure the GNC software sampling rate.
	- The Simulation panel allows users to design the perfect simulaiton
4. After configuring the simulation parameters, users must load the Simulink model. The button with the same name prompts the user to select the Simulink diagram from the directory.
5. Run simulation as the name suggests, allows the user to run the simulation.
6. Users can view the motion of the spacecraft in the Animation tab. 
7. The Results tab allows for a quick glance at the simulation output. To produce proper MATLAB plots, users are recommended to use the plotting feature:
	Tools > Generate MATLAB Plots

Lastly please do not copy paste the code you see here for any projects outside the club (especially for school courses). 
May the force be with you (because you are going to need it). 

Feel free to reach out to me at nimishdhawan@cmail.carleton.ca or on discord @CUonOrbit server if you have any questions (or if something breaks).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CHANGELOG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V.3 Release 1:
1. Complete rewamp, the ADCS simulator user interface is now a stand alone application.
2. Users are can configure all parameters through the GUI, no MATLAB script required.
3. Users can save and load GUI states.
4. Users can save simulation output.
5. Users can define and visualize the spacecraft bus.
6. Users can visualize the attitude of the spacecraft in animation playback.
6. Users can generate .a files for STK attitude viewer.

V.2 Release 4:
1. Works on MATLAB 2025b now.
2. GUI only stable for dark mode.

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

