# Microarchitecture-SPU-Lite-Processor

is represented the Architecture block diagram. Each of the core units are explained below: -

Fetch: This units fetches instruction from the Instruction memory and passes it to the decode stage. When any hazards are detected by the decode unit, this unit stalls the PC (Program Counter). Thereby no new instructions will be fetched.  If a branch is taken, this unit starts reading Instructions from the new Program Counter.

Decode: Decode unit performs varying op code length instruction decoding and also detects data and structural hazards and performs stall operations to overcome these hazards. 

Register File: The register file consists of 6 Read Ports and 2 Write Ports and has 128 entries with 128 bits each. The Register file has a write latency of 1 clock cycle. The register file data is sent to the even/odd pipes through the register forward unit for execution. Once the execution is completed, the results from the pipes are written back to the destination address.

Register Forward Unit: Register forward unit directs data from Decode Unit to the execution pipe lines. It forwards the operand data for each instruction either from the Register file or from the any stages of the execution pipes.

Even Pipe: This unit performs all the even type instructions as mentioned in the ISA table . In total, this pipe has 8 stages which includes 7 stages and a write back stage. Even pipe has 5 functional units Simple Fixed -1, Simple Fixed -2, Single Precision 1, Single Precision 2 and Byte. The latency and Unit id can be found in ISA table.
Odd Pipe: This unit performs all the odd type instructions as mentioned in the ISA table . In total, this  SDasdasdPermute and Local Store.The latency and Unit id can be found in ISA table.

Local Store: Local Store of size 32KB is used to store data memory. 


![image](https://user-images.githubusercontent.com/49031532/236107998-d1c15724-1cbe-420b-83cd-a0355c635504.png)
