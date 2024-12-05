document.addEventListener("DOMContentLoaded", () => {
  let navbarButtons = document.querySelectorAll('.collapse');

  if (navbarButtons.length == 0) return

  navbarButtons.forEach(button => {
    button.addEventListener("click", collapseParticularMenu)
  });

  function collapseParticularMenu(event) {
    event.preventDefault();
    console.log(event)
    // this.classList.toggle("active");
  }
});
