function playbackSelectChange() {
    $.ajax({
        url: "/spotify/hostsPlaylists",
        data: { "pin": getPin() }
    })
    .done(function(res) {
        let data = JSON.parse(res);
        
        $("#playbackModal").removeClass("hidden");
    });
}

function closeModal(id) {
    $("#playbackSelect").val("queue");
    $("#" + id).addClass("hidden");
}