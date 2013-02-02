require 'json'
require 'charts/url'
require 'charts/http'

module Charts
    class Chart
        attr_accessor :path, :name, :date, :type, :entries

        class << self
            def find_by_path path
                url = Url.new.from_path path
                response = Http.get url
                data = JSON.load(response.to_str)
                self.new data['chart']
            end
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
