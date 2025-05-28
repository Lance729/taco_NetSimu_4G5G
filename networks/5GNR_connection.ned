//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package networks;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.NR.NRUe;
import simu5g.nodes.NR.gNodeB;
import simu5g.nodes.PgwStandard;
import simu5g.nodes.Upf;
import simu5g.nodes.backgroundCell.BackgroundCell;
import simu5g.nodes.eNodeB;
import simu5g.nodes.mec.MECHost;
import simu5g.nodes.mec.MECOrchestrator.MecOrchestrator;
import simu5g.nodes.mec.UALCMP.UALCMP;
import simu5g.world.radio.LteChannelControl;


import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.contract.INetworkNode;
import inet.physicallayer.wireless.common.contract.packetlevel.IRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;

network NR_Connection
{
    parameters:
        int numUe = default(1);
        int numBgCells = default(0);
        @display("i=block/network2;bgb=1000,500;bgi=background/pisa");
    submodules:
        channelControl: LteChannelControl {
            @display("p=50,25;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=50,75;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,125");
        }
        binder: Binder {
            @display("p=50,175;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=50,258;is=s");
        }
        server: StandardHost {
            @display("p=212,118;is=n;i=device/server");
        }
        router: Router {
            @display("p=363,115;i=device/smallrouter");
        }
        upf: Upf {
            @display("p=527,116");
        }
        iUpf: Upf {
            @display("p=725,118");
        }
        gnb: gNodeB {
            @display("p=697,309;is=vl");
        }
        //    bgCell[numBgCells]: BackgroundCell {
        //        @display("p=416,277;is=vl");
        //    }
        ue[numUe]: NRUe {
            @display("p=438,273");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> upf.filterGate;
        upf.pppg++ <--> Eth10G <--> iUpf.pppg++;
        iUpf.pppg++ <--> Eth10G <--> gnb.ppp;
}




network Two_host_comm_wire
{
    parameters:
        // @display("bgb=650,500;bgg=100,1,grey95");
        @figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);

        @figure[rcvdPkText](type=indicatorText; pos=380,20; anchor=w; font=,18; textFormat="packets received: %g"; initialValue=0);
        @statistic[packetReceived](source=hostB.app[0].packetReceived; record=figure(count); targetFigure=rcvdPkText);
        @display("i=block/network2;bgb=1000,500;bgi=background/pisa");
    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=50,125");
        }
        channelControl: LteChannelControl {
            @display("p=50,25;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=50,75;is=s");
        }
        binder: Binder {
            @display("p=50,90;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=50,100;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,120");
        }
        radioMedium: <default("UnitDiskRadioMedium")> like IRadioMedium {
            @display("p=50,130");
        }
        gnb: gNodeB {
            @display("p=97,309;is=vl");
        }
        hostA: <default("WirelessHost")> like INetworkNode {
            @display("p=60,325");
        }
        hostB: <default("WirelessHost")> like INetworkNode {
            @display("p=90,325");
        }


}




































// -------------------以下的都还没有完成------------------------
// MultiCell_withSecondaryGnb
//
// This network represents the deployment option 3a in 3GPP 38.801
// A gNodeB is serving as secondary node for a LTE eNodeB, which is connected
// to the LTE EPC. All data-plane traffic goes through the LTE eNodeB
//
network MultiCell_withSecondaryGnb
{
    parameters:
        int numUe = default(1);
        int numBgCells = default(0);
        @display("i=block/network2;bgb=1100,800;bgi=background/pisa");
    submodules:
        channelControl: LteChannelControl {
            @display("p=104,62;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=106,131;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,172");
        }
        binder: Binder {
            @display("p=106,334;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=106,418;is=s");
        }
        server: StandardHost {
            @display("p=273,48;is=n;i=device/server");
        }
        router: Router {
            @display("p=393,46;i=device/smallrouter");
        }
        pgw: PgwStandard {
            @display("p=530,49;is=n");
        }
        masterEnb1: eNodeB {
            @display("p=363,277;is=vl");
        }
        secondaryGnb1: gNodeB {
            @display("p=527,461;is=vl");
        }
        //        masterEnb2: eNodeB {
        //            @display("p=692,277;is=vl");
        //        }
        //        secondaryGnb2: gNodeB {
        //            @display("p=856,461;is=vl");
        //        }
        bgCell[numBgCells]: BackgroundCell {
            @display("p=1000,107;is=vl");
        }
        ue[numUe]: NRUe {
            @display("p=526,334");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        pgw.pppg++ <--> Eth10G <--> masterEnb1.ppp;
//        pgw.pppg++ <--> Eth10G <--> masterEnb2.ppp;

        //# X2 connections
        secondaryGnb1.x2++ <--> Eth10G <--> masterEnb1.x2++;
}


network singleMecHost
{
    parameters:
        @display("i=block/network2;bgb=811,507;bgi=background/pisa");

        int numUes = default(0);

        double playgroundSizeX @unit(m); // x size of the area the nodes are in (in meters)
        double playgroundSizeY @unit(m); // y size of the area the nodes are in (in meters)
        double playgroundSizeZ @unit(m); // z size of the area the nodes are in (in meters)

    submodules:

        routingRecorder: RoutingTableRecorder {
            @display("p=690,104;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=690,184;is=s");
        }
        channelControl: LteChannelControl {
            @display("p=690,24;is=s");
        }
        binder: Binder {
            @display("p=690,264;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=691,342;is=s");
        }
        upf: Upf {
            @display("p=545,250");
        }
        iUpf: Upf {
            @display("p=352,250");
        }
        gNodeB1: gNodeB {
            @display("p=140,250;is=vl");
        }
        ue[numUes]: NRUe {
            @display("p=237,310");
        }
        //# MEC module
        mecHost: MECHost {
            @display("p=352,145;is=l");
        }

        mecOrchestrator: MecOrchestrator {
            @display("p=544,63;is=l");
        }

        ualcmp: UALCMP {
            @display("p=545,158;i=device/smallrouter");
        }


    connections allowunconnected:

        upf.pppg++ <--> Eth10G <--> iUpf.pppg++;
        iUpf.pppg++ <--> Eth10G <--> gNodeB1.ppp;
        ualcmp.ppp++ <--> Eth10G <--> upf.filterGate;

        ualcmp.toMecOrchestrator --> mecOrchestrator.fromUALCMP;
        ualcmp.fromMecOrchestrator <-- mecOrchestrator.toUALCMP;

        mecHost.ppp++ <--> Eth10G <--> iUpf.pppg++;
}


network NR_Host2Host
{
    parameters:
        @display("i=block/network2;bgb=811,507;bgi=background/pisa");

        int numHostTx = default(0);
        int numHostRx = default(0);

        double playgroundSizeX @unit(m); // x size of the area the nodes are in (in meters)
        double playgroundSizeY @unit(m); // y size of the area the nodes are in (in meters)
        double playgroundSizeZ @unit(m); // z size of the area the nodes are in (in meters)

    submodules:

        routingRecorder: RoutingTableRecorder {
            @display("p=690,104;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=690,184;is=s");
        }
        channelControl: LteChannelControl {
            @display("p=690,24;is=s");
        }
        binder: Binder {
            @display("p=690,264;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=691,342;is=s");
        }
        //        upf: Upf {
        //            @display("p=545,250");
        //        }
        //        iUpf: Upf {
        //            @display("p=352,250");
        //        }
        mecHostTx[numHostTx]: MECHost {
            @display("p=199,264;is=l");
        }
        mecHostRx[numHostRx]: MECHost {
            @display("p=484,254;is=l");
        }

}


