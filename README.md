# Charts

Charts is a mobile web application that lets you explore UK music charts. It uses chart data provied by the [BBC Radio 1 Developers API](http://www.bbc.co.uk/radio1/developers/api/), although it is in no way affiliated with or endorsed by the BBC.

I'm using it as a bit of an experiment to create a mobile app using web technologies. It is designed to be added to the homescreen in *iOS* and run as a full screen app, although it will work just fine in any *WebKit*-based browser.

Tapping on an entry in a chart lets you listen to a thirty second clip of the song if your browser supports MP3 audio.

A version of Charts is hosted at [charts.robinmurphy.co.uk](http://charts.robinmurphy.co.uk/) if you want to try it out.

## Getting it up and running

Install the necessary requirements using [Bundler](http://gembundler.com/):

```bash
   bundle install
```

Run the application as you would any [Sinatra](http://www.sinatrarb.com/) app:

```bash
   ./app.rb
```

Head to [http://localhost:4567/](http://localhost:4567/) in your web browser.

You can explore any BBC chart by using its path from the BBC website. For example, the [Rock Singles Chart](http://www.bbc.co.uk/radio1/chart/rocksingles) has a path `radio1/chart/rocksingles` and can be found at [http://localhost:4567/charts/radio1/chart/rocksingles](http://localhost:4567/charts/radio1/chart/rocksingles).

## Screenshots

![The Charts app running from the homescreen in iOS](http://charts.robinmurphy.co.uk/screenshots/landscape.png)