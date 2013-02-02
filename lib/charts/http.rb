require 'rest-client'
require 'charts/exceptions'
module Charts
    class Http
        def self.get url
            begin
                response = RestClient.get url
            rescue RestClient::ResourceNotFound
                raise Exceptions::ResourceNotFound
            end
        end
    end
end