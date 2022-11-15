let alNav = document.querySelector('#primary-nav');
let navChangePoint = 100;
function stickyNav() {
	if (window.scrollY >= navChangePoint) {
		alNav.classList.add('nav-shadow');
	} else {
		alNav.classList.remove('nav-shadow');
	}
}
window.addEventListener('scroll', stickyNav);