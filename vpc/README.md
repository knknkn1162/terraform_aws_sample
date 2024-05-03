+ aws_route
  + carrier_gateway_id - (Optional) Identifier of a carrier gateway. This attribute can only be used when the VPC contains a subnet which is associated with a Wavelength Zone.
    + AWS Wavelengthのサービスで使う
  + core_network_arn - (Optional) The Amazon Resource Name (ARN) of a core network.
  + egress_only_gateway_id - (Optional) Identifier of a VPC Egress Only Internet Gateway.
    + IPv6を使用してインターネットに出たいときに使用するもの。
  + gateway_id - (Optional) Identifier of a VPC internet gateway or a virtual private gateway. Specify local when updating a previously imported local route.
    + [ok] igw
    + virtual private gateway
      + Site-to-Site VPN接続の通信相手となるオンプレミス環境側にはカスタマーゲートウェイをアタッチします。
  + [ok] nat_gateway_id - (Optional) Identifier of a VPC NAT gateway.
  + local_gateway_id - (Optional) Identifier of a Outpost local gateway.
    + AWS Outpostsで使用?
  + network_interface_id - (Optional) Identifier of an EC2 network interface.
  + transit_gateway_id - (Optional) Identifier of an EC2 Transit Gateway.
    + 複数のコネクションをまとめる
  + [ok] vpc_endpoint_id - (Optional) Identifier of a VPC Endpoint.
  + [ok] vpc_peering_connection_id - (Optional) Identifier of a VPC peering connection.