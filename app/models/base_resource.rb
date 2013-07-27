class BaseResource < ActiveResource::Base
  DOCKER_URL='192.168.0.152'
  API_URL="http://#{DOCKER_URL}:4243/v1.3/"
  self.site = API_URL

  def self.element_path(id, prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    "#{prefix(prefix_options)}#{collection_name}/#{URI.escape id.to_s}/json#{query_string(query_options)}"
  end

  def self.collection_path(prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    "#{prefix(prefix_options)}#{collection_name}/json#{query_string(query_options)}?all=1"
  end

  def self.recent
    all.last(5).sort_by do |item|
      item.attributes["Created"]
    end.reverse
  end

  def load(attributes, remove_root = false, persisted = false)
    raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
    @prefix_options, attributes = split_options(attributes)

    if attributes.keys.size == 1
      remove_root = self.class.element_name == attributes.keys.first.to_s
    end

    attributes = Formats.remove_root(attributes) if remove_root

    attributes.each do |key, value|
      key = key.to_s.downcase.to_sym
      @attributes[key.to_s] =
        case value
        when Array
          resource = nil
          value.map do |attrs|
            if attrs.is_a?(Hash)
              resource ||= find_or_create_resource_for_collection(key)
              resource.new(attrs, persisted)
            else
              attrs.duplicable? ? attrs.dup : attrs
            end
          end
        when Hash
          key = key.to_s.gsub("config","configuration").to_sym
          resource = find_or_create_resource_for(key)
          resource.new(value, persisted)
        else
          value.duplicable? ? value.dup : value
        end
    end
    self
  end


end
