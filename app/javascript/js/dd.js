// $(window).on("load", function(){
//     const tasksListElement = $(".tasks__list");
//     const taskElements = tasksListElement.find(".tasks__item");
//     console.log(tasksListElement);
//     console.log(taskElements);
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

// window.addEventListener('load', () => {
//     console.log("!!!!!!!");
//     const tasksListElement = document.querySelector(".tasks__list");
//     const taskElements = tasksListElement.querySelectorAll(".tasks__item");
//
//     console.log(tasksListElement);
//     console.log(taskElements);
//
//     for (const task of taskElements) {
//         task.draggable = true;
//     }
//
//     tasksListElement.addEventListener(`dragstart`, (evt) => {
//         evt.target.classList.add(`selected`);
//     });
//
//     tasksListElement.addEventListener(`dragend`, (evt) => {
//         evt.target.classList.remove(`selected`);
//     });
//
//     tasksListElement.addEventListener(`dragover`, (evt) => {
//         evt.preventDefault();
//
//         const activeElement = tasksListElement.querySelector(`.selected`);
//         const currentElement = evt.target;
//         const isMoveable = activeElement !== currentElement &&
//             currentElement.classList.contains(`tasks__item`);
//
//         if (!isMoveable) {
//             console.log("NO");
//             return;
//         }
//
//         const nextElement = (currentElement === activeElement.nextElementSibling) ?
//             currentElement.nextElementSibling :
//             currentElement;
//
//         tasksListElement.insertBefore(activeElement, nextElement);
//     });
// });

// window.addEventListener('load', function () {const tasksListElement = document.querySelector(`.tasks__list`);
//     const taskElements = tasksListElement.querySelectorAll(`.tasks__item`);
//
//     for (const task of taskElements) {
//         task.draggable = true;
//     }
//
//     tasksListElement.addEventListener(`dragstart`, evt => {
//         evt.target.classList.add(`selected`);
//     });
//     tasksListElement.addEventListener(`dragend`, evt => {
//         evt.target.classList.remove(`selected`);
//     });
//     tasksListElement.addEventListener(`dragover`, evt => {
//         evt.preventDefault();
//         const activeElement = tasksListElement.querySelector(`.selected`);
//         const currentElement = evt.target;
//         const isMoveable = activeElement !== currentElement && currentElement.classList.contains(`tasks__item`);
//
//         if (!isMoveable) {
//             return;
//         }
//
//         const nextElement = currentElement === activeElement.nextElementSibling ? currentElement.nextElementSibling : currentElement;
//         tasksListElement.insertBefore(activeElement, nextElement);
//     });
// });