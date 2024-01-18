# Dadda_multiplier
<details>
<summary> about the block </summary>
  
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
</details>

<details>
  
<summary> rtl design and synthesis </summary>
  
## running iverilog and gtkwave on design and testbench

![image](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/79163223-ddd8-4a29-a0d5-fc5fc2dc6c99)
![image](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/418b3edd-cec8-4d2a-93ec-47403b81c290)

## synthesizing using yosys
![image](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/a5ee0c7f-89fb-4de7-bf74-0b1fb3522209)

</details>


<details>
<summary>physical design</summary>



# RTL2GDSII FLow (simplified)

- synthesis
- Floorplanning
- Powerplanning
- Placement
- Clock Tree Synthesis
- Routing
- Signoff

# What is Physical Design?

Physical design refers to the process of transforming a logical description of an electronic system, such as a computer chip or integrated circuit, into a physical representation that can be manufactured. This involves a series of steps to layout and arrange various components, like transistors, wires, and interconnects, on a silicon wafer or other semiconductor material.

Key aspects of physical design include:

1) Floorplanning
2) Placement
3) Routing
4) Clock Tree Synthesis (CTS)
5) Power Planning
6) Signal Integrity Analysis
7) Timing Analysis
8) Design for Testability (DFT)
9) Physical Verification
10) Package Design

In physical design in simple terms when you have a design in Verilog, the next step is to take that logical description and go through the physical design process to create a layout that can be manufactured into an actual chip. This requires using Electronic Design Automation (EDA) tools.




OpenLane is an open-source, automated RTL-to-GDSII (Register-Transfer Level to Graphic Design System II) flow for digital integrated circuit design. It's essentially a complete toolchain that assists in the creation of Application-Specific Integrated Circuits (ASICs). The OpenLANE flow comprises a variety of tools such as Yosys, ABC, OpenSTA, Fault, OpenROAD app, Netgen and Magic which are used to harden chips and macros, i.e. generate final GDSII from the design RTL. The primary goal of OpenLANE is to produce clean GDSII with no human intervention. 

## Openlane installation
The original Documentation can be found here [OpenLane Installation](https://openlane.readthedocs.io/en/latest/getting_started/installation/installation_ubuntu.html)

#### Installing the pre-requisites
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git
```

#### Uninstall conflicting packages of docker if present

```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

```

#### Install Docker using ```apt``` repository

1. Setup Docker's ```apt``` repository

```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

2. Install other packages

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. Verify that the Docker Engine installation is successful by running the ```hello-world``` image.

```
sudo docker run hello-world
```

A successfull installation would look like
```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
1. The Docker client contacted the Docker daemon.
2. The Docker daemon pulled the "hello-world" image from the Docker Hub. (amd64)
3. The Docker daemon created a new container from that image which runs the executable that produces the output you are currently reading.
4. The Docker daemon streamed that output to the Docker client, which sent it to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
$ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
https://hub.docker.com/

For more examples and ideas, visit:
https://docs.docker.com/get-started/
```

5. Making Docker available without root (Linux)

```
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot # REBOOT!
```

6. Checking the docker installation after reboot

```
# After reboot
docker run hello-world
```

You will get a little happy message of Hello world, once again, but this time without root.

```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
1. The Docker client contacted the Docker daemon.
2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
   (amd64)
3. The Docker daemon created a new container from that image which runs the
   executable that produces the output you are currently reading.
4. The Docker daemon streamed that output to the Docker client, which sent it
   to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
$ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
https://hub.docker.com/

For more examples and ideas, visit:
https://docs.docker.com/get-started/
```

### Checking Installation Requirements

```
git --version
docker --version
python3 --version
python3 -m pip --version
make --version
python3 -m venv -h
```

Successful output will look like this:

```
git --version
docker --version
python3 --version
python3 -m pip --version
make --version
python3 -m venv -h
git version 2.36.1
Docker version 20.10.16, build aa7e414fdc
Python 3.10.5
pip 21.0 from /usr/lib/python3.10/site-packages/pip (python 3.10)
GNU Make 4.3
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
usage: venv [-h] [--system-site-packages] [--symlinks | --copies] [--clear]
            [--upgrade] [--without-pip] [--prompt PROMPT] [--upgrade-deps]
            ENV_DIR [ENV_DIR ...]

Creates virtual Python environments in one or more target directories.
...
Once an environment has been created, you may wish to activate it, e.g. by
sourcing an activate script in its bin directory.
```

### Download and Install Openlane

Run these one after the other

```
git clone --depth 1 https://github.com/The-OpenROAD-Project/OpenLane.git
cd OpenLane/
make
make test
```

Successful test will output the following line:

```
Basic test passed
```


# STEP-1

To make the physical design we first need to make our design file of the dadda_multiplier that we made to make this we need the ```dadda_multiplier.v``` file and the Skywater PDK's that Contains all the foundry provided PDK related files. To make this we first Make our ```dadda_multiplier``` folder within the design directory in Openlane and then we make another folder named as ```src``` and a file named  ```config.json``` inside the dadda_mulitplier folder.

To make the ```config.json``` file we type the following:

```vim config.json```

- in this vim text editor we type our design file.

``` sh
{
    "DESIGN_NAME": "dadda_multiplier",
    "VERILOG_FILES": "dir::src/dadda_multiplierr.v",
    "CLOCK_PORT": "clk",
    "CLOCK_PERIOD": 10.0,
    "DIE_AREA": "0 0 500 500",
    "FP_SIZING": "absolute",
    "FP_PDN_VPITCH": 25,
    "FP_PDN_HPITCH": 25,
    "FP_PDN_VOFFSET": 5,
    "FP_PDN_HOFFSET": 5,
    "DESIGN_IS_CORE": true
}
```

after making the ```config.json``` it should something as shown below:



after this we go to the src file and add the ```ring_counter.v``` file that we generated from Yosys in RTL synthesis and the required PDK's for our design.

# STEP-2

Once we have created our design file we invoke the openlane.

to invoke openlane and run the ASIC flow that completes all the key aspects of RTL2GDSII FLow physical design we type the following commands:

```sh
cd OpenLane
make mount
./flow.tcl -design <DESIGN NAME>  ## DESIGN NAME - here we are working with dadda_multiplier therefore our design name is gonna be dadda_multiplier
```

Once we invoke OpenLane it should look same as shown below:




## FLOORPLAN:

before viewing the floorplan we first need to go to the directory where the dadda_multiplier.def file for floorplan is created, we type the following command to locate the file:

```sh
OpenLane/designs/dadda_mulitplier/runs/RUN_2023.11.02_15.20.00/results/floorplan
```

this will give us 2 files present in the floorplan after the **Successfull flow** as shown below:

now to view the floorplan we type the following command:

```sh
magic -T /home/jitesh/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read dadda_mulitplier.def &
```

- The floorplan is viewed in MAGIC as shown below:
![floorplan](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/6a48fcc5-9287-4357-bbac-49151d556805)

![floorplan_zoomed](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/1e1a2e46-8e90-4c76-99f6-6e3a257e2ff8)


## PLACEMENT:

similar to floorplan before viewing the placement we first need to go to the directory where the ring_counter.def file  for placement is created, we type the following command to locate the file:

```sh
OpenLane/designs/dadda_mulitplier/runs/RUN_2023.11.02_15.20.00/results/placement
```

this will give us 4 files present in the placement after the **Successfull flow** as shown below:
now to view the placement we type the following command:

```sh
magic -T /home/jitesh/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read dadda_mulitplier.def &
```

- The Placement is viewed in MAGIC as shown below:

![placement_unzoomed](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/b44923d4-be22-47ca-ba0c-e8063f1568c8)


![placement](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/9ef5818c-9b0b-4bf0-bc28-7b80cf5a97b7)






## CTS (CLOCK TREE SYNTHESIS):

similar to placement before viewing the CTS we first need to go to the directory where the ring_counter.def file  for CTS is created, we type the following command to locate the file:

```sh
OpenLane/designs/dadda_multiplier/runs/RUN_2023.11.02_15.20.00/results/cts
```

this will give us 3 files present in the CTS after the **Successfull flow** as shown below:
1. dadda_mulitplier.def
2. dadda_mulitplier.odb
3. dadda_mulitplier.sdc

to view again we run the command
```sh
magic -T /home/jitesh/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read dadda_multiplier.def &
```
the cts viewed in magic is below


![cts](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/e0f0e3d4-1d6c-4706-ac19-86f8757c95de)




## ROUTING:

similar to CTS before viewing the Routing we first need to go to the directory where the dadda_mulitplier.def file  for Routing is created, we type the following command to locate the file:

```sh
OpenLane/designs/ring_counter/runs/RUN_2023.11.02_15.20.00/results/routing
```

this will give us 4 files present in the Routing after the **Successfull flow** as shown below:


now to view the CTS we type the following command:

```sh
magic -T /home/jitesh/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read dadda_multiplier.def &
```

- The Routing is viewed in MAGIC as shown below:
![routing](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/6819bd65-7048-4378-b950-6e2eb285d464)
![routing_zoomed](https://github.com/JiteshNayak2004/pes_dadda_multiplier/assets/117510555/41ea97cc-f5aa-4b18-8968-d7fd8ac915c6)


</details>
