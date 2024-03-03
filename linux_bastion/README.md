# linux vm

+ using session manager

## When SSM Agent is not online
The SSM Agent was unable to connect to a Systems Manager endpoint to register itself with the service.

Verify that the IAM instance profile has the correct permissions. -> https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
Verify that your instance's security group and VPC allow HTTPS (port 443) outbound traffic to the following Systems Manager endpoints:
ssm.ap-northeast-1.amazonaws.com
ec2messages.ap-northeast-1.amazonaws.com
ssmmessages.ap-northeast-1.amazonaws.com
If your VPC does not have internet access, you can use VPC endpoints  to allow outbound traffic from your instance.