module Runner
  module SSH
    class Zoot < Base
      # Logs can be viewed at /var/log/rowlf/elasticsearch.log
      def run_zoot_jobs
        @ssh.exec!("cd /opt/apps/rowlf")
        @ssh.exec!("export ENV_PATH=/etc/rowlf/env")
        @ssh.exec!("export ROWLF_ENV=production")
        @ssh.exec!("alias zrun='bundle exec zoot jobs:run'")
        @ssh.exec!("zrun minirun")
      end
    end
  end
end
