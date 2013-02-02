module Charts
    class Entry
        attr_accessor   :title,
                        :position,
                        :lastweek,
                        :weeksinchart,
                        :artist,
                        :label,
                        :catno,
                        :image,
                        :status,
                        :playlist

        def initialize options
            @title = options['title']
            @position = options['position']
            @lastweek = options['lastweek']
            @weeksinchart = options['weeksinchart']
            @label = options['label']
            @catno = options['catno']
            @image = options['image']
            @playlist = options['playlist']
            @status = options['status']
            @artist = {'gid'=> options['gid'], 'name' => options['artist']}
        end
    end
end