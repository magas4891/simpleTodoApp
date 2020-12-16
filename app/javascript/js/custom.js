$(document).on("click", ("input[data-project]"), function(event){
    event.preventDefault();
    console.log($(this));
    const project_id = $(this).first().data("project");
    const project_input = $(`li#project-${project_id} input#project_name`);
    const project_input_value = project_input.val();

    if (project_input.attr("disabled")) {
        project_input.attr("disabled", false);
    } else {
        project_input.attr("disabled", true);
        sendAjax($(this).parents('form').attr('action'), 'project', 'name', project_input_value);
    }
});

$(document).on("click", ("input[data-task]"), function(event){
    event.preventDefault();
    const task_id = $(this).first().data("task");
    const action = $(this).parents('form').attr('action');
    const task_input = $(`li#task-${task_id} input#task_description`);
    const task_input_value = task_input.val();

    if (task_input.attr("disabled")) {
        task_input.attr("disabled", false);
    } else {
        task_input.attr("disabled", true);
        sendAjax(action, 'task', 'description', task_input_value);
    }
});

$(document).on("change", ("input:checkbox"), function(event){
    event.preventDefault();
    const action = $(this).closest("form").attr("action");
    const field = $(this).next();
    const value = $(this).is(':checked');

    sendAjax(action, 'task', 'done', value);
});

$( window ).on("load", function() {
    $("input:checkbox").each(function () {
        if ($(this).is(":checked")) {
            $(this).next().addClass("border-success");
        } else {
            $(this).next().removeClass("border-success");
        }
    })
})

function sendAjax(action, mod, field, value) {
    $.ajax({
        url: action,
        type: "PATCH",
        data: {
            [mod]: { [field]: value }
        },
        success: function(data) { $("ul#projects").html(data.html) }
    })
}