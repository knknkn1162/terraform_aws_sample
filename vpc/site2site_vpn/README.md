# info

+ AWS Hands-on for Beginners Network編#2
+ VyOS 1.3.6

## command

```sh
show vpn ike sa
show vpn ipsec sa
show ip route
show ip bgp
show interfaces
```

### sample

```sh
$ show vpn ike sa
Peer ID / IP                            Local ID / IP               
------------                            -------------
13.112.28.41                            10.1.1.226                             

    Description: VPC tunnel 1

    State  IKEVer  Encrypt  Hash    D-H Group      NAT-T  A-Time  L-Time
    -----  ------  -------  ----    ---------      -----  ------  ------
    up     IKEv2   aes128   sha1_96 2(MODP_1024)   no     3600    28800  

 
Peer ID / IP                            Local ID / IP               
------------                            -------------
13.114.15.204                           10.1.1.226                             

    Description: VPC tunnel 2

    State  IKEVer  Encrypt  Hash    D-H Group      NAT-T  A-Time  L-Time
    -----  ------  -------  ----    ---------      -----  ------  ------
    up     IKEv2   aes128   sha1_96 2(MODP_1024)   no     3600    28800  
```

```sh
$ show vpn ipsec sa
Connection                     State    Uptime    Bytes In/Out    Packets In/Out    Remote address    Remote ID    Proposal
-----------------------------  -------  --------  --------------  ----------------  ----------------  -----------  ----------------------------------
peer-13.112.28.41-tunnel-vti   up       1m59s     1K/1K           17/25             13.112.28.41      N/A          AES_CBC_128/HMAC_SHA1_96/MODP_1024
peer-13.114.15.204-tunnel-vti  up       1m59s     1K/1K           18/25             13.114.15.204     N/A          AES_CBC_128/HMAC_SHA1_96/MODP_1024
$ show vpn ipsec connections
Connection                     State    Type     Remote address    Local TS    Remote TS    Local id    Remote id      Proposal
-----------------------------  -------  -------  ----------------  ----------  -----------  ----------  -------------  ----------------------------------
peer-13.112.28.41-tunnel-vti   up       IKEv1/2  13.112.28.41      -           -            10.1.1.226  13.112.28.41   AES_CBC/128/HMAC_SHA1_96/MODP_1024
peer-13.112.28.41-tunnel-vti   up       IPsec    13.112.28.41      0.0.0.0/0   0.0.0.0/0    10.1.1.226  13.112.28.41   AES_CBC/128/HMAC_SHA1_96/MODP_1024
peer-13.114.15.204-tunnel-vti  up       IKEv1/2  13.114.15.204     -           -            10.1.1.226  13.114.15.204  AES_CBC/128/HMAC_SHA1_96/MODP_1024
peer-13.114.15.204-tunnel-vti  up       IPsec    13.114.15.204     0.0.0.0/0   0.0.0.0/0    10.1.1.226  13.114.15.204  AES_CBC/128/HMAC_SHA1_96/MODP_1024
```

```sh
$ show ip route
Codes: K - kernel route, C - connected, S - static, R - RIP,
       O - OSPF, I - IS-IS, B - BGP, E - EIGRP, N - NHRP,
       T - Table, v - VNC, V - VNC-Direct, A - Babel, D - SHARP,
       F - PBR, f - OpenFabric,
       > - selected route, * - FIB route, q - queued, r - rejected, b - backup

S>* 0.0.0.0/0 [210/0] via 10.1.1.1, eth0, weight 1, 00:05:38
B>* 10.0.0.0/16 [20/100] via 169.254.95.133, vti1, weight 1, 00:02:14
C>* 10.1.1.0/24 is directly connected, eth0, 00:05:39
C>* 169.254.95.132/30 is directly connected, vti1, 00:02:15
C>* 169.254.116.232/30 is directly connected, vti0, 00:02:15
```

```sh
$ show ip bgp
BGP table version is 2, local router ID is 10.1.1.226, vrf id 0
Default local pref 100, local AS 65000
Status codes:  s suppressed, d damped, h history, * valid, > best, = multipath,
               i internal, r RIB-failure, S Stale, R Removed
Nexthop codes: @NNN nexthop's vrf id, < announce-nh-self
Origin codes:  i - IGP, e - EGP, ? - incomplete

   Network          Next Hop            Metric LocPrf Weight Path
*> 10.0.0.0/16      169.254.95.133         100             0 64512 i
*                   169.254.116.233        200             0 64512 i
*> 10.1.0.0/16      0.0.0.0                  0         32768 i
```

```sh
$          show interfaces
Codes: S - State, L - Link, u - Up, D - Down, A - Admin Down
Interface        IP Address                        S/L  Description
---------        ----------                        ---  -----------
eth0             10.1.1.226/24                     u/u  
lo               127.0.0.1/8                       u/u  
                 ::1/128                                
vti0             169.254.116.234/30                u/u  VPC tunnel 1
vti1             169.254.95.134/30                 u/u  VPC tunnel 2
```

other: https://gist.github.com/knknkn1162/7ea0057c370646ee87f503ea3e072fed

## log

```sh
show log vpn ipsec
```

## url

+ [Vyatta(VyOS) IPsec設定 基礎編](https://changineer.info/network/vyatta/vyatta_ipsec_normal.html)
+ [Vyatta(VyOS) IPsec設定 AWS編](https://changineer.info/network/vyatta/vyatta_ipsec_aws.html)
+ [automation](https://docs.vyos.io/en/equuleus/automation/index.html)
+ [設定](https://zenn.dev/daimatsu/articles/b10dae9d2b27f2)
+ [cheetsheet](https://bertvv.github.io/cheat-sheets/VyOS.html)