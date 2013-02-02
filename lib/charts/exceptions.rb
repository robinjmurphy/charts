module Charts
    class Exceptions

        class ResourceNotFound < Exception; end

        class ChartNotFound < ResourceNotFound; end

        class PlaylistNotFound < ResourceNotFound; end
        
    end
end