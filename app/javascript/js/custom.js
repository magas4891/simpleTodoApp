// editing name of the project
$(document).on("click", ("input[data-project]"), function(event){
    event.preventDefault();
    const project_id = $(this).data("project");
    const project_input = $(`li#project-${project_id} input#project_name`);
    const project_input_value = project_input.val();
    const action = $(this).parents('form').attr('action');

    if (project_input.attr("disabled")) {
        project_input.attr("disabled", false);
    } else {
        project_input.attr("disabled", true);
        sendAjax(action, 'project', 'name', project_input_value);
    }
});

// edit deadline of the project
$(document).on("change", ("input#project_deadline"), function(event) {
    event.preventDefault();
    const action = $(this).closest("form").attr("action");
    const value = $(this).val();

    sendAjax(action, 'project', 'deadline', value)
});

// editing description of the task
$(document).on("click", ("input[data-task]"), function(event){
    event.preventDefault();
    const task_id = $(this).data("task");
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

// signals that deadline is today or has already passed
$(window).on("load ajaxStop", function() {
    const projectDeadlines = $("input#project_deadline");
    projectDeadlines.each(function() {
        const today = new Date();
        const deadline = new Date($(this).val());
        if (today < deadline) {
            $(this.form).find("input#project_name").removeClass("bg-danger");
        } else {
            $(this.form).find("input#project_name").addClass("bg-danger");
        }
    });
});

//editing done of the task
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
    });
}