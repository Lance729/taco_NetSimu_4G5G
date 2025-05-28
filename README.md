
# Install dependencies

.After intalling the required dependencies, you will have the project structure is:
```
.
|-- inet-4.5.4
|-- omnetpp-6.1.0
|-- simu5g-1.3.0
|-- standalone_taco
```
# How to run


Then run the following command:
```bash
$ cd standalone_taco

$ opp_run -m -n .:../inet-4.5.4/examples:../inet-4.5.4/showcases:../inet-4.5.4/src:../inet-4.5.4/tests/validation:../inet-4.5.4/tests/networks:../inet-4.5.4/tutorials:../simu5g-1.3.0/emulation:../simu5g-1.3.0/simulations:../simu5g-1.3.0/src -x "inet.common.selfdoc;inet.emulation;inet.examples.emulation;inet.showcases.emulation;inet.showcases.visualizer.osg;inet.visualizer.osg;simu5g.simulations.LTE.cars;simu5g.simulations.NR.cars;simu5g.nodes.cars" --image-path=../inet-4.5.4/images:../simu5g-1.3.0/images -l ../inet-4.5.4/src/INET -l ../simu5g-1.3.0/src/simu5g run_LTE_network.ini
```


# (Optional) How to install
