var uri = "";
var currentRequest;
var currentlyPlayingSong;

(function() {
    getCurrentlyPlayingSong();
    currentlyPlayingSong = setInterval(getCurrentlyPlayingSong, 10000);
})();

function getCurrentlyPlayingSong() {
    $.ajax({
        url: "/spotify/hostsCurrentSong",
        data: { "pin": getPin() }
    })
    .done(function(res) {
        let data = JSON.parse(res);
        console.log(data);
        if (data.success) {
            if (data.status == 204) {
            } else {
                $("#playingTrack")[0].innerHTML = '';
                $("#playingTrack").append("<div class=\"info\"><div class=\"text\">"+data.data.item.name+"</div><div class=\"text artist\">"+data.data.item.artists[0].name+"</div></div>");

                let length = data.data.item.duration_ms;
                let current = data.data.progress_ms;
                let progress = ((current / length) * 100) + "%";
                $("#progress").width(progress);
            }
        }
    });
}

function resultsScroll() {
    let el = $(this);

    if (el.innerHeight() + el.scrollTop() >= this.scrollHeight - 5) {
        songSearch(true);
    }
}

function addSong() {
    uri = $(this).attr("data-uri");
    $('[data-uri="'+ uri +'"]').children('span').hide();
    $('[data-uri="'+ uri +'"]').children('.fa-spinner').removeClass('hidden');

    $.ajax({
        url: "/spotify/addSong",
        data: { "uri": uri, "pin": getPin() }
    })
    .done(function(res) {
        let data = JSON.parse(res);

        if (data.success) {
            $('[data-uri="'+ uri +'"]').children('.fa-spinner').addClass('hidden');
            $('[data-uri="'+ uri +'"]').children('.fa-check').removeClass('hidden');
            uri = "";
        } else if (data.message === "No active device found.") {
            $("#errorModal").removeClass('hidden');
            $("#errorModal .text").text("It looks like there is no current playlist / song playing on a device signed into your hosts account. Please start playing a song and try again.");
        }
    });
}

function songSearch(requestMore) {
    let searchString = $("#searchInput").val().trim();
    let offset = $('#searchResultsWrapper').children().length || 0;

    if (searchString === "") {
        $("#searchResultsWrapper")[0].innerHTML = '';
        return;
    }

    currentRequest = $.ajax({
    beforeSend: function() {
        if (currentRequest != null) {
            currentRequest.abort();
        }
    },
    url: "/spotify/search",
        data: { "query": searchString, "pin": getPin(), "offset": offset }
    })
    .done(function(res) {
        let data = JSON.parse(res);
        populateSearchResults(data, requestMore);
    });
}

function searchArtist(id) {
    $.ajax({
        url: "/spotify/searchArtist",
        data: { "id": id, "pin": getPin() }
    })
    .done(function(res) {
        let data = JSON.parse(res);
        populateSearchResults(data, false);
    });
}

function populateSearchResults(data, append) {
    if (!append) {
        $("#searchResultsWrapper")[0].innerHTML = '';
    }

    if (data.success) {
        $.each(data.data, function () {
            let track = this.name;
            let artist = this.artists[0].name;
            let uri = this.uri;
            let newResult = "<div class=\"song-wrapper\"><div><img class=\"album-icon\" src=\"" + this.album.images[1].url + "\"/></div><div class=\"info\"><div class=\"text\">"+track+"</div><div class=\"text artist\" onclick=searchArtist(\""+ this.artists[0].id +"\")>"+artist+"</div></div><div onclick=\"addSong.call(this)\" data-uri=\""+uri+"\"  class=\"button small\"><i class=\"fas fa-spinner fa-spin hidden\"></i><i class=\"hidden fas fa-check\"></i><span>Add<span></div></div>";
            $("#searchResultsWrapper").append(newResult);
        });
    }
}

function errorButtonClick() {
    $('[data-uri="'+ uri +'"]').children('.fa-spinner').addClass('hidden');
    $('[data-uri="'+ uri +'"]').children('.fa-check').addClass('hidden');
    $('[data-uri="'+ uri +'"]').children('span').show();
    $('#errorModal').addClass('hidden');
}