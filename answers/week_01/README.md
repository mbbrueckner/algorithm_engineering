# Week 01 exam assignments

This directory contains week 01's solutions and is structured as follows: 

```
├── README.md               // info + solutions for writing tasks (1, 2)
└── src
    ├── coding_warmup       // task 3
    │   ├── hello
    │   │   └── ...
    │   └── pi_parallel
    │       └── ...
    └── pi_monte_carlo      // task 4
        └── ...

```

**Note** that I added versions of `pi_parallel` and `pi_monte_carlo` using `omp parallel for` since I've seen it before in the "Efficient Computing" lecture in SS26 and wanted to test their performances against my other implementations. 

----

## Task 01

>Select one slide from the lecture, research more about the topic, and report on it.


### "The free lunch is over" (slide 10)

Optimizing code performance nowadays is largely about parallelization, whether making use of SIMD vectorization, exploiting multi-core CPUs or even delegating computation to a GPU. 
But things haven't always been like this.
For decades developers benefited from so-called Dennard scaling (smaller Transistors -> run at lower voltage -> power and heat per area stay constant) [1].
As transistors got smaller with every generation and clock speeds increased accordingly, code got faster with every new chip, without any changes to it.
Back then CPU performance was mainly driven by clock speed, but also by execution optimizations and cache.
In his article “The Free Lunch Is Over: A Fundamental Turn Toward Concurrency in Software” (2005), Herb Sutter shows that this trend fundamentally changed around the start of 2003, when clock speeds stopped increasing [2].

Multiple physical issues, such as leakage currents, too much heat and excessive power consumption, forced major chip vendors to find new ways to improve their products [2].
As a consequence, performance increases have since then mainly come from hyperthreading, multicore architectures and cache [2].
Of these three, cache size is the only one from which existing programs can still profit, but apart from that the “free lunch” for developers is over and faster code means more engineering work.
Sutter claims concurrency marks one of the big revolutions in the history of software development, comparable to object orientation in the 1990s [2].

From today’s perspective, Sutter’s claims about the importance of writing concurrent code appear to have come true.
While clock speeds today are still stuck at around 5 to 6 GHz, the number of cores in CPUs has increased heavily.
Modern consumer CPUs typically have 6 to 16 cores or more.
Apple’s M5 Ultra SoC, for example, can be configured with up to 36 CPU cores [3].
Besides CPUs, GPUs (and other large scale parallel compute units like TPUs) have also become more and more important to the everyday use of computers.
Modern applications in machine learning and artificial intelligence in particular are highly dependent on well-engineered parallel code.

**Personal thoughts**

Something I realized while reading the article “The Free Lunch Is Over” was that some concepts that appear to be general knowledge for my generation were seen as major turning points in the history of software development.
Personally, I cannot remember sitting in front of a computer that didn’t have multiple cores, and object orientation was something I learned very early when I first started programming.
I wonder if someday people will look back on the current evolution of artificial intelligence like Sutter did on OOP.

**Sources**
[1] R. H. Dennard et al., “Design of Ion-Implanted MOSFET’s with Very Small Physical Dimensions”, IEEE Journal of Solid-State Circuits, vol. SC-9, no. 5, pp. 256-268, 1974.

[2] H. Sutter, “The Free Lunch Is Over: A Fundamental Turn Toward Concurrency in Software”, Dr. Dobb’s Journal, vol. 30, no. 3, March 2005.

[3] Apple Inc., “Apple introduces M6 and M5 Ultra,” Apple Newsroom, August 2026. https://www.apple.com/newsroom/2026/08/apple-introduces-m6-and-m5-ultra-for-a-big-leap-in-performance-and-ai-compute/


---

## Task 02 

>Read Chapter 1 from Computer Systems: A Programmer’s Perspective.
>Discuss two things you find particularly interesting.

