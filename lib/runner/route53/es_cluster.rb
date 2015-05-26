module Runner
  module Route53
    class EsCluster
      def initialize(name)
        @cluster_name = name
        @r53          = AWS::Route53.new 
      end

      def assign_index_to_new_cluster
        record.resource_records = resource_records
      end

      def set_index_writable
        req = Typhoeus::Request.new(
          url,
          method: :put,
          body: { "index" => { "blocks" => { "read_only" => false } } }
        )
        req.run
      end

      def set_number_of_replicas
        req = Typhoeus::Request.new(
          url,
          method: :put,
          body: { "index" => { "number_of_replicas" => 2 } }
        )
        res = req.run
        raise "Number of replicas couldn't be set." unless res.success?
      end

      private

      def record
        @record ||= hosted_zone.resource_record_sets.find { |r| r.name == "index-minirun.elasticsearch.lonelyplanet.com." }
      end

      def hosted_zone
        @hosted_zone ||= @r53.hosted_zones.find { |zone| zone.name == "lonelyplanet.com." }
      end

      def resource_records
        [ { value: @cluster_name } ]
      end

      def url
        "index-minirun.elasticsearch.lonelyplanet.com:9200/_settings"
      end
    end
  end
end
