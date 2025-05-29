
# Install dependencies
Followint the officially installing [cookbook](https://github.com/omnetpp/opp_env/blob/main/INSTALL.md), You can install `opp_env` using `pip`:
```bash
$ pip install opp_env

# print all available software packages
opp_env list 

# print information about the latest version of the simu5g package
opp_env info simu5g-latest 


$ mkdir my_workspace
$ cd my_workspace 
$ opp_env init 

# install the latest version of the simu5g package
$ opp_env install simu5g-latest
```

After intalling the required dependencies, you will have the project structure is:
```
My_Workspace
|-- inet-4.5.4
|-- omnetpp-6.1.0
|-- simu5g-1.3.0
|-- taco_net_simu
```
# How to run?

<!-- ## Showcase -->

<img src="./omnetpp_simu_showcase.gif" alt="The running process showcase" width="500"> 5G NR Uplink simulation.


Our simulation examples test the uplink and downlink throughput of 5G NR and 4G LTE networks respectively. Our configuration complies with the theoretical peak data rate (Peak Data Rate) specified in 3GPP Release 15 (which may not be achievable in practice), as well as the "user experienced" data rate (5th percentile) specified by IMT-2020.[Devopedia](https://devopedia.org/5g-ue-data-rate?utm_source=chatgpt.com). 

- To run the 5G NR network and DL as well UL traffic, you can use the following command:
    ```shell
    $ cd taco_net_simu

    $ opp_run -m -n .:../inet-4.5.4/examples:../inet-4.5.4/showcases:../inet-4.5.4/src:../inet-4.5.4/tests/validation:../inet-4.5.4/tests/networks:../inet-4.5.4/tutorials:../simu5g-1.3.0/emulation:../simu5g-1.3.0/simulations:../simu5g-1.3.0/src -x "inet.common.selfdoc;inet.emulation;inet.examples.emulation;inet.showcases.emulation;inet.showcases.visualizer.osg;inet.visualizer.osg;simu5g.simulations.LTE.cars;simu5g.simulations.NR.cars;simu5g.nodes.cars" --image-path=../inet-4.5.4/images:../simu5g-1.3.0/images -l ../inet-4.5.4/src/INET -l ../simu5g-1.3.0/src/simu5g run_NR_network.ini
    ```

- To run the 4G LTE network and DL as well UL traffic, you can use the following command:
    ```bash
    $ cd taco_net_simu

    $ opp_run -m -n .:../inet-4.5.4/examples:../inet-4.5.4/showcases:../inet-4.5.4/src:../inet-4.5.4/tests/validation:../inet-4.5.4/tests/networks:../inet-4.5.4/tutorials:../simu5g-1.3.0/emulation:../simu5g-1.3.0/simulations:../simu5g-1.3.0/src -x "inet.common.selfdoc;inet.emulation;inet.examples.emulation;inet.showcases.emulation;inet.showcases.visualizer.osg;inet.visualizer.osg;simu5g.simulations.LTE.cars;simu5g.simulations.NR.cars;simu5g.nodes.cars" --image-path=../inet-4.5.4/images:../simu5g-1.3.0/images -l ../inet-4.5.4/src/INET -l ../simu5g-1.3.0/src/simu5g run_LTE_network.ini
    ```




# Introduction to results

## Results Analysis
- The 5G NR throughput results are saved in the `results/NR_UL/NR_UL.json` and `results/NR_DL/NR_DL.json`, whose features are:
    - `NR_UL.json`:  mean=2.51887e+06Bps min=55592.6Bps   max=2.95847e+06Bps (unit in Bps)
    - `NR_DL.json`:  mean=1.736e+08  min=1.2e+08  max=2e+08 (unit in bps)

- The 4G LTE throughput results are saved in the `results/LTE_UL/LTE_UL.json` and `results/LTE_DL/LTE_DL.json`, whose features are:
    - `LTE_UL.json`:  mean=947732  min=42156.1  max=1.3051e+06 (unit in Bps)
    - `LTE_DL.json`:  mean=2.75408e+06  min=325235  max=2.76312e+06 (unit in Bps)

Note: `Bps` differs from `bps`. 1 Byte = 8 bits, 1 Bps = 8 × 10⁻⁶ Mbps

## (Optional) If you want export the results from raw data?
First, you must run the showcase certainly :)

After run a simulation, the results are saved in the `results` folder, in which `*.vec` files are results of the simulation and can be transformed into `*.json` format using `opp_scavetool` command for each `*.vec` file:
```shell
$ cd taco_net_simu/results

# Export 5G NR UL results
$ opp_scavetool export -f 'module =~"SingleCell_Standalone.ue[0].cellularNic.nrRlc.um" AND name=~"rlcThroughputUl:vector"' -F JSON -o results/NR_UL/NR_UL_0.json results/NR_UL/0.vec

# Export 5G NR DL results
$ opp_scavetool export -f 'module =~"Two_host_comm_wire.hostB.app[0]" AND name=~"throughput:vector"' -F JSON -o results/NR_DL/NR_DL.json results/NR_DL/0.vec 

# Export 4G LTE UL results
$ opp_scavetool export -f 'module =~"LTE_SingleCell.ue[0].cellularNic.rlc.um" AND name=~"rlcThroughputUl:vector"' -F JSON -o results/LTE_UL/LTE_UE_rlcUL_throughput.js
on results/LTE_UL/0.vec

# Export 4G LTE DL results
$ opp_scavetool export -f 'module =~"LTE_SingleCell.ue[0].cellularNic.rlc.um" AND name=~"rlcThroughputDl:vector"' -F JSON -o results/LTE_DL/LTE_UE_rlcDL_throughput.json results/LTE_DL/0.vec
```



In case you want raw data, you can use the no-filter option. We make the `LTE_UL` as example:
```bash
$ cd results

$ opp_scavetool export -F JSON -o results/LTE_UL/LTE_UL.json  results/LTE_UL/0.vec
```


