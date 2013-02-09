module Charts
    describe Charts::Url do

        before do
            VCR.insert_cassette 'url', :record => :new_episodes
        end

        after do
            VCR.eject_cassette
        end

        it 'returns the correct URL for a given chart path' do
            albums_path = 'radio1/chart/albums'
            albums_url = Url.new.from_path albums_path
            albums_url.should eq 'http://www.bbc.co.uk/radio1/chart/albums.json'
        end

        it 'can retrieve an MP3 URL from an XML playlist' do
            playlist_url = 'http://www.bbc.co.uk/radio1/chart/snippets/22567.xml'
            mp3_url = Url.new.mp3_from_playlist playlist_url
            mp3_url.should eq 'http://downloads.bbc.co.uk/radio1/chart/snippets/isrc/noisrc_psy_gangnamstyle.mp3'
        end

        it 'raises an exception for an XML playlist that cannot be found' do
            playlist_url = 'http://www.bbc.co.uk/radio1/chart/snippets/bar.xml'
            expect { Url.new.mp3_from_playlist playlist_url }.to raise_error Exceptions::PlaylistNotFound
        end

    end
end