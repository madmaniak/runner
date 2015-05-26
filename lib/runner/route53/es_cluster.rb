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

      private

      def record
        @record ||= hosted_zone.resource_record_sets.find { |r| r.name == "index-minirun.elasticsearch.lonelyplanet.com." }
      end

      def hosted_zone
        @hosted_zone ||= r53.hosted_zones.find { |zone| zone.name == "lonelyplanet.com." }
      end

      def resource_records
        [ { value: @cluster_name } ]
      end
    end
  end
end
