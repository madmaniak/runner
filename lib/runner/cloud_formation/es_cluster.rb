module Runner
  module CloudFormation
    class EsCluster < Base
      private

      def name
        "es-cluster-#{DateTime.now.strftime("%d-%m-%Y")}-#{hex}"
      end

      def parameters
        {
          "AppAvailabilityZones" => "us-east-1a,us-east-1e,us-east-1d",
          "AppChefRunList"  => "role[elasticsearch_cluster_aws_cloudformation]",
          "AppDesiredCapacity" => "3",
          "AppIamProfile" => "default",
          "AppImageId" => "ami-6f969506",
          "AppInstanceType" => "c3.4xlarge",
          "AppMaxSize" => "12",
          "AppMinSize" => "3",
          "AppNameTag" => name,
          "AppRubyVersion" => "1.9",
          "AppSubnets" => "subnet-ecbb9e81,subnet-035b2d2b,subnet-85bb9ee8",
          "ChefVersion" => "11.12.8",
          "ClusterName" => name,
          "ELBDNSPrefix" => name,
          "ElbSecurityGroup" => "sg-1cdb2473",
          "ELBSubnets" => "subnet-ecbb9e81,subnet-035b2d2b,subnet-85bb9ee8",
          "ELBTTL" => "60",
          "EnvironmentName" => "Production",
          "ExpectedNodes" => "2",
          "HostedZoneName" => "lonelyplanet.com.",
          "KeyName" => "admin",
          "SecurityGroup" => "sg-d42ae7b1",
          "VpcId" => "vpc-a7be9bca"
        }
      end

      def template
        raise "No elasticsearch-for-dotcom.json file provided." unless File.exists?(file)
        File.read(file)
      end

      def file
        File.absolute_path("templates/elasticsearch-for-dotcom.json")
      end
    end
  end
end
