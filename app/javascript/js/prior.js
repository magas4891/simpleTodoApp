$(document).on("click", ".up", function(event) {
    event.preventDefault();
    const currentPosition = $(this).data("position");
    const project = $(this).data("project");
    let nextPosition;
    if (currentPosition !== 0) {
        nextPosition = currentPosition - 1;
    } else {
        return;
    }
    const nextElement = $(".up[data-project=" + project + "][data-position=" + nextPosition + "]");
    const action = $(this).closest("form").attr("action");
    const action2 = nextElement.closest("form").attr("action");
    sendAjax(action, "task", "position", nextPosition)
    sendAjax(action2, "task", "position", currentPosition)
});

$(document).on("click", ".down", function(event) {
    event.preventDefault();
    const currentPosition = $(this).data("position");
    const project = $(this).data("project");
    const btnSelector = $(".down[data-project=" + project + "]");
    let nextPosition;
    if (currentPosition !== (btnSelector.length - 1)) {
        nextPosition = currentPosition + 1;
    } else {
        return;
    }
    const nextElement = $(".up[data-project=" + project + "][data-position=" + nextPosition + "]");
    const action = $(this).closest("form").attr("action");
    const action2 = nextElement.closest("form").attr("action");
    sendAjax(action, "task", "position", nextPosition)
    sendAjax(action2, "task", "position", currentPosition)
});

function sendAjax(action, mod, field, value) {
    $.ajax({
        url: action,
        type: "PATCH",
        data: {
            [mod]: { [field]: value }
        },
        success: function(data) { $("#tasks-section").html(data.html) }
        // success: function(data) { $("ul#projects").html(data.html) }
    })
}