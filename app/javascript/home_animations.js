let tl = gsap.timeline({})
tl.from(".animated-button", {
  scale: -1.5,
  duration: 1,
  ease: "sine.in",
}, 0)
.to(".animated-button", {
  scale: 1,
  y: 0,
  duration: 2,
  ease: "sine.in",
}, 1)
.from(".animated-arrow", {
scale: 0.01,
opacity: 0,
duration: 0.5,
ease: "sine.in",
}, 0)
.to(".animated-arrow", {
scale: 3,
opacity: 1,
duration: 1,
x: 250,
y: -70,
height: 100,
ease: "sine.in",
}, 0.5)

// ScrollTrigger
ScrollTrigger.create({
trigger: ".animated-title",
start: "-580% center",
end: "0% center",
scrub: true,
markers: false,
animation: gsap.from(".animated-title", {
  scale: 1,
  x: -500,
  ease: "sine.in",
  duration: 1
})
});

ScrollTrigger.create({
trigger: ".animated-container",
start: "-170% center",
end: "0% center",
scrub: true,
markers: false,
animation: gsap.from(".animated-container", {
  scale: 1,
  x: -500,
  ease: "sine.in",
  duration: 1
})
});
ScrollTrigger.create({
trigger: ".animated-container-2",
start: "-160% center",
end: "-60% center",
scrub: true,
markers: false,
animation: gsap.from(".animated-container-2", {
  scale: 1,
  x: -500,
  ease: "sine.in",
  duration: 1
})
});
ScrollTrigger.create({
trigger: ".animated-image",
start: "-170% center",
end: "0% center",
scrub: true,
markers: false,
animation: gsap.from(".animated-image", {
  scale: 1,
  x: 500,
  ease: "sine.in",
  duration: 1
})
});


// Add hover effect
const animatedButton = document.querySelector('.animated-button');

animatedButton.addEventListener('mouseenter', () => {
  gsap.to(animatedButton, {
    scale: 1.3,
    duration: 0.1,
    ease: "power4.in"
  });
});

animatedButton.addEventListener('mouseleave', () => {
  gsap.to(animatedButton, {
    scale: 1,
    duration: 0.1,
    ease: "power4.in"
  });
});

// Smooth Scroll
const lenis = new Lenis()

lenis.on('scroll', (e) => {
  console.log(e)
})

function raf(time) {
  lenis.raf(time)
  requestAnimationFrame(raf)
}

requestAnimationFrame(raf)
