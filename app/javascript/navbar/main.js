document.addEventListener("DOMContentLoaded", () => {
  let navbarButtons = document.querySelectorAll('.collapse');

  if (navbarButtons.length == 0) return

  navbarButtons.forEach(button => {
    button.addEventListener("click", collapseParticularMenu)
  });

  function collapseParticularMenu(event) {
    event.preventDefault();
    let target = this.getAttribute('data-target'),
      targetContent = document.querySelector(`#${target}`);

    targetContent.classList.toggle("active");
  }
});
