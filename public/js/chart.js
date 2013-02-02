(function (document, $) {
    var app = {
            menu: $('.app-nav'),
            menuItems: $('.app-nav a'),
            menuIcon: $('.app-more-icon'),
            body: $('.app-body'),
            header: $('.app-header'),
            wrapper: $('.app-wrapper'),
    },
    entries = {
        active: {
            node: null,     // The active entry node
            audio: null,    // The active <audio> node
            ajax: null,     // The active AJAX call
        } 
    };

    function bindAppEvents() {
        app.menuIcon.bind('click', function () {
            toggleMenu();

            return false;
        });
    }

    function bindNavEvents() {
        app.menuItems.bind('click', function () {
            var href = $(this).attr('href'),
                name = $(this).html(),
                path = $(this).attr('data-path');

            goToChart(name, href, path);
            closeMenu();

            return false;
        });
    }

    function bindPushState() {
        window.onpopstate = function (event) {
            if (event.state) {
                loadEntries(event.state['path'], event.state['name']);
            }
        }
    }

    function goToChart(name, href, path) {
        loadEntries(path, name);
        window.history.pushState({'path': path, 'name': name}, name, href);
    }

    function loadEntries(path, name) {
        var url = '/entries/' + path;

        if (entries.active.ajax) {
            entries.active.ajax.abort();
        }

        app.wrapper.addClass('loading');

        entries.active.ajax = $.get(url, function (data) {
            app.body.html(data);
            $('h1', app.header).html(name);
            $('title').html(name);
            bindChartEvents();
            app.wrapper.removeClass('loading');
        });
    }

    function bindChartEvents() {
        $('.chart-entry').bind('click', function () {
            var entry = this;
            
            toggleEntry(entry);

            return false;
        });
    }

    function toggleMenu() {
        if (app.menu[0].offsetHeight == 0) {
            openMenu();
        }
        else {
            closeMenu();
        }
    }

    function openMenu() {
        var height_to_animate_to = $('nav', app.menu)[0].offsetHeight;
        
        app.menuIcon.addClass('active');
        app.menu.css({'height' : height_to_animate_to + 'px'});
    }

    function closeMenu() {
        app.menuIcon.removeClass('active');
        app.menu.css({'height' : '0'});
    }

    function toggleEntry(entry) {
        if (entries.active.node === entry) {
            closeEntry(entry);
        }
        else {
            openEntry(entry);
        }
    }

    function openEntry(entry) {
        var previously_active_entry = entries.active.node;

        entries.active.node = entry;

        if (previously_active_entry) {
            $('.position', previously_active_entry).html(
                $(previously_active_entry).attr('data-position')
            );
        }

        if (entries.active.audio) {
            entries.active.audio.pause();
        }

        $('.chart-entry').removeClass('active');
        $(entry).addClass('active');
        load_sound(entry);
    }

    function closeEntry(entry) {
        entries.active.node = null;

        if (entries.active.audio) {
            entries.active.audio.pause();
            entries.active.audio = null;
        }

        $('.chart-entry').removeClass('active');
        $('.position', entry).html($(entry).attr('data-position'));
    }

    function load_sound(entry) {
        var playlist = $(entry).attr('data-playlist'),
            mp3_url = $(entry).attr('data-mp3-url');

        function get_audio_node(src) {
            var audio_node = $('audio', entry);

            if (audio_node[0]) {
                audio_node = audio_node[0];
            }
            else {
                audio_node = create_audio_node(src);
            }

            return audio_node;
        }

        function create_audio_node (src) {
            audio_node = document.createElement('audio');
            audio_node.src = src;
            entry.appendChild(audio_node);

            return audio_node;
        }

        if (mp3_url) {
            entries.active.audio = get_audio_node(mp3_url);
            play_sound();
        }
        else if (playlist) {   
            // Need to grab the MP3 URL from the playlist file         
            $.post('/read_playlist', {playlist: playlist}, function (data) {
                data = JSON.parse(data);
                $(entry).attr('data-mp3-url', data['mp3_url']);
                entries.active.audio = get_audio_node(data['mp3_url']);
                play_sound();
            });
        }

        function play_sound() {
            entries.active.audio.play();
            $('.position', entry).html('&#9654;');  // Play icon
        }
    }

    $(document).ready(function () {
        bindAppEvents();
        bindNavEvents();
        bindChartEvents();
        bindPushState();
    });
})(document, jQuery);
