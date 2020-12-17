// $(window).on("load", function(){
//     const tasksListElement = $(".tasks__list");
//     const taskElements = tasksListElement.find(".tasks__item");
//
//     for (const task of taskElements) {
//         task.draggable = true;
//     }
//
//     tasksListElement.on("dragstart", function(event) {
//         $(event.target).addClass("selected");
//     });
//
//     $(document).on("dragover", tasksListElement, function(event) {
//         event.preventDefault();
//
//         const activeElement = $(".tasks__list").find(".selected");
//         const currentElement = $(event.target);
//         console.log(currentElement);
//         console.log(currentElement.hasClass(".tasks__item"));
//         const isMoveable = (activeElement != currentElement) && currentElement.hasClass(".tasks__item");
//
//
//         if (!isMoveable) {
//             // console.log("NOT");
//             return;
//         } else {
//             console.log("YES");
//         }
//
//         const nextElement = (currentElement === activeElement.next()) ? currentElement.next() : currentElement;
//         tasksListElement.insertBefore(activeElement, nextElement);
//     });
//
//     tasksListElement.on("dragend", function(event) {
//         $(event.target).removeClass("selected");
//     });
// });

$( function() {
    $( "#sortable" ).sortable({
        revert: true
    });
    $( "#draggable" ).draggable({
        connectToSortable: "#sortable",
        helper: "clone",
        revert: "invalid"
    });
    $( "ul, li" ).disableSelection();
} );