# Week 1 exam assignments

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

Sections 1.4.2 and 1.5 showed that computers spend a lot of time moving data around.
Since this slows down the actual computations, optimizing it seems really interesting when trying to increase program performance.
Two approaches described by the authors are caches, which reduce the time spent waiting for data, and hyperthreading, which makes use of that waiting time:

### Caches (Section 1.5, 1.6)

One way of reducing copy time is to move fast storage as close to the CPU as possible.
Ideally, main memory itself would be both large and fast, but larger storage is slower and faster storage is more expensive.
To solve this issue, caches were integrated into the flow of data from DRAM to CPU.
Caches are small and very fast storage units located directly on the processor chip.
The idea is to “cache” data that is likely to be used in the near future.
To achieve this, the tendency of programs to access data and code in localized regions (e.g. loops over arrays), called locality, is exploited.
Modern architectures even contain multiple levels of cache, typically L1 to L3, where L1 and L2 usually belong to a single core and L3 is shared by all cores.

What was especially interesting for me about this topic is that I as a programmer can exploit caches to improve my program’s performance without changing the algorithm.
I already experienced this in a deep learning library I am writing from scratch in C++, where being aware of caches made a huge difference in matrix-matrix multiplications.


### Hyperthreading (Section 1.9.1)

While caching is all about reducing the time to copy data, hyperthreading is a technique to increase a computer’s performance by using the time threads wait for data to work on other threads.
Hyperthreading allows a single CPU core to switch between threads really fast by duplicating parts of the hardware, such as register files and program counters, while other parts like the floating-point units still exist only once.
While conventional CPUs require around 20,000 cycles to switch between threads, hyperthreaded ones can decide cycle by cycle which thread to execute, this keeps the core busy more often.

What I found particularly interesting is that the computer I write my programs on, a M2 Mac, does not use hyperthreading at all.
Instead, Apple Silicon chips rely on very wide cores that already execute many instructions at once, plus additional efficiency cores.

---

## Task 03 

>  Do the coding warmup on slide 19. (optional)

Code solutions can be found in `src/coding_warmup/*`
I wrote two version of the code, v2 which just uses only utils already covered and a v3 with `omp parallel for`, which I remembered from "Efficient Computing"

**Results:**
```
Non-Parallel Benchmark
=======================
Serial:  3.7131 sec.
Serial (Ofast): 0.309436 sec.

Parallel Comparison (v1 vs v2 vs v3)
====================================

Threads  v1              v1_ofast        v2              v2_ofast        v3              v3_ofast       
-------  --------------- --------------- --------------- --------------- --------------- ---------------
1        3.5009 sec.     0.885534 sec.   3.64724 sec.    0.887713 sec.   3.68968 sec.    0.4538 sec.    
2        1.85508 sec.    0.452595 sec.   1.86794 sec.    0.452576 sec.   1.89644 sec.    0.226574 sec.  
3        1.25438 sec.    0.316956 sec.   1.40228 sec.    0.314231 sec.   1.33475 sec.    0.156343 sec.  
4        1.00999 sec.    0.249654 sec.   1.05974 sec.    0.236701 sec.   1.00848 sec.    0.124345 sec.  
5        0.814882 sec.   0.217423 sec.   1.18959 sec.    0.218042 sec.   0.831224 sec.   0.121361 sec.  
6        0.722611 sec.   0.208906 sec.   1.42269 sec.    0.218338 sec.   0.768452 sec.   0.17123 sec.   
7        0.752341 sec.   0.177411 sec.   0.965273 sec.   0.166989 sec.   0.597813 sec.   0.09081 sec.   
8        0.553584 sec.   0.152613 sec.   0.923602 sec.   0.158812 sec.   0.537236 sec.   0.083898 sec.  
```

---

## Task 04

>  Parallelize the program of slide 21 with OpenMP.

Code solutions can be found in `src/pi_monte_carlo/*`
Just like in task 3, I wrote two version of the code, v1 which just uses only utils already covered and a v2 with `omp parallel for`. 

**Results:**

```
Serial:         run_time: 7.29746 s
Serial (Ofast): run_time: 1.99122 s

Threads  OpenMP                    OpenMP (Ofast)            OpenMP v2                 OpenMP v2 (Ofast)        
1        run_time: 7.59495 s       run_time: 1.89927 s       run_time: 7.28271 s       run_time: 2.11543 s      
2        run_time: 5.5447 s        run_time: 3.30042 s       run_time: 3.75569 s       run_time: 0.993062 s     
3        run_time: 4.19154 s       run_time: 3.34276 s       run_time: 2.6403 s        run_time: 0.727357 s     
4        run_time: 3.66135 s       run_time: 3.56518 s       run_time: 1.92744 s       run_time: 0.517738 s     
5        run_time: 7.03284 s       run_time: 2.67483 s       run_time: 1.78063 s       run_time: 0.468782 s     
6        run_time: 5.89703 s       run_time: 2.62525 s       run_time: 1.61551 s       run_time: 0.379442 s     
7        run_time: 7.31247 s       run_time: 4.46964 s       run_time: 1.54222 s       run_time: 0.416342 s     
8        run_time: 6.86114 s       run_time: 3.86183 s       run_time: 1.58964 s       run_time: 0.354828 s     
```