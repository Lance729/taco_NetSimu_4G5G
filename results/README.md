
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


