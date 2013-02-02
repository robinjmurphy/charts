require 'xmlsimple'
require 'charts/http'
require 'charts/exceptions'

module Charts
    class Url
        BASE_URL = 'http://www.bbc.co.uk'
        FILE_EXTENSION = '.json'

        def from_path path
            BASE_URL + '/' + path + FILE_EXTENSION
        end

        def mp3_from_playlist url
            begin
                response = Http.get url
            rescue Exceptions::ResourceNotFound
                raise Exceptions::PlaylistNotFound.new("There was no XML playlist found at #{url}")
            end
            data = XmlSimple.xml_in response
            mp3_url = data['item'][0]['media'][0]['connection'][0]['href']
        end

    end
end