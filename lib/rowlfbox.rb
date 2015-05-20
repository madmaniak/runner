module Runner
  class Rowlfbox
    def initialize
      @cf = ::AWS::CloudFormation.new(access_key_id:     ENV['AWS_ACCESS_KEY_ID'], 
                                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                      session_token:     ENV['AWS_SESSION_TOKEN'])
    end

    def create
      @cf.stacks.create(name, template, { parameters: parameters })
    end

    private

    def name
      "rowlf-minirun-#{DateTime.now.strftime("%d-%m-%Y")}"
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
        "ChefVersion"     =>  "11.28.8",
        "EnvironmentName" =>  "rowlf",
        "RowlfExtraEnv"   => "default"
      }
    end

    def template
      raise "No rowlf.json file provided." unless File.exists?(File.absolute_path("templates/rowlf.json"))
      File.read(File.absolute_path("templates/rowlf.json"))
    end
  end
end