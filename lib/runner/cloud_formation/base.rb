module Runner
  module CloudFormation
    class Base
      def initialize
        @cf = ::AWS::CloudFormation.new(access_key_id:     ENV['AWS_ACCESS_KEY_ID'], 
                                        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                        session_token:     ENV['AWS_SESSION_TOKEN'])
      end

      def create
        @cf.stacks.create(name, template, { parameters: parameters })
      end

      private

      def hex
        @hex ||= SecureRandom.hex(8)
      end
    end
  end
end