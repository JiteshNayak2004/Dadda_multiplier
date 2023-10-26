# pes_dadda_multiplier

## intro 
A Dadda Multiplier, also known as the Dadda Tree Multiplier, is a high-speed digital circuit used for multiplying two binary numbers. Named after its inventor T.C. Dadda, this multiplication algorithm and architecture were introduced in the 1960s. Dadda Multipliers are known for their efficiency in terms of both speed and hardware resources when compared to other multiplication techniques, such as the traditional long multiplication method.

## detailed operation

The Dadda Multiplier operates on a divide-and-conquer principle. It breaks down the multiplication into a series of partial products and then combines these partial products to yield the final result. This technique significantly reduces the number of full adders needed for the multiplication, making it an attractive choice for hardware designers looking to optimize speed and resource utilization.

1. Partial Product Generation:
To generate partial products, the Dadda Multiplier shifts one of the binary numbers (usually the multiplicand) and then selects the appropriate bits to generate a series of partial products. Each partial product corresponds to a '1' bit in the shifted multiplier. The Dadda Multiplier uses a combination of AND and XOR gates to calculate these partial products.

2. Partial Product Reduction:
After generating the partial products, the Dadda Multiplier employs a binary tree structure to add these partial products together. This tree structure is referred to as the Dadda Tree. It is specifically designed to minimize the number of adder stages required, which results in a faster multiplication process.

3. Dadda Tree Structure:
The Dadda Tree consists of multiple levels, with each level having a set of adder cells. The adder cells are arranged in such a way that they eliminate as many unnecessary zero bits as possible, thus optimizing the addition process. This efficient arrangement minimizes the overall delay and power consumption in the multiplier.

## Benefits of Dadda Multiplier:

Speed: Dadda Multipliers are faster than many other multiplication methods, making them suitable for applications requiring high-speed multiplication, such as digital signal processing.
Resource Efficiency: They require fewer hardware resources compared to traditional multipliers, making them valuable in resource-constrained designs.
Parallelism: Dadda Multipliers can be easily parallelized to further enhance their speed.
Drawbacks:

## running iverilog and gtkwave on design and testbench

![image](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/79163223-ddd8-4a29-a0d5-fc5fc2dc6c99)
![image](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/418b3edd-cec8-4d2a-93ec-47403b81c290)

## synthesizing using yosys
![image](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/a5ee0c7f-89fb-4de7-bf74-0b1fb3522209)
