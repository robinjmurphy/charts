require 'json'
require 'charts/url'
require 'charts/http'
require 'charts/exceptions'

module Charts
    class Chart
        attr_accessor :path, :name, :date, :type, :entries

        def self.find_by_path path
            url = Url.new.from_path path
            begin
                response = Http.get url
            rescue Exceptions::ResourceNotFound
                raise Exceptions::ChartNotFound.new("There was no chart data found at #{url}")
            end
            data = JSON.load response.to_str
            self.new data['chart']
        end

        def initialize options
            @name = options["name"]
            @date = options["date"]
            @type = options["type"]
            @entries = []
            load_entries options["entries"]
        end

        private
        def load_entries entries
            @entries = entries.map do |entry|
                Entry.new entry
            end
        end
    end
end
