function playbackSelectChange() {
    $.ajax({
        url: "/spotify/hostsPlaylists",
        data: { "pin": getPin() }
    })
    .done(function(res) {
        let data = JSON.parse(res);

        $.each(data.data, function () {
            let name = this.name;
            let id = this.id;
            let uri = this.uri;
            let newResult = "<div id=\"" + id + "\" class=\"song-wrapper\" onclick=\"selectPlaylist();\"><div><img class=\"album-icon\" src=\"" + this.images[0].url + "\"/></div><div style=\"width:100%\" class=\"info flex center between\"><div class=\"text\">"+name+"</div><i class=\"fas fa-check-circle\"></i></div>";
            $("#playbackModal .content").append(newResult);
        });

        $("#playbackModal").removeClass("hidden");
    });
}

function selectPlaylist() {
    $(".song-wrapper").removeClass("selected");
    $(event.target).closest(".song-wrapper").addClass("selected");
}

function closeModal(id) {
    $("#playbackSelect").val("queue");
    $("#" + id).addClass("hidden");
}

function createPlaylist() {
    let name = $("#playlistName").val().trim();

    if (name == "") {
        return;
    }

    $.ajax({
        url: "/spotify/createPlaylist",
        data: { 
            "pin": getPin(), 
            "name": name 
        }
    })
    .done(function(res) {
        let data = JSON.parse(res);
        $("#playbackModal").removeClass("hidden");
    });  
}