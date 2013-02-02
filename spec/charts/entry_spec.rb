require 'spec_helper'

describe Charts::Entry do

    Entry = Charts::Entry

    before do
        VCR.insert_cassette 'entry', :record => :new_episodes
    end

    after do
        VCR.eject_cassette
    end

    let :default_chart do
        Chart.default
    end

    it 'is initialized with the correct properties' do
        entry_data = Mock.new.entry_data
        entry = Entry.new entry_data
        entry.title.should eq 'Gagnam Style'
        entry.artist['name'].should eq 'PSY'
        entry.artist['gid'].should eq 'f99b7d67-4e63-4678-aa66-4c6ac0f7d24a'
    end
    
end