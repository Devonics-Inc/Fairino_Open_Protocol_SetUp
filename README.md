# Fairino Open Protocol SetUp (using the AG-165 as an example)
### This repo contains the necessary files and instructions for setting up a custom gripper (using the AG-165 gripper as an example) for the Fairino cobot arm using the Open Peripheral Protocol for custom end effectors
### What you will need:
- AXLE_LUA_End_DaHuan.lua (included in this repo)
- FR_END_FV201005_MAIN_U01_T01_20240806.bin (included in repo)
- Fairino Robot
- DH AG Gripper

### Before you start: Set up your Fairino cobot configured to the 192.168.58.x IP and ensure you are able to reach the WebApp from your computer.

### Step 1 (Upgrading your firmware with the provided .bin file)
- Open the WebApp and navigate to "Application -> Tool App -> System Upgrade"
- Find the section that says "Firmware update" and check the "Upgrade End" option.
- Click on Choose the .bin file that was in this repo and click upload (You may have to power cycle the robot to ensure the upgrade)
### Step 2 (Setting up the open lua protocol):
 - Open the WebApp and navigate to "Initial -> Peripheral -> End-Tool -> Open Protocol"
 - Expand the "Protocol Configuration" tab and wait a couple seconds for it to load.
 - Ensure you are in "Manual mode" and then enter "Boot Mode"
 - Once in Boot Mode, select "Choose File" and select the AXLE_LUA_End_DaHuan.lua and click "Upload" 
 - The Web App will prompt you to power cycle the robot.

### Step 3 (Configuring the gripper)
- Direct yourself back to "Initial -> Peripheral -> End-Tool -> Open Protocol"
- Under Protocol Configuration, enter the bitrate as 115200, Data bits as 8, Stop bit as 1, Check as None, Overtime time as 10, number of timeouts as 3, periodic command interval as 1
- Toggle the "protocol enable" and select Equipment type as "Gripper Equipment".
- Ensure Device ID equals 1 and for the Function code, select the following
      - Initialization, Position, Speed, Torque, Read Position, Read Speed, Read Torque
- Once you have correctly set up the config, press Configure
- Then, press "Reset" then Active.
- Under "Adapted Device", ensure you change "Gripper Manu." to be "Dahuan" and click "configure" then "active"

## For Web App:
### Step 4:
- In your program, start by activating the gripper using: ActGripper(1,1)
- Now, you can move the gripper how you'd like by using:
- MoveGripper(1,position,force,speed,1000,0,0,0,0,0)

## For SDK:
### Step 4 (Prepping your SDK to handle the new gripper):
- First, connect to the robot using the "robot = Robot.RPC('192.168.58.x') command.
- Then, use "robot.SetGripperConfig(4, 0) to ensure that the robot knows it's using a DH gripper.
- Finally, use the robot.ActGripper(1,1) to activate it. After a 1 second sleep, you're ready to go!

### Notes for the programmers:
- There is some guess and check work to ensuring that you allot enough time for the gripper to complete it's commands. After some local testing, we found that the argument "maxTime" in the fairino "MoveGripper()" function directly correlates to the difference in position for the gripper. Meaning if you don't give enough time for a larger movement, you will get a timeout error. During testing/development, we reccomend starting with 5000 ms as the maxTime argument and see what works for your solution.
- Please note that the MoveGripper() function uses position, torque, and speed, but as there is no speed register in the AG-165, it will write to the non-existant 0x0104 register.
