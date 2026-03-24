import * as bootstrap from "bootstrap"

// Navbar scroll effect: transparent → solid (only on pages with a hero)
const navbar = document.getElementById('main-navbar')
if (navbar) {
  const hasHero = document.querySelector('.hero-andes')
  if (hasHero) {
    window.addEventListener('scroll', () => {
      if (window.scrollY > 50) {
        navbar.classList.add('navbar-scrolled')
      } else {
        navbar.classList.remove('navbar-scrolled')
      }
    }, { passive: true })
  } else {
    navbar.classList.add('navbar-scrolled')
  }
}

// Scroll reveal animation using IntersectionObserver
const revealElements = document.querySelectorAll('.reveal')
if (revealElements.length > 0) {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('revealed')
        observer.unobserve(entry.target)
      }
    })
  }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' })

  revealElements.forEach(el => observer.observe(el))
}

