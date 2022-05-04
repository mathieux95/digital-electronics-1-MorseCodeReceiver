# Morse Code Receiver

![Logo](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/logo-en%201.png)

## Team members

* Matej Gradoš (ID:230551) (Github repository completetion, alphabet-to-morseCode-to-8bit translation) [@mathieux95](https://github.com/mathieux95)
* Patrik Horčička (ID: 230558) ( Stopwatches, TimeDecoders) [@patrikhor](https://github.com/patrikhor)
* Adam Ondrejka (ID: 216915) (Edge_detector, comments in code, components) [@xondre](https://github.com/xondre)
* David Carboch (ID: 221654) (Morse_to_8bit_shifter, video presentation of the overall project) [@EzopVonJanoviceCity](https://github.com/EzopVonJanoviceCity)

### Table of contents 

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [Detection algorithm description](#detection)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Video](#video)
* [References](#references)

<a name="objectives"></a>

## Project objectives

The main objective of the project within the subject Digital Electronics 1 (Summer Semester 2022) was to create a Morse Code Receiver. The Morse Code Receiver has the ability to receive input from source (in our case - buttons on the Arty-A7-50T board) and translate it. After translation, user receives a sigle letter/number output on the 7-segement display. 

The singal enters the processing unit via pushbutton which is simulating the real-life scenario. Same as with the telegraphs back in the old days, where user only had the option to push or hold down on the telegraph key which resulted in dot or dash being transmitted. Our translating unit then receives the data input and uses comparable logic created mainly by `CASE - WHEN` statements. <br /> <br />
The length of each symbol is translated into an uniform lenght of 8bits. Translated sequence of 8bits is then rightaway displayed on the 7-segment display - lighting up corresponding a-g segments. The device is able to translate every letter of the Modern Englsih alphabet and numbers from 0 to 9. 

Source code, testbenches and simulations were all developed in integrated development environment **Vivado**.

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
- `7seg display` 7-segment display used for a single letter output from the received input

Pushbutton group used for input | 7segment display used to display translated output 
:-------------------------:|:-------------------------:
![PushButtons](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/PushButtons.jpg)|![7segUsed](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/7segUsed.jpg)


<a name="detection"></a>

## Detection algorithm description
Every letter of the English alphabet and number is assigned an 8bit binary value created by a simple algorithm based on [International Morse Code rule book](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/morse_code.png)
<br />
<br />
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/Shifting_operation.png)
<br />
<br />
**Algorithm of creating 8bit words to binary representation**
- Every symbol in initialized by marker - 1
- Dot is represented by zero - 0
- Dash is represented by one - 1  


**Algorithm of creating 8bit words to binary representation - picture** 

![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/8bit_logic.png)
<br />
<br />
**Letters and numbers assigned 8bit value** can be found [here](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/support_files/MorseCodeDecoder_8bit.xlsx) .
<br />
<br />
To make the output fully functional and working properly assigning segments on a 7segment display is essential. To display corresponding values on the 7segment display we used [this](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/siekoo-alphabet.gif) manual.
<br />
<br />

## VHDL modules description and simulations

#### Detection of `rising_ege` and `falling_edge`  
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/01-detekce_rice_fall-edge.png) 
### Measuring time interval in `0`
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/02-cas-samplu-v-0.png) 
### Measuring time interval in `1`
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/02-cas-samplu-v-1.png) 
### Decoding time interval - decision time to assign `dot(.)` or `dash(-)`
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/03-zCasu-dot-dash.png) 
### Decoding time interval - decision time to assing `char` or `word`
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/04-zCasu-char-word.png) 
### Saving data into memory - displaying output on `7-segment display` 
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/05-UlozeniDatDoPametivypisDanehoZnakuNaSegment.png) 
<br />

<a name="top"></a>

## TOP module description and simulations

### Scheme 
![your figure](https://github.com/mathieux95/digital-electronics-1-MorseCodeReceiver/blob/main/images/Scheme.png) 
<br />
<br />
| Block | Description |
|:---|:---|
| `Edge detect` | Receives binary input - [0] and [1] - from push button `BTNU` Differentiates between `rising_edge` or `falling_edge`. <br /> When detector receives either rising_edge or falling_edge binary 1 is sent to output. |
| `Stopwatch1` | Measures time interval between rise and fall impulse received from `Edge detector`. <br /> This means `Stopwatch 1` is measuring how long we've had 1 as an input. |
| `Stopwatch2` | Measures time interval between rise and fall impulse received from `Edge detector`. <br /> This means `Stopwatch 2` is measuring how long we've had 0 as an input. |
| `Time_Decoder1` | After fall_edge received on input `Time_Decoder1` picks up the duration of the interval from `Stopwatch 1`. <br /> Picked up duration is then compared internally and decided upon, whether the output is **dash (-)** or **dot (.)**. |
| `Time_Decoder2` | After receiving rising_edge as an input `Time_Decoder2` picks up the duration of the interval from `Stopwatch 2`. <br /> Picked up duration is then compared internally and decided upon, whether the output is **char** or **word**. |
| `Morse_To_8bit_Shifter` | Receives and translates the received binary input into an 8bit sequence.When dot (.) is received by the `Morse_To_8bit_Shifter` **0 (zero)** is added into memory. <br /> When dash (-) is received by the `Morse_To_8bit_Shifter` **1 (one)** is added into memory.After receiving char or word sends out **ready** to output and displays collected data. |
| `8bit_To_7seg` | Waiting for **ready** impulse from `Morse_To_8bit_Shifter`. <br /> After receiving mentioned impulse, reads out saved data and displays letter/number on the 7-segment display. |
<br />

## Video presentation
<a name="video"></a> https://youtu.be/Kkrv4JOsWZg 

<a name="references"></a>

## References
- https://vhdlguide.readthedocs.io/en/latest/index.html
- https://stackoverflow.com/questions/18291515/variable-number-of-in-ports-in-an-entity
- https://www.researchgate.net/publication/305379385_Morse_code_decoder_design_in_VHDL_using_FPGA_Spartan_3E_development_kit

## License
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
