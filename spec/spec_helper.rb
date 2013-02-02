require 'rspec'
require 'vcr'
require 'webmock'
require 'charts'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/'
  c.hook_into :webmock
end

class Mock
    def chart_data
        {
            'name' => 'UK Singles Chart',
            'type' => 'Singles',
            'date' => '12-12-12',
            'entries' => [
                entry_data
            ]
        }
    end

    def entry_data
        {
            'title' => 'Gagnam Style',
            'position' => '1',
            'lastweek' => '1',
            'weeksinchart' => '5',
            'label' => 'test_label',
            'catno' => '1234',
            'image' => 'psy.png',
            'playlist' => 'something.xml',
            'status' => 'non-mover',
            'gid' => 'f99b7d67-4e63-4678-aa66-4c6ac0f7d24a',
            'artist' => 'PSY'
        }
    end
    
    def sample_artist_data
        {
            'name' => 'PSY',
            'type' => 'Person',
            'begin_date' => '1977-12-31',
            'gid' => 'f99b7d67-4e63-4678-aa66-4c6ac0f7d24a'
        }
    end
end