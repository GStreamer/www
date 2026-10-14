---
title: "GStreamer Conference 2016 - speaker biographies and talk abstracts"
year: 2016
type: "conference"
---

## Berlin, Germany, 10-11 October 2016

[Back to conference main page](/conference/)

[Back to conference timetable](schedule.html)

### GStreamer State of the Union. Tim-Philipp Müller (\_\_tim), Centricular {#state-of-the-union}

This talk will take a bird's eye look at what's been happening in and around GStreamer in the last twelve months and look forward at what's next in the pipeline.

*Tim Müller is a GStreamer core developer and maintainer, and backseat release manager. He works for Centricular Ltd, an Open Source consultancy with a focus on GStreamer, cross-platform multimedia and graphics, and embedded systems. Tim lives in Bristol, UK.*

### The Pexip Media Architecture. Håvard Graff (hgr), Pexip {#pexip-media-architecture}

Pexip Infinity is a scalable meeting platform that connects virtually any communications tool, such as WebRTC, Microsoft Lync, and traditional video- and audio conferencing together for a seamless meeting experience. Based entirely on GStreamer + Python, we discuss some of the architectural solutions we have ended up with and how they came to be, with a particular focus on high-level bins, custom events, mixing, optimised codecs, the joys of rt(m)p, and how to test it all.

*Håvard Graff has worked with GStreamer professionally for 9 years in Tandberg, Cisco and now Pexip. Developing video conferencing systems like Movi, Jabber Video and Pexip Infinity using GStreamer as the backbone. Was instrumental in premiering GStreamer in the AppStore. Still pretends to be a musician with programming as a hobby.*

### Industrial application pipelines with Gstreamer. Marianna S. Buschle, QTechnology {#industrial-application-pipelines}

The talk is about how we, from a small camera company, have decided to use GStreamer in order to try to achieve rapid prototyping and development of image processing pipelines for industrial applications. We have done this by using the basic concepts/tools of GStreamer (pipelines and elements) and developing a lot of our own elements for the image processing functions (mostly based on existing openCV functions), since a lot of the applications we developed share many similar image processing steps (background segmentation, filtering, contour processing, object tracking, etc). We also talk about the challenges we encountered by trying to use GStreamer in a slightly different way than it was originally intended (image processing in real-time vs multimedia). Some examples of different applications/pipelines will also be shown.

*Marianna S. Buschle is a software engineer at Qtechnology, a danish company producing FPGA based industrial smart cameras. She works mainly with embedded programming and image processing. She has been working with GStreamer since 2015.*

### Tracking Memory Leaks. Guillaume Desmottes (cassidy), Collabora {#tracing-memleaks}

In this presentation I'll talk about my experience on debugging memory leaks in GStreamer code. I'll explain the different approaches I use and why I ended up writing a new leaks tracer tool. I'll show the usual suspects to look for when tracking leaks and a few tricks I use when debugging.

*Guillaume has been working for 10 years for Collabora and been involved in various parts of the GNOME project. He's one of the main developer behind the Telepathy IM/VOIP framework and is now part of Collabora's multimedia team.*

### gstreamermm: C++ way of doing GStreamer-based applications. Marcin Kolny (loganek) {#gst-mm}

This talk presents a brief introduction to gstreamermm - a C++ interface for the GStreamer framework, developed as a part of gtkmm project. I'll shortly describe fundamental concepts of gstreamermm interface like smart pointers, signals, error handling, point out differences between C and C++ API, I'll also tell few words about benefits that come with using gstreamermm along with the C++(11) codebase: convenient API for GStreamer data structures (e.g. GstStructure, GstMessage, GstCaps etc.), easy way of connecting to signals using lambda expressions or class methods, and more.

I'll present, how can we avoid boilerplate in our code and develop GStreamer plugins using native C++ language mechanisms (like inheritance, polymorphism) and demonstrate how can we write simple GStreamer element.

At the end, I'd like to share the development plan for the next release.

*Marcin is a software development engineer at Microsoft. Last year he graduated from the university with a master degree in computer science. In his free time, Marcin contributes to several open source projects. For a few years he's been being also member of GNOME Foundation, where maintains gstreamermm library and gst-debugger application, and also contributes to some other (mostly C++ related) projects.*

*Marcin's started using GStreamer framework couple of years ago in his previous job, where he was responsible for delivering video library for UAV system.*

### The wonderful world of horrible networks. Håvard Graff (hgr), Pexip {#horrible-networks}

Pexip wants to connect people and allow them to communicate freely, but bad networks can make the experience less than optimal. We will discuss some of the tools (FEC, NACK, PLI etc.). that exists, and how they can be best applied derived from the information we have available. It will showcase an interactive tool we have developed to be able to easily test out different scenarios in “real-life”, and how it can make the “unsolvable problem” a lot more fun to try and solve. A particular focus around WebRTC is to be expected.

*Håvard Graff has worked with GStreamer professionally for 9 years in Tandberg, Cisco and now Pexip. Developing video conferencing systems like Movi, Jabber Video and Pexip Infinity using GStreamer as the backbone. Was instrumental in premiering GStreamer in the AppStore. Still pretends to be a musician with programming as a hobby.*

### Processing: The new 1.0-based video library for desktop and RPi, with GoPro support (and much more!). Andres Colubri and Gal Nissim, Processing Foundation {#processing}

The Processing project is a community initiative to make coding more accessible as a medium for artistic creation, and visual and interactive design. It was initiated in 2001 at the MIT Media Lab by Ben Fry and Casey Reas, and it is now used around the world for teaching, prototyping, and production.

Since 2008, GStreamer has been the foundation of Processing's video playback and capture capabilities. The release of GStreamer 1.x motivated a major update of the video library in Processing, which is finally becoming a reality thanks to the contributions of Gottfried Haider and other members of the community.

The new GLVideo library for Processing integrates GStreamer's 1.x APIs with the OpenGL Helper Library to enable high-performance playback and capture on PC, Mac, and Raspberry Pi. GLVideo also allows creating custom pipelines to handle devices which were never supported before such as the GoPro cameras.

We will demonstrate these new features during the talk, and discuss the next steps in the project.

*Andres is a researcher working on data visualization and interactive graphics. He is an active contributor to the Processing project, a language and programming environment for computational arts and design, and the Java bindings for the GStreamer multimedia framework. He is the main developer of the OpenGL renderer and the GStreamer-based video library in Processing 2 and 3. He originally studied Physics and Mathematics in Argentina and later on did an MFA at the UCLA Design Media Arts program. He uses Processing as the main tool to bridge his interests in computer graphics, visualization, and statistical modeling.*

*Gal Nissim is a multidisciplinary scientist and artist from Israel, based in New York. She graduated summa cum laude from the Hebrew university of Jerusalem in 2014, where she received her Bachelor of Science in Cognitive Science and Biology. Her studies focused on the research of humans' visual memory and bats' navigation. Currently, she is a Masters candidate at NYU’s Interactive Telecommunications Program. Her work explores the twilight zone: the in-between of fiction and reality, beauty and ugliness, attraction and disgust, art and science. Gal joined Processing Foundation this summer and helped to develop the new GLvideo library.*

### GStreamer-VAAPI: where we are today. Víctor M. Jáquez L. (ceyusa), Igalia {#gstreamer-vaapi}

GStreamer-VAAPI is a set of GStreamer elements (vaapisink, vaapipostroc, and several encoders and decoders) that uses VA-API software stack for hardware accelerated video processing.

This talk is a follow-up of the last presentation: we will talk about the state of VA-API and its integration with GStreamer. Also, we will mention what is ahead in the development of GStreamer-VAAPI, and its current problems and challenges.

*Víctor started to work in GStreamer in 2006, on an initial implementation of GStreamer elements wrapping OMX components. Later on, he moved to other related projects such as the WebKit, Ekiga, etcetera. Last year, he returned to the GStreamer arena, helping with gstreamer-vaapi.*

### Using GStreamer for Video Analytics: VCA­Bridge. Julián Bouzas, VCA Technology {#vcabridge}

This talk is mainly about VCA­Bridge, a product that uses gstreamer to do ​ Video analytics for security and retail applications (such as automated intruder detection and people counting) for a vast majority of different IP cameras.

The talk will cover topics ranging from the actual status of the product and use cases to its integration with gstreamer. In addition, the current structure of the gstreamer pipelines and plugins will be described as well as the issues we have faced and our future plans to improve the user experience.

*Julian Bouzas is a software engineer working for VCA Technology, where he has been improving the GStreamer integration with VCA­Bridge.*

### GStreamer Element States: How do they work in detail? Sebastian Dröge (slomo), Centricular {#element-states}

One of the most basic features of GStreamer elements are their states, and how the GStreamer core is managing them for the application to be as simple as possible. The states define what resources an element currently occupies and if it is currently able to produce data or not.

In this presentation a in-depth explanation of how the element states work is given, covering all the little details that application developers usually don't have to worry about. This includes what GstPipeline, GstBin and GstElement are doing during the state changes and how the first two are managing the states of their child elements, asynchronous state changes, elements losing their state while they're running and how live elements are affecting state changes.

While all this works very well in almost all situations, there are a few known issues in special cases with the current implementation of the element states. A few of these will be described, and also why all of these usually never happen under normal circumstances.

Finally, a few possible solutions to these issues and other future improvements to how we handle states will be discussed.

*Sebastian Dröge is a Free Software developer and one of the GStreamer maintainers and core developers. He has been involved with the project since more than 10 years now. He also contributes to various other Free Software projects, like Debian, GNOME and WebKit. While finishing his master's degree in computer sciences at the University of Paderborn in Germany, he started working as a contractor for GStreamer and related technologies. Sebastian is one of the founders of Centricular, a company providing consultancy services, where he's working from his new home in Greece on improving GStreamer and the Free Software ecosystem in general.*

*Apart from multimedia related topics, Sebastian has an interest in digital signal processing, programming languages, machine learning, network protocols and distributed systems.*

### The State of GStreamer for Video Editing. Thibault Saunier (thiblahute), Samsung OSG {#video-editing}

Very soon in the development of the GStreamer framework the Video Editing use case has been targeted by the developers. Since that a lot of work has been done in that area but we have had a hard time reaching the same level of maturity and stability as other 'parts' of GStreamer.

This talk will explain what features and enhancements have been implemented in the GStreamer Editing Services and in NLE (the replacement of GNonLin) in the last years. It will also explain how we have had to work on many components of GStreamer to be able to properly support the Video Editing use case, it will also detail what is planned for those components in the near future and in the long term.

*Thibault Saunier is a Senior Software Engineer currently working at the Samsung Open Source Group. He is a GStreamer developer who maintains GStreamer validate, the GStreamer Video Editing Stack as well as the Pitivi video editor.*

### How to work with dynamic pipelines using GStreamer. Jose Antonio Santos Cadenas, Kurento {#dynamic-pipelines}

GStreamer has been widely used for players. It is very easy to generate pipelines that can reproduce a file, read a remote rtsp or rtp source or even transcode a file. Using gst-launch makes very easy to develop this kind of applications. Nevertheless, GStreamer design allows other usages where elements are dynamically added or removed at any time. Develop this kind of applications can be a little bit more complicated and require a better control of media flows and elements states.

This talk shall demystify the programming of dynamic applications. Recommending patterns for adding and removing elements while media is flowing, providing examples on how this can be done and showing demos that apply those patterns.

*José Antonio Santos is the Tech Leader of Kurento Media Server team. He is working on the design and implementation of a real time mediaserver with WebRTC capabilities*

### Digital television support: where we are at. Reynaldo H. Verdejo Pinochet (reynaldo), Samsung OSG {#digital-television-support}

Digital television is complex, specially considering the transmission part of the currently deployed systems. Relatedly -- And more than likely; because so --, GStreamer's support for it, although 'working', is in need of improvements.

The talk explores the extent of our support for the different standards, hardware devices and application use cases, to provide a condensed view of both planed and current work in the context of the scenario configured by both, late standardization efforts and improvements in the low level support for the associated hardware devices in Linux.

*Husband, Dad, and Multimedia FOSS developer by trade in between, he has been doing FOSS multimedia for more than a decade. While his work can primarily be found in FFmpeg and GStreamer his contributions are all over the place and back, across a wide arrangement of community projects. Reynaldo is also a member of Samsung's Open Source Group and as such, works mostly on bridging the gap between the company's internal processes and the greater community's. Sincerely hoping to be able to help both.*

### Debugging race conditions problems in GStreamer. Miguel París Díaz, Kurento {#race-conditions}

Dealing with multi-threaded systems is not easy in general, but when the system is related to media and has real-time restrictions is even much more complicated. Critical bugs are only seen under specific race conditions that only take place time to time, making the debugging a hard work that can consume a lot of time for developers.

In this talk, we present the methodologies, processes and tools designed and used in the context of Kurento Media Server to face these problems. Thanks to these techniques, we have found, reported and fixed some bugs not only in Kurento, but also in GStreamer improving the stability.

We show some real cases and how we apply the techniques commented before to understand the problem, make a simple program to reproduce it, and fix it. Moreover, we explain our future work related to use Continuous Integration systems like Jenkins to reduce the time invested by developers dealing with this kind of problems.

With this work, we aim to ease the life of GStreamer developers and users, even we would like to listen proposals and suggestions to improve these techniques.

*Miguel París has a Software Engineering Degree and a Telematic Systems Master's. He has worked since 2011 designing and developing architectures and APIs for multimedia and real-time systems. Currently he works as a researcher and he is the responsible of the real-time area in Kurento, where he develop parts related to GStreamer. In addition, he has contributed to GStreamer community with patches and discussions about RTP stack, race condition bugs, etc.*

### HLS alternative renditions. Jan Schmidt (thaytan), Centricular {#hls-alt-renditions}

HLS Alternate Renditions provide support for multiple language tracks and subtitles. This talk is about the GStreamer implementation and the problems encountered while making it.

*Jan Schmidt has been a GStreamer developer and maintainer since 2002. He is responsible for GStreamer's DVD support, and primary author of the Aurena home-area media player. He lives in Albury, Australia and keeps sheep, chickens, ducks and more fruit trees than is sensible. In 2013 he co-founded Centricular - a consulting company for Open Source multimedia and graphics development.*

### Vulkan, OpenGL and/or Zerocopy. Matthew Waters (ystreet00), Centricular {#vulkan-opengl-zerocopy}

The GPU is a powerful processor for video and recent additions to the API landscape (Vulkan) provide developers even more control over exactly what, when and where a program is executed. Equipped with SPIR-V and/or GLSL, one can envisage complex (or simple) filters, mixers, sources and sinks that transform, produce or consume the typical video stream in extraordinary ways. With the possibility of zerocopy decoding (and/or encoding), this process can be extremely efficient. This talk will provide an overview on the current integration state of GStreamer + OpenGL and Vulkan, a look into the future of GStreamer with OpenGL and Vulkan as well as touching on the work necessary to integrate Zerocopy decoding/encoding with these API's.

*Matthew Waters is the principal maintainer of the OpenGL integration with GStreamer from the start of GStreamer 1.x and has integrated GStreamer's OpenGL library with many other decoding, encoding and rendering technologies. He's also played around extensively with Vulkan, a new high-performance, cross-platform 3D graphics API.*

*Matthew is a Multimedia and Graphics developer for Centricular Ltd, an Open Source consultancy focusing on GStreamer, embedded systems and cross-platform multimedia and graphics.*

### Efficient Trick Modes in MPEG-DASH Adaptive Streaming with GStreamer. Wojciech Przybyl, Visla Systems {#dash-trickmodes}

The goal of the talk is to present an efficient way of implementing Trick Modes in MPEG-DASH built with a simple application on GStreamer. In a standard adaptive streaming playback the same stream is encoded several times with different bitrates, which is used for tracking available bandwidth. However I would like to take adaptive streaming one step further and show that a stream can also be encoded with several different frame rates for each bitrate, which enables very fast and highly efficient Trick Modes and rapid live stream switching. At the end of the talk a small demo application will be presented.

*Wojciech Przybyl is Technical Director and Founder of Visla Systems and has 10 years of experience in developing multimedia Embedded Systems. He worked on several Digital Video Recorder projects for motorsport industry delivering DVRs to racers ranging from amateur level to F1 teams. Along with video encoding, Wojciech worked on decoding side developing Set Top Boxes for global corporations and small STB development companies in a number of European countries. Currently established an Embedded Systems consultancy business, which helps other companies developing Embedded Systems built on open source.*

### Lightning Talks

Lightning talks are short talks by different speakers about a range of different issues. We have the following talks scheduled so far (in no particular order):

- Yet Another Update about Video4Linux2 in GStreamer  
  *Nicolas Dufresne, Collabora*
- FFV1 and Matroska as a new standard for video archiving  
  *Georg Lippitsch, ToolsOnAir*
- Writing Software Synthesizers for GStreamer  
  *Stefan Sauer, Google*
- Making GStreamer on Android Easier  
  *Arun Raghavan*
- IP Streaming Performance Issues with GStreamer on an Embedded Platform - and some Solutions  
  *David Plowman, BrightSign Digital*
- Measuring video-capture latency with the Raspberry Pi and satellites  
  *Will Manley, stb-tester.com*
- Smooth playback of adaptive video streams on Raspberry Pi with gst-mmal  
  *John Sadler, YouView TV*
- GstValidate: A good friend for GStreamer debugging  
  *Thibault Saunier, Samsung OSG*
- GObject bindings for libva  
  *Scott D Phillips, Intel*
- How I ported Kurento Media Server to Windows  
  *Kyrylo Polezhaiev*
- Code review in Chromium project + quick update on the Media Process based GStreamer backend  
  *Julien Isorce, Samsung*
- GstSeamCrop: A seam crop real-time video retargeting  
  *Francisco Javier Velazquez*
- PyGObject & GIL - the death by thousand cuts  
  *Mikhail Fludkov, Pexip*
- ...
- *Your talk here?*

**Lightning talk speakers**, please export your slides into a PDF file and either send it to Tim by e-mail (you will receive an e-mail from him about your lightning talk before the event) or have it ready on a usb stick before the start of the lightning talks on Monday. The idea is that everyone uses the same laptop so that we don't waste time hooking up laptops to the projector and configuring them. There is no particular order or schedule for the talks. When a speaker is called up, we will also mention who is up next. Every speaker has up to ca. 5 minutes for their talk. There will be a countdown timer running, and there will be some music playing towards the end so the speaker knows they have to wrap up. If you don't want to use up the full 5 minutes, that's fine as well. It's not possible to go over time, you'll have to finish up so that everyone has an opportunity to present their talk.

### Time and Synchronisation: take two! Nicolas Dufresne (ndufresne), Collabora {#time-and-sync-take-two}

Stream synchronization is one of the most important aspect of GStreamer and yet isn't the most understood. In 2013, Edward Hervey presented "Time and Synchronization for dummies". This year, I'd like to follow Edward's steps and help you further into using and interpreting data time and duration for the purpose of synchronization. This talk will be based on real life scenarios that I had to solve this year. Notably, stream synchronization for echo cancellation and timestamp interpolation with appsrc.

*Nicolas is Senior Multimedia Engineer at Collabora, based in Montréal, he was initially a generalist developer, with background in set-top-box development. Nicolas started in 2011 contributing to GStreamer Multimedia Framework, adding infrastructure and primitive to support accelerated upload of buffers to GL textures. His work toward fully Open Source general purpose use of accelerator in GStreamer continues today at Collabora with the recent addition of Video4Linux accelerated decoders and converters support, enabling playback of today's content on Cotton Candy and the HardKernel Odroid U2.*

### An overview of video encoding benchmarks with GStreamer. Florent Thiéry, UbiCast {#video-encoding-benchmarks}

GStreamer provides quite a few open source integrations to perform software or hardware-accelerated video encoding; this talk will try to provide an overview of encoding performance figures, from the Raspberry Pi, to software encoding, to VA-API up to Nvidia GPUs, as well as describe suitable methods for performing benchmarks.

*Florent Thiéry is the C.T.O. and co-founder of UbiCast, a 2007-founded French startup company that builds GStreamer-based solutions designed capture and webcast interactive videos, like the GStreamer Conference video archive.*

### Corroded Pipelines, or how to write GStreamer elements in Rust for safety and fun. Sebastian Dröge (slomo), Centricular {#corroded-pipelines-rust}

Nowadays most of the code in GStreamer is written in C with GObject for providing features for Object Oriented Programming. This has a couple of possible issues and inconveniences.

Rust is a new systems programming language that tries to fill the place of C and C++, while providing additional safety guarantees to prevent a whole set of common bugs, including memory corruption and data races. At the same time it provides many language features that are usually only known from higher-level or scripting languages, and guarantees that the usage of these features does not have a negative impact on performance.

For the safety guarantees alone, Rust seems like a perfect fit for GStreamer, because of the heavy usage of threads but even more important because most of the data that has to be processed in GStreamer comes from untrusted sources and corrupted or malicious data must under no circumstances cause crashes or even impose security risks.

Simultaneously, Rust's higher-level language features and feel make it more appealing than using arcane C with GObject.

In this presentation, a possible way of implementing GStreamer elements in Rust is shown with together with some examples of where Rust makes development of the elements safer and more fun. Afterwards the possible future of Rust for writing GStreamer code will be discussed with the audience, also in the context of their projects and whether it would be an option for them to consider Rust for their next projects.

*Sebastian Dröge is a Free Software developer and one of the GStreamer maintainers and core developers. He has been involved with the project since more than 10 years now. He also contributes to various other Free Software projects, like Debian, GNOME and WebKit. While finishing his master's degree in computer sciences at the University of Paderborn in Germany, he started working as a contractor for GStreamer and related technologies. Sebastian is one of the founders of Centricular, a company providing consultancy services, where he's working from his new home in Greece on improving GStreamer and the Free Software ecosystem in general.*

Apart from multimedia related topics, Sebastian has an interest in digital signal processing, programming languages, machine learning, network protocols and distributed systems.

### Holographic Telecommunication in the Age of Free Software. Lubosz Sarnecki (lubosz), Collabora {#holographic}

The GStreamer VR plugins allow GStreamer video players to use head tracking and map the very popular equirectangular format for spherical video. I also explain why 360° degree video is a bad name for it. In addition the GStreamer VR plugins allow to stream a Kinect v2 point cloud and visualize it on a HMD, to enable holographic video chat.

Blog post: [Introducing GStreamer VR Plug-ins and SPHVR](https://lubosz.wordpress.com/2016/07/04/introducing-gstreamer-vr-plug-ins-and-sphvr/)

*Lubosz Sarnecki studied Computervisualistik in Koblenz and works on GStreamer and VR for Collabora.*

### Intelligent Surveillance. Mandar Joshi {#intelligent-surveillance}

With increasing focus on our security, we need surveillance solutions to get better, faster. Solutions need to get smarter to reduce the human workload in monitoring systems. The project I am about to present is one such solution. It's called Surveillance. It’s not just an application which allows capture and storage of video stream 24x7. It’s an extendable framework that allows you to do custom processing on video streams using simple shared libraries/ GStreamer plugins and report results in plain text, allowing you to easily parse it and take decisions. This system comprises of Cameras/Camera Sensors, Processing Hardware (camera endpoints) and a central server. Processing happens on the camera endpoints and is collected by the central server.

*Mandar Joshi is a Linux developer with over 9 years experience in the Linux and Embedded Linux domain with projects ranging from smart cards and point-of-sale terminals to data processing using Linux. Presently, he is exploring the use of GStreamer for audio and video processing applications using embedded Linux.*

### Keep calm and refactor: About the essence of GStreamer. Wim Taymans (wtay), RedHat {#essence-of-gstreamer}

While expanding the scope of Pinos, I decided to move away from using GStreamer and design a simple plugin API that attempts to combine the best of v4l2 MediaCodec, MFTransform, OpenMAX IL and GStreamer. The api aims to be usable in Real-time multimedia applications, supporting both synchronous and asynchronous operation. In this talk I will go over the design ideas and how we could refactor some plugins and libraries of GStreamer.

*Wim Taymans has a computer science degree from the Katholieke Universiteit Leuven, Belgium. He co-founded the GStreamer multimedia framework in 1999. Wim Taymans is a Principal Software Engineer at Red Hat, responsible for various multimedia packages and is currently working on the Pinos multimedia Daemon.*

### Playing Arbitrary Video Files with GStreamer. Michael Olbrich, Pengutronix {#playing-everything}

GStreamer works quite well for a lot of different use-cases as long as the input data well known and 'valid'. When playing arbitrary content, things don't look so good. There are a lot of obscure formats, files that are not quite spec conforming and streams with a lossy transport layer. GStreamer could be better at the best effort approach to deal with this. The situation has improved a lot in the last few years but the is still room for improvements.

This talk will illustrate this with several real world problems encountered while implementing a custom video player. Its goal it to raise the awareness of these problems and provide developers with some things to keep in mind while writing GStreamer plugins.

*Michael Olbrich is an open-source developer with a focus on platform integration on embedded Linux. He works as a full-time Linux developer for Pengutronix. His job is to provide a smooth Linux experience on embedded devices from init systems to graphics and multimedia frameworks. He is the main maintainer for PTXdist, an embedded Linux distribution.*

### GStreamer in the broadcast world: A general overview. Georg Lippitsch, ToolsOnAir {#gst-in-broadcast-world}

More and more companies adapt GStreamer for TV and video production. The use cases include ingest and playout systems, live mixing, streaming services and many more. GStreamer is especially intersting in mixed production environments, consisting of both linear analogue/SDI and file/IP based systems.

This talk gives a general overview of companies in the broadcast industry using GStreamer in their products. In then goes into some more detail and introduces some of the features especially interesting for broadcast production. Examples on how to use these elements within the GStreamer API will be given.

*Georg used to run a TV production company and worked as a camera operator for several years. The requirement to transmit his video files made him write his own software, and brought him in touch with FFmpeg and GStreamer. Now Georg works as a software engineer and has written code for several institutions in the media industry including TV stations, video production companies and film archives.*

### GStreamer development on Windows and faster builds on all platforms with the Meson build system. Nirbheek Chauhan (nirbheek), Centricular {#windows-dev-meson}

Our current build system Autotools has served us reasonably well since our early days, but it has some very serious drawbacks; many of which are holding the GStreamer project back.

Building and developing GStreamer on Linux is mostly a solved problem, but our B&I and development story on embedded devices and on Windows and OS X is seriously lacking. The situation is particularly bad on Windows where the recommended way to build is actually by cross-compiling from Linux.

In mid-August, an alternative/parallel build system that uses Meson was merged into the GStreamer repositories. With this, we now have much better support for building on embedded devices and on Windows. Our development story on Windows has also been greatly improved with potential for improvements on OS X as well.

In this talk, I will be speaking about the issues people face while building and developing GStreamer on most platforms, how Meson helps solve many of these, and in the process also gives us much faster (twice as fast!) builds on Linux.

### The new GstStream API, design and usage. Edward Hervey (bilboed), Centricular {#new-stream-api}

The new decodebin3 and playbin3 elements have now finally landed in GStreamer 1.10, along with a new GstStream API for working with streams.

As a follow-up on last year's talk where I explained the pitfalls and requirements for new elements and API, this talk will concentrate on the new API.

The new GstStream API now allows explicit and unambiguous usage of "streams" (in a way which is relevant to users), being able to list them, select them, all of this in a generic way.

After explaining the core stream and collection objects, we will go over the various use-cases the API helps with, and use-cases that weren't possible before. This will be done by introducing at every step the new GstStream-related events and messages.

Finally we will go over some implementation examples, both in elements and in applications.

*Edward Hervey has been contributing for over 12 years to GStreamer, ending up there after starting the PiTiVi video editor and then maintaining various components over the years. After having started Collabora Multimedia in 2007, attempting to go on sabbatical, and doing various freelancing, Edward Hervey is currently a consultant for Centricular.*

### Profiling GStreamer pipelines. Kyrylo Polezhaiev {#profiling}

Measuring performance and finding bottlenecks is key in program optimization. In this speech I will talk about what happens, at different levels of abstraction, with GStreamer-based app’s objects when it’s running, ways to record this events for future analysis and algorithms to re-create model of pipeline with performance information.

*Kyrylo Polezhaiev is a software engineer and former video game developer, and has an MSc in Systems Engineering. He assembled radio receiver at age eleven, and created a video game (using GStreamer) with 200k+ downloads when he was 21. Kyrylo lives in Kharkiv, Ukraine.*

### Multimedia Communication Quality Assessment Testbed. Jean-Charles Grégoire, Énergie Matériaux Télécommunications (EMT) Research Centre {#comm-quality-assessment-testbed}

We make an intensive use of multimedia frameworks in our research on modeling the perceived quality estimation in streaming services and real-time communications. In our preliminary work \[1\] we have used the VLC VOD software to generate reference audiovisual files with various degree of coding and network degradations. We have successfully built machine learning based models on the subjective quality dataset we have generated using these files.

However, imperfections in the dataset introduced by the multimedia framework we have used prevented us from achieving their full potential. In order to develop better models, we have re-created our end-to-end multimedia pipeline using the GStreamer framework for audio and video streaming.

A GStreamer based pipeline proved to be significantly more robust to network degradations than the VLC VOD framework and allowed us to stream a video flow at a loss rate up to %5 packet very easily.

GStreamer has also enabled us to collect the relevant RTCP statistics that proved to be more accurate than network-deduced information. This dataset \[2\] is free to the public \[3\]. The accuracy of the statistics eventually helped us to generate better performing perceived quality estimation models.

Overall, using the same machine learning algorithms and same configurations, we have managed to obtain 93% accuracy in terms of Pearson correlation with the dataset generated with the GStreamer based end-to-end pipeline compared to 88% accuracy with the dataset generated with the VLC VOD software.

Although during the implementation we have faced some minor setbacks, overall, developing our test bed on top of GStreamer framework turned out to be a wise decision and we strongly recommend it for similar work. The GStreamer-based tools we have developed are free for public access as well \[4\].

- References:
- Demirbilek, Edip, and Jean-Charles Grégoire. "Towards Reduced Reference Parametric Models for Estimating Audiovisual Quality in Multimedia Services." 2016 IEEE International Conference on Communications (ICC).
- Demirbilek, Edip, and Jean-Charles Grégoire. “The INRS Audiovisual Quality Dataset." 2016 ACM Multimedia Conference (accepted).
- Edip Demirbilek, “The INRS Audiovisual Quality Dataset.” (2016) GitHub repository, https://github.com/edipdemirbilek/TheINRSAudiovisualQualityDataset
- Edip Demirbilek, “GStreamer Multimedia Quality Testbed.” (2016) GitHub repository, https://github.com/edipdemirbilek/GStreamerMultimediaQualityTestbed

The work presented here has been conducted as part Edip Demirblek’s PhD research.

*Jean-Charles Grégoire holds a Bachelor’s degree in Electrical Engineering from the Faculté Polytechnique de Mons, Belgium, a Masters of Mathematics Degree from the University of Waterloo, Canada and a PhD Degree from the Swiss Federal Polytechnic, Lausanne, Switzerland. He is an Associate Professor at INRS, a constituent of the Université du Québec with a focus on research and education at the Masters and PhD level. His research explores different dimensions of the deployment of interactive applications over the Internet, including perfomance, quality and security.*

### SMPTE timecodes in GStreamer. Vivia Nikolaidou (vivia), ToolsOnAir {#smpte-timecodes}

This talk explains how to represent and use SMPTE timecodes in GStreamer. It explains the API, the internal representation, and the way to add timecode information to a frame, or extract from it. It then introduces the new elements created and the modifications made to existing ones, in order to cover some common use case scenarios: retrieving the timecode from a Decklink source or from a test clock, overlaying it on the video stream, waiting for a specific timecode to arrive, and sending the timecode information to a Decklink sink or to a file.

*Paraskevi Nikolaidou (also known as Vivia) is currently working as a GStreamer developer. She has been active in the Open Source community and has participated in various Free and Open Source projects since 2004 when she joined the Agent Academy project. Vivia has obtained her PhD in Electrical and Computer Engineering from the Aristotle University of Thessaloniki in 2011, where she worked on multi-agent systems as well as data mining methods in supply chain management. Her open source contributions range from SCCORI Agent which was part of her PhD studies, to her contributions to the GStreamer multimedia framework, passing by her involvement with the aMSN project during her spare time. She lives in Thessaloniki, Greece, where she is currently working remotely for ToolsOnAir, a company based in Austria that works with broadcast production software, working on their GStreamer-based platform. She likes ducks, green tea, learning foreign languages and playing the flute.*

### 3D Scanning. Jan Schmidt (thaytan), Centricular {#3d-scanning}

3D Scanning is the process of capturing a real-world object into a computer model for reproduction or modification. This talk is about one way to build them, and an implementation using GStreamer and a Raspberry Pi.

*Jan Schmidt has been a GStreamer developer and maintainer since 2002. He is responsible for GStreamer's DVD support, and primary author of the Aurena home-area media player. He lives in Albury, Australia and keeps sheep, chickens, ducks and more fruit trees than is sensible. In 2013 he co-founded Centricular - a consulting company for Open Source multimedia and graphics development.*

### Features detection plugins speed-up by ompSs@FPGA. Nicola Bettin, Vimar {#features-dectection-fpga}

Real-time processing of multi-media streams is widely necessary in many applications of Cyber-Physical System (CPS) where humans and the environment interact with each other. Smart Home systems are CPS in which the real-time processing of multi-media streams is required to correlate instantly the information extracted from the audio and video data to understand the situation inside the house as well as to enable a natural interaction between the user and his/her house.

These systems are normally made up as a decentralized system composed by embedded agents able to capture, process and send information to other agents inside the CPS. The type of tasks to be solved, the easy usability and the wide availability of the plug-ins, make the GStreamer framework an excellent candidate to be used within these embedded agents. To reach high level of performance and in the same time guarantee a low power consumption the embedded agents are designed with System on Chip (SoC) with multimedia hardware accelerators (like hardware video encoding and decoding) that are intensely used in the GStreamer plug-ins through different API (like VAAPI and OpenMAX).

In order to increase the set of operations speedup by hardware accelerators, in the context of the European AXIOM project, Vimar S.p.A has begun to explore the use of field programmable gate array (FPGA) devices. The SoCs used to design embedded agents could be extended using the FPGA-based SOCs (like the Xilinx family Zynq7000 and Ultra-Zynq) in which the heavier computational kernels involved in the streaming processing could be speedup by specific FPGA accelerators. Important issues related to this scenario are the complexity to develop FPGA accelerators and the development of the software infrastructure to use these accelerators.

To solve these issues we propose to use a new software infrastructure focused on the easy programmability, developed in the European AXIOM project. This software infrastructure extends the ompSs Programming model to allow the use of the FPGA in the SoCs. Vimar S.p.A is working to develop a GStreamer plug-ins taking advantage of the computation power of the FPGA device and the easy programmability of the ompSs program model.

- References:
- [AXIOM Project](http://www.axiom-project.eu/)
- [Vimar S.p.A.](http://www.vimar.com)
- [ompSs Programming Model](https://pm.bsc.es/ompss)
- [Xilinx Zynq Family](http://www.xilinx.com/products/silicon-devices/soc.html)

*Nicola Bettin earned his B.S degree in Electronic Engineering at University of Padua and in 2011 he obtained his M.S degree in Electronic Engineering at University of Bologna. In 2012 he joined the Tecnology Transfert Team T3LAB, in Bologna, and co-founded the FPGA Group. He did research in the design of a standard HW/SW architecture for machine vision and developed commercial solutions for processing multimedia data stream in embedded systems.  His main interests were FPGA solutions and heterogenic multi-core system-on-chip solutions. He joined the electronic R&D dept. at Vimar Group in 2015 and his research activity is mainly focused on human interaction with smart home systems.*

### The GStreamer Developers Show. Hosted by Luis de Bethencourt (luisbg) {#gst-dev-show}

Join us in a lively panel discussion with some of the developers of GStreamer!

*Luis de Bethencourt is a freedom-loving technocrat, who currently works for Samsung's Open Source Group in London. He has always enjoyed programming and playing around with video, so since he discovered GStreamer 5 years ago he's been hooked. Originally from the Canary Islands, computers felt like a door to the world. Luis saw open source software as the best way to enter the innovative technology community, see how it all works, and become a part of it. He enjoys being in front of the screen, behind the screen, Friday beers, Sunday ice-creams, walks in the park, and people who read bios to the end.*
