module Charts
    class Url
        BASE_URL = 'http://www.bbc.co.uk'
        FILE_EXTENSION = '.json'

        def from_path path
            BASE_URL + '/' + path + FILE_EXTENSION
        end
    end
end