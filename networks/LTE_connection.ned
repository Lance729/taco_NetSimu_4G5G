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
import simu5g.nodes.PgwStandard;
import simu5g.nodes.Ue;
import simu5g.nodes.eNodeB;
import simu5g.world.radio.LteChannelControl;


network SingleCell_D2D
{
    parameters:
        int numUeCell = default(1);
        int numUeD2DTx = default(0);
        int numUeD2DRx = default(0);
        @display("i=block/network2;bgb=991,558;bgi=background/budapest");
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
            @display("p=321,136;i=device/smallrouter");
        }
        pgw: PgwStandard {
            @display("p=520,175;is=l");
        }
        eNB: eNodeB {
            @display("p=391,260;is=vl");
        }
        ueCell[numUeCell]: Ue {
            @display("p=292,367");
        }
        ueD2DTx[numUeD2DTx]: Ue {
            @display("p=477,367");
        }
        ueD2DRx[numUeD2DRx]: Ue {
            @display("p=544,300");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        pgw.pppg++ <--> Eth10G <--> eNB.ppp;
}


network LTE_SingleCell_D2D_without_core_network
{
    parameters:
//        int numUeCell = default(1);
        int numUeD2DTx = default(0);
        int numUeD2DRx = default(0);
        @display("i=block/network2;bgb=991,558;bgi=background/budapest");
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
//        server: StandardHost {
//            @display("p=212,118;is=n;i=device/server");
//        }
//        router: Router {
//            @display("p=321,136;i=device/smallrouter");
//        }
//        pgw: PgwStandard {
//            @display("p=520,175;is=l");
//        }
        eNB: eNodeB {
            @display("p=391,260;is=vl");
        }
//        ueCell[numUeCell]: Ue {
//            @display("p=292,367");
//        }
        ueD2DTx[numUeD2DTx]: Ue {
            @display("p=477,367");
        }
        ueD2DRx[numUeD2DRx]: Ue {
            @display("p=544,300");
        }
    connections:
//        server.pppg++ <--> Eth10G <--> router.pppg++;
//        router.pppg++ <--> Eth10G <--> pgw.filterGate;
//        pgw.pppg++ <--> Eth10G <--> eNB.ppp;
}


network LTE_SingleCell
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=991,558;bgi=background/budapest");
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
            @display("p=321,136;i=device/smallrouter");
        }
        pgw: PgwStandard {
            @display("p=520,175;is=l");
        }
        eNB: eNodeB {
            @display("p=391,260;is=vl");
        }
        ue[numUe]: Ue {
            @display("p=783,278");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        pgw.pppg++ <--> Eth10G <--> eNB.ppp;
}





