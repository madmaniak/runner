module Runner
  module CloudFormation
    class Rowlfbox < Base
      private

      def name
        "rowlf-minirun-#{DateTime.now.strftime("%d-%m-%Y")}-#{hex}"
      end

      def parameters
        {
          "AppChefRunList" => "role[rowlf]",
          "AppIamProfile"  => "default",
          "AppImageId"     => "ami-2f8f9246",
          "AppInstanceType" => "m1.large",
          "AppName"         => name,
          "AppRubyVersion"  => "2.1",
          "AppSubnet"       => "subnet-85bb9ee8",
          "ChefVersion"     =>  "11.12.8",
          "EnvironmentName" =>  "rowlf",
          "RowlfExtraEnv"   => "default"
        }
      end

      def template
        raise "No rowlf.json file provided." unless File.exists?(file)
        File.read(file)
      end

      def file
        File.absolute_path("templates/rowlf.json")
      end
    end
  end
end
