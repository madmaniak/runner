module Runner
  module SSH
    class Base
      def initialize(host, user)
        @ssh = Net::SSH.start(host, user)
      end
    end
  end
end
