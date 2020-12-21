// editing project
$(document).on("click", ("input[data-project]"), function(event){
    event.preventDefault();
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

// editing task
$(document).on("click", ("input[data-task]"), function(event){
    event.preventDefault();
    const task_id = $(this).first().data("task");
    const action = $(this).parents('form').attr('action');
    const task_input = $(`li#task-${task_id} input#task_description`);
    const task_input_value = task_input.val();

    if (task_input.attr("disabled")) {
        task_input.attr("disabled", false);
    } else {
        console.log(task_input);
        task_input.attr("disabled", true);
        sendAjax(action, 'task', 'description', task_input_value);
    }
});

$(document).on("change", ("input:checkbox"), function(event){
    event.preventDefault();
    const action = $(this).closest("form").attr("action");
    const value = $(this).is(':checked');

    sendAjax(action, 'task', 'done', value);
});

// function that sends AJAX
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