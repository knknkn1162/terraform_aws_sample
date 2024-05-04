```
set interfaces ethernet eth1 ...
Possible completions:
+  address      IP address
   description  Interface specific description
 > dhcp-options DHCP client settings/options
 > dhcpv6-options
                DHCPv6 client settings/options
   disable      Administratively disable interface
   disable-flow-control
                Disable Ethernet flow control (pause frames)
   disable-link-detect
                Ignore link state changes
   duplex       Duplex mode (default: auto)
 > eapol        Extensible Authentication Protocol over Local Area Network
 > firewall     Firewall options
   hw-id        Associate Ethernet Interface with given Media Access Control (MAC) address
 > ip           IPv4 routing parameters
 > ipv6         IPv6 routing parameters
   mac          Media Access Control (MAC) address
 > mirror       Incoming/outgoing packet mirroring destination
   mtu          Maximum Transmission Unit (MTU) (default: 1500)
 > offload      Configurable offload options
 > policy       Policy route options
   redirect     Incoming packet redirection destination
 > ring-buffer  Shared buffer between the device driver and NIC
   speed        Link speed (default: auto)
 > traffic-policy
                Traffic-policy for interface
+> vif          Virtual Local Area Network (VLAN) ID
+> vif-s        QinQ TAG-S Virtual Local Area Network (VLAN) ID
   vrf          VRF instance name
```