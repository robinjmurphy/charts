require 'spec_helper'

module Charts
    describe Chart do

        before do
            VCR.insert_cassette 'chart', :record => :new_episodes
        end

        after do
            VCR.eject_cassette
        end

        let :default_chart do
            Chart.default
        end

        it 'is initialized with the correct properties' do
            chart_data = Mock.new.chart_data
            chart = Chart.new chart_data
            chart.name.should eq 'UK Singles Chart'
            chart.type.should eq 'Singles'
            chart.date.should eq '12-12-12'
            (chart.entries.instance_of? Array).should be true
            (chart.entries[0].instance_of? Entry).should eq true
        end

        it 'can create a chart from a given path' do
            singles_chart = Chart.find_by_path 'radio1/chart/singles'
            (singles_chart.instance_of? Chart).should eq true
            singles_chart.name.should eq 'The Official UK Top 40 Singles Chart'
            singles_chart.entries.length.should eq 40
        end

        it 'raises an exception for a chart that cannot be found' do
            expect { Chart.find_by_path('/radio1/chart/foo') }.to raise_error Exceptions::ResourceNotFound
        end
        
    end
end