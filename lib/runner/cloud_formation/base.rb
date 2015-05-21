module Runner
  module CloudFormation
    class Base
      def initialize
        @cf = ::AWS::CloudFormation.new
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
