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

The main objective of the project within the subject Digital Electronics 1 (Summer Semester 2022) was to create a Morse Code Receiver. The Morse Code Receiver has the ability to receive input from source (in our case - buttons on the Arty-A7-50T board) and translate it. After translation, user receives a sigle letter/number output on the 7-segement display. 

The singal enters the processing unit via pushbutton which is simulating the real-life scenario. Same as with the telegraphs back in the old days, where user only had the option to push or hold down on the telegraph key which resulted in dot or dash being transmitted. Our translating unit then receives the data input and uses comparable logic created mainly by `CASE - WHEN` statements. The length of each symbol is translated into an uniform lenght of 8bits. Translated sequence of 8bits is then rightaway displayed on the 7-segment display - lighting up corresponding a-g segments. The device is able to translate every letter of the Modern Englsih alphabet and numbers from 0 to 9. 

Source code, testbenches and simulations are all developed in integrated development environment Vivado.

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

### 7-segment display 
- `1st 7seg display` 7-segment display used for a single letter output from the received input

Pushbutton group used for input | 7segment display used to display translated output 
:-------------------------:|:-------------------------:
![PushButtons](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/PushButtons.jpg)|![7segUsed](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/7segUsed.jpg)


### Scheme 
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/Scheme.png) 

### Scheme description

`Edge detector` - receives binary input - zeros (0) and ones (1) - from push button `BTNU` and differentiates between `rising_edge` or `falling_edge`. If detector receives either rising_edge or falling_edge binary 1 is sent to output.

`Stopwatch 1` - measures time interval between rise and fall impulse received from `Edge detector`. Basically this means `Stopwatch 1` is measuring how long we've had 1 as an input.

`Stopwatch 2` - measures time interval between rise and fall impulse received from `Edge detector`. Basically this means `Stopwatch 2` is measuring how long we've had 0 as an input.

`Time_Decoder1` - after receiving fall_edge as an input,`Time_Decoder1` picks up the duration of the interval from `Stopwatch 1`. Picked up duration is then compared internally and decided upon, whether the output is dash (-) or dot (.) 

`Time_Decoder2` - after receiving rising_edge as an input,`Time_Decoder2` picks up the duration of the interval from `Stopwatch 2`. Picked up duration is then compared internally and decided upon, whether the output is char or word

`Morse_To_8bit_Shifter` - receives and translates the received binary input into an 8bit sequence. 

When dot (.) is received by the `Morse_To_8bit_Shifter` **0 (zero)** is added into memory. 

When dash (_) is received by the `Morse_To_8bit_Shifter` **1 (one)** is added into memory.

After receiving char or word sends out **ready** to output and displays collected data.


`8bit_To_7seg` - waiting for **ready** impulse from `Morse_To_8bit_Shifter`. After receiving mentioned impulse, reads out saved data and displays letter/number on the 7-segment display.


 | `Edge detector`                     	| receives binary input - zeros (0) and ones (1) - from push button `BTNU` and differentiates between `rising_edge` or `falling_edge`. If detector receives either rising_edge or falling_edge binary 1 is sent to output.                                                                                                                                                     	|   	|   	|   	|   	|   	|
|-------------------------------------	|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|---	|---	|---	|---	|---	|
| `Stopwatch 1`                       	| measures time interval between rise and fall impulse received from `Edge detector`. Basically this means `Stopwatch 1` is measuring how long we've had 1 as an input.                                                                                                                                                                                                        	|   	|   	|   	|   	|   	|
| `Stopwatch 2`                       	| measures time interval between rise and fall impulse received from `Edge detector`. Basically this means `Stopwatch 2` is measuring how long we've had 0 as an input.                                                                                                                                                                                                        	|   	|   	|   	|   	|   	|
| `Time_Decoder1`                     	| after receiving fall_edge as an input,`Time_Decoder1` picks up the duration of the interval from `Stopwatch 1`. Picked up duration is then compared internally and decided upon, whether the output is dash (-) or dot (.)                                                                                                                                                   	|   	|   	|   	|   	|   	|
| `Time_Decoder2`                     	| after receiving rising_edge as an input,`Time_Decoder2` picks up the duration of the interval from `Stopwatch 2`. Picked up duration is then compared internally and decided upon, whether the output is char or word                                                                                                                                                        	|   	|   	|   	|   	|   	|
| <br><br><br>`Morse_To_8bit_Shifter` 	| receives and translates the received binary input into an 8bit sequence.<br><br>When dot (.) is received by the `Morse_To_8bit_Shifter` **0 (zero)** is added into memory. <br><br>When dash (_) is received by the `Morse_To_8bit_Shifter` **1 (one)** is added into memory.<br><br>After receiving char or word sends out **ready** to output and displays collected data. 	|   	|   	|   	|   	|   	|
| `8bit_To_7seg`                      	| waiting for **ready** impulse from `Morse_To_8bit_Shifter`. After receiving mentioned impulse, reads out saved data and displays letter/number on the 7-segment display.                                                                                                                                                                                                     


<a name="modules"></a>

## VHDL modules description and simulations

Write your text here.

<a name="top"></a>

## TOP module description and simulations

Write your text here.

<a name="video"></a>


## License
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
