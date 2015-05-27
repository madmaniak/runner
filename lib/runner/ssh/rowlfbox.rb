module Runner
  module SSH
    class Rowlfbox
      def initialize(host, user)
        @ssh = Net::SSH.start(host, user)
      end

      def create_tmux_session
        @ssh.exec!("sudo -u deploy tmux new -s $USER-rowlf-run-$(date '+%y%m%d')")
      end

      def env_file_has_hosts?
        output = @ssh.exec!("sudo less /etc/rowlf/env")
        unless output.include?(es_host) && output.include?(database_host)
          raise ".env file does not include either ES_HOST or DATABASE_HOST. Please sign in to #{@ssh.host} and edit it manually."
        end

        true
      end

      private

      def es_host
        "ES_HOST=index-minirun.elasticsearch.lonelyplanet.com"
      end

      def database_host
        "DATABASE_HOST=canary.rowlf.pg.lonelyplanet.com"
      end
    end
  end
end
