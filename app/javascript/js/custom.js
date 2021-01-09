// editing name of the project
$(document).on("click", ("#name-edition"), function(event){
    event.preventDefault();
    const project_id = $(this).data("project");
    const project_input = $(`li#project-${project_id} input#project_name`);
    const project_input_value = project_input.val();
    const action = $(this).parents('form').attr('action');

    editInput(project_input, action, 'project', 'name', project_input_value);
});

// edit deadline of the project
$(document).on("change", ("[id^='datepicker']"), function(event) {
    event.preventDefault();
    const action = $(this).closest("form").attr("action");
    const value = $(this).val();

    sendAjax(action, 'project', 'deadline', value)
});

// editing description of the task
$(document).on("click", ("button[data-task]"), function(event){
    event.preventDefault();
    const task_id = $(this).data("task");
    const action = $(this).parents('form').attr('action');
    const task_input = $(`li#task-${task_id} input#task_description`);
    const task_input_value = task_input.val();

    editInput(task_input, action, 'task', 'description', task_input_value);
});

// signals that deadline is today or has already passed
$(window).on("load ajaxStop", function() {
    const projectDeadlines = $("[id^='datepicker']");
    projectDeadlines.each(function() {
        const today = new Date();
        const tempDate = $(this).val().split(".");
        const deadline = new Date(tempDate[2], tempDate[1]-1, tempDate[0]);
        if (today > deadline) {
            $(this.form).css("background-color", "red");
        } else {
            $(this.form).css("background-color", "");
        }
    });
    const tasks = $("li[id^='task']");
    tasks.each(function() {
        if ($("input#task_done", this).is(':checked')) {
            $(this).css("background-color", "paleturquoise");
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
        }
    });
}

// function that open input for new tasks
function openInputs() {
    $("input.new-task-description").map(function() {
        $(this).attr("disabled", false)
    });
}

function editInput(input, action, model, field, inputValue) {
    if (input.attr("disabled")) {
        $("input#project_name, input#task_description").each(function() {
            $(this).attr("disabled", true);
        });
        input.attr("disabled", false);
    } else {
        input.attr("disabled", true);
        $("input.new-task-description").map(function() {
            $(this).attr("disabled", false)
        });
        sendAjax(action, model, field, inputValue);
    }
}
