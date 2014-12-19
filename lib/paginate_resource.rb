require "paginate_resource/version"

module PaginateResource
  module Controllers
    module Helpers
      extend ActiveSupport::Concern
      
      included do
        helper_method  :next_resource, :prev_resource
      end

      private

      def next_resource(rotate=false)
        if collection.arel.orders.present?
          order_column = collection.arel.orders.first.split(" ").first
          @next_resource ||= collection.where("#{resource.class.table_name}.#{order_column} > ?", resource.send(order_column)).first
        else
          @next_resource ||= collection.where("#{resource.class.table_name}.#{resource.class.primary_key} > ?", resource.id).order("#{resource.class.table_name}.#{resource.class.primary_key} ASC").first      
        end
        @next_resource ||= collection.first if  rotate == true #rotate back to the first item
        @next_resource
      end

      def prev_resource
        if collection.arel.orders.present?
          order_column = collection.arel.orders.first.split(" ").first
          @prev_resource ||= collection.where("#{resource.class.table_name}.#{order_column} < ?", resource.send(order_column)).last
        else
          @prev_resource ||= collection.where("#{resource.class.table_name}.#{resource.class.primary_key} < ?", resource.id).order("#{resource.class.table_name}.#{resource.class.primary_key} DESC").first
        end
      end
      
      def collection
        resource.class.all
      end
      
    end
  end
end

class ActionController::Base
  def self.paginate_resource
    include PaginateResource::Controllers::Helpers
  end
end