module Runner
  module SSH
    class EsCluster
      def initialize(host, user)
        @ssh = Net::SSH.start(host, user)
        @s3  = AWS::S3.new
      end

      def restore_es_index_from_backup
        download_backup
        unzip_and_copy_backup
      end

      private

      def unzip_and_copy_backup
        @ssh.exec!("sudo service elasticsearch stop")
        @ssh.exec!("sudo su - elasticsearch")
        @ssh.exec!("cp /tmp/es-cluster-#{timestamp}.tar.gz /mnt")
        @ssh.exec!("tar -zxvf es-cluster-#{timestamp}.tar.gz")
        @ssh.exec!("mv es-cluster-#{timestamp} es-cluster-#{DateTime.now.strftime("%d-%m-%Y")}")
        @ssh.exec!("exit")
        @ssh.exec!("sudo service elasticsearch start && tail -f /var/log/elasticsearch/*.log | grep indices")
      end

      def download_backup
        s3  = AWS::S3::Client.new
        s3.get_object({ bucket_name: 'elasticsearch.current.backup', key: key }, target: "/tmp")
      end

      def key
        @key ||= @s3.buckets["elasticsearch.current.backup"].objects.max_by { |o| o.last_modified }.key
      end

      def timestamp
        key.split("-").last.split(".").first
      end
    end
  end
end
