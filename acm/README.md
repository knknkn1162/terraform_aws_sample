+ certificate_arn
  + [ALB] aws_lb_listener_certificate.certificate_arn
    + aws_lb_listener.certificate_arnでも指定可能
  + [Cloudfront] aws_cloudfront_distribution.viewer_certificate.acm_certificate_arn
  + [cgw] aws_customer_gateway.certificate_arn
  + [API gateway] aws_api_gateway_domain_name.(certificate_arn|regional_certificate_arn)
  + [API gateway v2] aws_apigatewayv2_domain_name.domain_name_configuration.certificate_arn
  + [Cognito] aws_cognito_user_pool_domain.certificate_arn
  + [VPN endpoint] aws_ec2_client_vpn_endpoint.certificate_arn
  + [RedShift] aws_redshiftserverless_custom_domain_association.custom_domain_certificate_arn
  + [DMS S3 endpoint] aws_dms_s3_endpoint.certificate_arn
  + [Elastic Search] aws_elasticsearch_domain.custom_endpoint_certificate_arn
  + [VPN connection] vgw_telemetry.certificate_arn