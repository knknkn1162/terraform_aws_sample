resource "aws_resourcegroups_group" "example" {
  name = "0"
  resource_query {
    type = "TAG_FILTERS_1_0"
    query = <<-JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "group",
      "Values": ["0"]
    }
  ]
}
JSON
  }
}

resource "aws_resourcegroups_resource" "ex1" {
  group_arn    = aws_resourcegroups_group.example.arn
  resource_arn = module.vpc.arn
}

resource "aws_resourcegroups_resource" "ex2" {
  group_arn    = aws_resourcegroups_group.example.arn
  resource_arn = module.subnet4vm.arn
}