# Morse Code Receiver

![Logo](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/logo-en%201.png)

## Team members

* Matej Gradoš (ID:230551) (responsible for xxx) [@mathieux95](https://github.com/mathieux95)
* Patrik Horčička (ID: 230558) (responsible for xxx) [@patrikhor](https://github.com/patrikhor)
* Adam Ondrejka (ID: 216915) (responsible for xxx) [@xondre](https://github.com/xondre)
* David Carboch (ID: 221654) (responsible for xxx) [@EzopVonJanoviceCity](https://github.com/EzopVonJanoviceCity)

### Table of contents 

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Video](#video)
* [References](#references)

<a name="objectives"></a>

## Project objectives

The main objective of the project within the subject Digital Electronics 1 (Summer Semester 2022) was to create a Morse Code Receiver. The Morse Code Receiver has the ability to receive input from source (in our case - buttons on the Arty-A7-50T board) and translate it. After translation, you get a sigle letter output on the 7-segement display. 

For completetion of the project we used these components: 
* NEXYS A7 50T board to conotrol all of the other parts
* 7-segment displays
* 2/5 push buttons on the Nexys A7 50T board (located in the right hand corner) 

The singal enters the processing unit via _____ connector, which receives the data input and uses comparable logic created mainly by IF / ELSEIF statements. The length of each symbol is 19bits, which after translation show up on the 7-segment displays. Each letter of the alphabet will be translated separately with final output lighting up on the a-g segments.  
Source code, testbenches and simulations are all developed in Vivado.

<a name="hardware"></a>

## Hardware description
### Nexys A7-50T
The Nexys A7 board is a complete, ready-to-use digital circuit development platform based on the latest Artix-7TM
Field Programmable Gate Array (FPGA) from Xilinx®. With its large, high-capacity FPGA, generous external
memories, and collection of USB, Ethernet, and other ports, the Nexys A7 can host designs ranging from
introductory combinational circuits to powerful embedded processors. Several built-in peripherals, including an
accelerometer, temperature sensor, MEMs digital microphone, a speaker amplifier, and several I/O devices allow
the Nexys A7 to be used for a wide range of designs without needing any other components.

![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/nexysA7-50T.png) 

### Pushbuttons
-  `BTNU` Pushbutton located on the top of the group is used for input of the signal (hold = dash, quick push = dot) 
-  `BTNC` Pushbutton located in the center of the group is used for reset of the memory


Pushbuttons used |7segment display used to display translated output 
:-------------------------:|:-------------------------:
![PushButtons](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/PushButtons.jpg)|![7segUsed](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/7segUsed.jpg)



<a name="modules"></a>

## VHDL modules description and simulations

Write your text here.

<a name="top"></a>

## TOP module description and simulations

Write your text here.

<a name="video"></a>


## License
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
