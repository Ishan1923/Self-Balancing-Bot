# **Self Balancing Robot with Dashboard**

---

##**PIC Controller**

---

## **Django Made Interface**

--- 

## **HARDWARE**

---

### L293D IC Working

**Features of L293D IC:**
1. Wide supply voltage range: 4.5V to 36V  
2. Output current 600mA per channel  
3. Peak Output current 1.2A per channel  
4. High Noise Immunity Inputs  
5. Separate electrostatic discharge protection  

The motor has a total of 16 pins:  
![image](https://github.com/user-attachments/assets/8f653f93-b64b-4fff-8e48-ccdcd06da93a)

![image](https://github.com/user-attachments/assets/472439fc-7dc3-4afc-a07f-cb61df6b5805)



**Functional block diagram:**  
![image](https://github.com/user-attachments/assets/b8e9ef86-de24-439e-8722-6b04d63b8c3b)  
*taken from https://how2electronics.com/wp-content/uploads/2022/08/L293D-Functional-Block-Diagram.png*

**Working:**  
The IC provides us with 4 inputs: IN1, IN2, IN3, IN4 at input pins 2, 7, 10, and 14 respectively.  
Depending on the input pins and enable pins value, the motor will either run in clockwise, anti-clockwise, or stop.

| input  | output | Enable          | Result                    |
|--------|--------|------------------|----------------------------|
| X      | X      | 0                | Stop                      |
| 0      | 0      | 1                | Stop                      |
| 0      | 1      | 1                | ACW                       |
| 1      | 0      | 1                | CW                        |
| 1      | 1      | 1                | Stop                      |
| 0      | 1      | 50% duty cycle   | ACW with 50% lesser speed |
| 1      | 0      | 50% duty cycle   | CW with 50% lesser speed  |

**Working of H-Bridge:**  
![image](https://github.com/user-attachments/assets/159de629-5e75-4fc9-8d3a-2e064e4d9cb3)

H-bridge is being used in the L293D IC. As from the diagram, there are 4 switches S1, S2, S3, S4 respectively where S1, S2 are connected to high potential and S3, S4 are connected to ground or lower voltages.  
Whenever the S1, S4 are closed, the circuit gets complete and the charge starts flowing in the anti-clockwise direction, and whenever the switches S2 and S3 are closed, the motor runs in clockwise direction.

There is one interesting question — how does the motor, which is an actuator, get the analog-like signal from electronic components which work on DC signals?  
The answer is PWM (Pulse Width Modulation) of the DC signal. Basically, a DC signal is mainly 0 (GND or 0V) and 1 (5V).  
So by controlling the frequency of the enable pins' signal, we get to control the speed of the motor:  
- If it's 1 it will be full speed  
- If it’s in between then it will be slower  
- 0 or floating means stop

---

### We will be using NodeMCU ESP8266 WiFi Module

---

## **NodeMCU ESP8266**

**Architecture:**
1. It follows Harvard architecture, that is different memories for instructions and memory-storage.  
2. It uses a 16-bit instruction set, with a 32-bit processor (Tensilica L106 diamond series), and has SRAM on SoC.  
3. Espressif Systems’ Smart Connectivity Platform (ESCP) enables sophisticated features including:
   - Fast switch between sleep and wakeup mode for energy-efficient purpose
   - Adaptive radio biasing for low-power operation
   - Advanced signal processing
   - Spur cancellation and RF co-existence mechanisms for common cellular, Bluetooth  
4. WiFi Specifications:
   - 802.11 b/g/n support
   - 802.11 n support (2.4 GHz), up to 72.2 Mbps
   - Defragmentation
   - 2 × virtual Wi-Fi interface
   - Automatic beacon monitoring (hardware TSF)
   - Support Infrastructure BSS Station mode / SoftAP mode / Promiscuous mode
   - DDR, LVDS, LCD interference mitigation

![image](https://github.com/user-attachments/assets/e38037d2-b084-43f6-83cd-a01f89581375)

**CPU:**
The CPU includes:
- Programmable RAM/ROM interfaces (iBUS), connected with memory controller, used to visit flash  
- Data RAM interface (dBUS), which can be connected with memory controller  
- To visit register, AHB (Advanced High Performance BUS) interface  

**Memory:**

**External Flash:**  
- OTA disabled: 512KB at least  
- OTA enabled: 1MB at least  

---

### **PWM:**

![image](https://github.com/user-attachments/assets/0f652de6-5210-4d99-97c8-fc1d64341844)

`-----PWM_Image------`
