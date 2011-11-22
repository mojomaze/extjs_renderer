module ExtjsRenderer
  require "action_controller"

  ActionController::Renderers.add :extjs do |resource, options|
    if resource.is_a?(ActiveRecord::Relation)
      # get or set the total
      if options && options.has_key?(:total)
        total = options[:total]  # set if passed
      elsif resource.respond_to?(:total_count)
        total = resource.total_count # kaminari total found
      elsif resource.respond_to?(:total_entries)
        total = resource.total_entries # will_paginate total found
      else
        total = resource.size # total in relation
      end

      # set root to passed or resource
      root = options && options.has_key?(:root) ? options[:root] : resource.last.class.name.downcase

      json = '{"total":'+total.to_s+',"'+root+'":'+resource.to_json(options)+'}'
    
    else
      # set root to passed or 'data' which is used by extjs to load forms
      root = options && options.has_key?(:root) ? options[:root] : 'data'

      json = '{"success":true,"'+root+'":'+resource.to_json(options)+'}'
    end

    send_data(json, :type => :json)
  end
end