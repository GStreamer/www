---
title: "GStreamer Conference 2017 - speaker biographies and talk abstracts"
year: 2017
type: "conference"
---

## Prague, Czech Republic, 21-22 October 2017

[Back to conference main page](/conference/)

[Back to conference timetable](schedule.html)

### GStreamer State of the Union. Tim-Philipp Müller (\_\_tim), Centricular {#state-of-the-union}

This talk will take a bird's eye look at what's been happening in and around GStreamer in the last twelve months and look forward at what's next in the pipeline.

*Tim Müller is a GStreamer core developer and maintainer, and backseat release manager. He works for Centricular Ltd, an Open Source consultancy with a focus on GStreamer, cross-platform multimedia and graphics, and embedded systems. Tim lives in Bristol, UK.*

### Implementing Zero-Copy pipelines in GStreamer. Nicolas Dufresne (ndufresne), Collabora {#zero-copy-pipelines}

With the wide variety of hardware and their various restrictions, implementing zero-copy in GStreamer can be difficult. In this talk, I would like revisit the mechanisms in place to help implement such pipeline and explain how this is being used in various context. I will also try to explain some of the well known and recently found traps that can lead to difficult to debug issues. This talk is addressed to plugin developers interested in enabling zero-copy while keeping GStreamer flexibility.

*Nicolas Dufresne is a Principal Multimedia Engineer at Collabora. Based in Montréal, he was initially a generalist developer with background in STB development. Nicolas started in 2011 contributing to GStreamer Multimedia Framework adding infrastructure and primitives to support accelerated upload of buffers to GL textures. Today, Nicolas is implicated in both GStreamer and Linux Media communities to help create a solid support for CODEC on Linux.*

### Audio Mixing with the new audiomixer element. Stefan Sauer (ensonic), Google {#audiomixer}

For a long time adder has been the only audio mixing solution in GStreamer. 3 years ago the work on the new aggregator based elements started. This talk will describe the feature-space for audio mixing and report on recent improvements. I will compare the audioixer with the traditional adder to explain how both approach differ.

*Stefan is a software engineer working for Google on build infrastructure tools. In the past he was working for Nokia on the multimedia stack used on their maemo/meego internet tablets and phones. In his free time his is contributing to GStreamer, other GNOME projects (e.g. gtk-doc) and working on his music editor buzztrax. He has a PhD in Human Computer Interaction from the Technical University of Dresden/Germany. Stefan now lives in Munich/Germany with his wife and his two kids.*

### Synchronised Playback Made Easy. Arun Raghavan (Ford_Prefect) {#synchronised-playback}

Over the last few years, GStreamer has seen several improvements to achieve fairly tight synchronised playback across devices on a network.

Despite this, using this in applications requires a fair amount of knowledge of GStreamer itself, which is not ideal. The gst-sync-server library aims to address this gap, making it easy to write applications such as video walls, multi-room audio, and more.

In this talk, I'll cover the motivation for this library, some of the design choices that make it extensible, and some comments on what else we need to make writing these apps extremely easy.

*Arun is a maintainer of the PulseAudio audio server and a GStreamer contributor. He enjoys working in the lower layers of the system stack, long walks on the beach, and thinking about the impact of modern type-safe languages on software development.*

### So you think you can FEC? Erlend Graff & Mikhail Fludkov, Pexip {#fec}

Forward error correction (FEC) is a seemingly simple idea when the sender adds redundant data during transmission for the receiver to be able to recover from packet loss.

This talk covers challenges faced when implementing FEC for RTP media in the GStreamer eco system; ranging from an architectural discussion on how to implement support for standards such as ULPFEC and Flux FEC (used in WebRTC) and integrate it with GstRtpBin, down to interesting aspects of the Reed Solomon algorithm (used in Skype).

*Mikhail Fludkov is originally from a small Siberian town, Bratsk. He graduated from Saint-Petersburg State Polytechnic University with a masters degree in computer science. Worked on H.264 & H.265 codecs in Vanguard Software Solutions, in Saint Petersburg. 3 years ago moved to Oslo after joining Pexip where got acquainted with GStreamer framework for the first time. Worked on GStreamer elements supporting various standards for Forward Error Correction and on network resilience in general. Participated in porting Pexip media stack from GStreamer 0.10 to GStreamer 1.x. In his free time bakes sourdough bread and plays computer games.*

*Erlend Graff is a software engineer with an MSc degree in computer science from the University of Tromsø, Norway. He currently works for Pexip, where he's been having fun with various video conferencing related technologies for more than two years.*

### GStreamer WebRTC. Matthew Waters (ystreet00), Centricular {#gstreamer-webrtc}

WebRTC. Your web browser supports it (or soon will). Let's use GStreamer to stream with web browsers!

A look into the concepts of WebRTC, the current ecosystem, and a showcase of a new native implementation for transporting media adhering to the WebRTC specifications covering a wide variety of use cases from peer-to-peer streaming, gateways, and streaming servers.

*Matthew Waters is the principal maintainer of the OpenGL integration with GStreamer from the start of GStreamer 1.x and has integrated GStreamer's OpenGL library with many other decoding, encoding and rendering technologies. He's also played around extensively with Vulkan, a new high-performance, cross-platform 3D graphics API. Lately he's been working on a new WebRTC stack for GStreamer.*

*Matthew is a Multimedia and Graphics developer for Centricular Ltd, an Open Source consultancy focusing on GStreamer, embedded systems and cross-platform multimedia and graphics.*

### Aligning audio and video streams' start and end. Vivia Nikolaidou (vivia), ToolsOnAir {#aligning-audio-video}

Sometimes, even though we get audio and video from sources of dubious quality, they must be configured to start and end at exactly the same time. This is extremely non-trivial in the GStreamer architecture, where they run in completely different threads (instead of, say, packaging audio together with video), and requires several tricky tweaks in several parts of the pipeline. In my talk, I'd like to illustrate how this is done in the ToolsOnAir media engine.

*Paraskevi Nikolaidou (also known as Vivia) is currently working as a GStreamer developer. She has been active in the Open Source community and has participated in various Free and Open Source projects since 2004 when she joined the Agent Academy project. Vivia has obtained her PhD in Electrical and Computer Engineering from the Aristotle University of Thessaloniki in 2011, where she worked on multi-agent systems as well as data mining methods in supply chain management. Her open source contributions range from SCCORI Agent which was part of her PhD studies, to her contributions to the GStreamer multimedia framework, passing by her involvement with the aMSN project during her spare time. She lives in Thessaloniki, Greece, where she is currently working remotely for ToolsOnAir, a company based in Austria that works with broadcast production software, working on their GStreamer-based platform. She likes ducks, green tea, learning foreign languages and playing the flute.*

### Enabling Cross-Platform Development on macOS and Windows with Meson. Nirbheek Chauhan (nirbheek), Centricular {#meson-macos-windows}

Historically, GStreamer has relied on the Cerbero build system for continuous integration as well as binary releases for various platforms, and is the only supported way to build GStreamer on Windows and macOS.

However:

1.  Autotools (and hence Cerbero) can only build with MinGW on Windows and almost everyone seems to want to build with Visual Studio.
2.  Doing GStreamer development with Cerbero is a terrible hack, and the method itself is undocumented.

This means we have a very high barrier to entry for Windows and macOS developers, and as a result our platform-specific elements have lagged behind our Linux-specific and platform-agnostic ones.

In this talk, I will talk about how having Meson support in GStreamer allows Cerbero to build it with the MSVC toolchain on Windows and how Meson's subproject feature is being used in a new cross-platform gst-uninstalled implementation to empower macOS and Windows developers.

I will also talk about the work we're doing to let Windows developers build GStreamer and hack on it from inside Visual Studio.

*Nirbheek Chauhan writes software and hacks on GStreamer for a living and for fun. In recent times and despite his best efforts, he accidentally became a build system expert and continues to contribute to the Meson build system as a core contributor. When not fixing broken builds, he works on interesting WebRTC applications using GStreamer and complains about how slow Rust adoption is.*

### Photobooth: An exemplary multi-disciplinary project. Andreas Frisch (fraxinas), make.tv {#photobooth}

A Photobooth is an automatic unit that takes photos with a DSLR camera, shows a preview on a touchscreen and allows users to print them. The Schaffenburg Hackerspace designed and built such a machine from scratch.

In this presentation, I will talk about our motivation for starting such a big hobbyist project. Covered topics include:

- evaluation + selection of the used hardware and software components
- building the wooden case and 3d-printing parts
- using Arduino for effect lighting
- setting up the camera and external flash
- focus on the gstreamer- / gtk-based software
- demonstration
- problems and prospects

*Andreas aka "Fraxinas" in the FOSS world, graduated from the University of Applied Sciences in Aschaffenburg with a degree in electrical engineering and information technology. Formerly employed by Dream Multimedia, the company which released the first Linux-based STB called "Dreambox", he now works for SMT make.tv, with their Live Video Cloud. Specialized in Embedded Linux, GStreamer programming and streaming. Founding member of Aschaffenburg's Repair Café and monthly television appearance as the "Repairfox" in Germany's ARD Buffet. Passionately tinkering in the Schaffenburg Hacker/Makerspace. LGBT Youth activist, musician and Japanese learner.*

### GST-MFX: Full-Featured, High Performance and Cross-Platform GStreamer Plugins Using Intel Media SDK. Ishmael Sameen; Xavier Hallade, Intel {#gst-mfx}

This talk presents GST-MFX, a set of GStreamer plugins that uses Intel Media SDK (MSDK) to perform high performance decode, encode, video post-processing (VPP) and rendering for both Windows and Linux platforms.

GST-MFX addresses a key segment of application developers who wish to develop media-based cross-platform applications for both Windows and Linux while getting the very best performance from utilizing MSDK, which in itself is a sophisticated, proprietary media API that is highly-optimized for Intel's platforms starting from 3rd generation Intel Core processors. MSDK is also very well-supported and has comprehensive documentation on its capabilities all the way down to low-level codec performance finetuning.

We first intend to talk about the motivation of this work, and then the very promising value it brings to the table to the GStreamer ecosystem. We then discuss some of best features that GST-MFX has, and compare it to existing alternative GST-MSDK implementations, as well as GST-VAAPI.

Finally, we will briefly summarize the architecture and implementation details which allowed us to achieve the current state of GST-MFX, and where it stands in terms of production-level software. You can check out the latest ongoing development of GST-MFX from here:

- https://github.com/01org/gstreamer-media-SDK/tree/topic_linux_and_window
- https://github.com/ishmael1985/gstreamer-media-SDK
- https://github.com/ph0b/gstreamer-media-SDK

*Ishmael Sameen is a former Intel software developer and currently a PhD research student at University Paris XIII, whose main interests lie in doing cool stuff and applying real-world solutions in the area of image and video processing. He has worked (and is still working with a few) with various technologies such as nVidia CUDA, Altera FPGAs, FFMPEG, QT, Intel Media SDK, etc., but only recently touched GStreamer two years ago for a customer requirement (after trying to unsuccessfully convince them to use FFMPEG). Since then, he enjoys working with the GStreamer framework and learning from their codebase, even after having left Intel to pursue his research interests in neural networks for computer vision.*

*Xavier Hallade is an Application Engineer at Intel, focused on improving 3rd party applications performance and features for upcoming PC platforms. He’s been helping customers integrate video hardware acceleration in their Windows applications several times over the past year, and decided to scale this work by contributing to the GStreamer framework.*

### GStreamer in the world of Android Camera3 cameras. Olivier Crête (ocrete), Collabora {#android-camera3}

New SoCs include camera modules that comply with the Android Camera3 API, this includes multiple features that are not currently well handled by GStreamer. I will propose a roadmap that can allow us to support those.

*Olivier Crête has been involved in free software since 2000. He has been involved in GNOME since 2003 and in Gentoo from 2003 to 2012. He currently works for Collabora, where he leads the multimedia team. He's been an active GStreamer developer since 2007, first working on VoIP and video calls, but lately he's been working on all kinds of multimedia projects.*

### Network Music Performance: A case study using GStreamer. Kostas Tsioutas, Ionian University Corfu {#network-music}

Network Music Performance is happening when two or more musicians perform their music using their internet connection and stream their audio through the network as everyone of them is placed in his own residence. We implemented such experiments using Gstreamer open framework over the University Campus Network and we measured audio delay using varius compression codecs.

*Konstantinos Tsioutas is a PhD Candidate at the Audio and Visual Arts Department of Ionian University. His thesis concerns the QoS of Network Music Performance Service and audio compression delay issues. He holds a master's degree in the field of telecommunications and networking and a master's degree in the field of audio design and composition.*

### GStreamer Daemon - building a media server in under 30 minutes. David Soto, RidgeRun {#gstreamer-daemon}

GStreamer is modular, extensible and flexible - but not easy to properly use the GStreamer API. GStreamer provides all the necessary capabilities to build a fully functional production quality multimedia server, but getting it right requires good framework understanding, GLib/GObject handling and in most cases good debugging skills. A bad dynamic pipeline handling can result in unexpected behaviours or even complete pipeline stalls. GStreamer Daemon is an OpenSource project by Ridgerun that encapsulates GStreamer complexity in a standalone process, exposing a simple high-level API for real-time multimedia handling.

Pipelines can be created in a fashion similar to gst-launch. decoupling the streamer media logic from the application logic, allows you to focus on what makes your product unique.

This talks demonstrates a fully functional media server being created in under 30 minutes using GStreamer Deamon. The server will be built in a NVIDIA Tegra X1 embedded platform using the built-in HW accelerated codecs. The media server state will be modified at runtime, along with different streams being safetly activated/deactivated, without the need of transcoding nor interrupting the rest of the streams. Camera capture, video recording, taking snapshots, network streaming and playback trick-play are easy using GStreamer Daemon.

*David Soto is the Engineering Manager at RidgeRun and a senior embedded software engineer working on Linux and GStreamer since 2010. David has a master degree in digital signal processing and loves looking for efficient ways to get embedded systems running multimedia, computer vision and machine learning algorithms for broadcasting, security, consumer and medical products.*

### Video over the Data Distribution Service (DDS) using GStreamer. Stefan Kimmer, S2E Software, Systems and Control {#video-over-dds}

The Data Distribution Service is an emerging middleware that is used more and more in industry. An advantage is that for example multiple receivers can subscribe to one sender letting the middleware take care of the data distribution. The communication can be configured in so called Quality of Service settings to allow the adaption of the system to the network structure to where the application is deployed without recompiling. It is for example also possible to have multiple senders of video where one these is the preferred publisher and others are redundant and take over in case the preferred one fails. Multiple implementations of the DDS standard from various vendors exists thereunder also community editions that are open source.

We developed a demonstration application that showcases the usage of GStreamer with DDS in a cross-platform fashion. This allows the development and deployment of the application for Windows and embedded Linux from host-system. As such a redundant pair of camera devices can distribute the video of a wireless network to multiple receivers using different operating systems.

More infos: <http://www.s2e-systems.com/our-projects/videooverdds/>.

*Stefan was working with the European Space Agency (ESA) where he used GStreamer to develop the transport of video from earth to space. Meanwhile he founded his own company S2E Software, Systems and Control together with a colleague also from ESA.*

### PipeWire. Wim Taymans (wtay), RedHat {#pipewire}

PipeWire is a multimedia API that makes it easier to build distributed multimedia pipelines. It was originally built to provide shared access to cameras but it can also be used to build a variety of multimedia services such as a sound server.

PipeWire is built on top of a new low-level plugin API (SPA for Simple Plugin API) that is designed to be simple and suitable for hard real-time processing.

In this presentation I want to talk about the design ideas, the current status and the future plans for PipeWire. I will also give a small demo.

*Wim Taymans has a computer science degree from the Katholieke Universiteit Leuven, Belgium. He co-founded the GStreamer multimedia framework in 1999. Wim Taymans is a Principal Software Engineer at Red Hat, responsible for various multimedia packages and is currently working on PipeWire.*

### Media Source Extensions on WebKit using GStreamer. Enrique Ocaña González (eocanha), Igalia {#mse-on-webkit}

The Media Source Extensions HTML5 specification allows JavaScript to generate media streams for playback and lets the web page have more control on complex use cases such as adaptive streaming.

This talk starts with a brief introduction about the motivation and basic usage of MSE. Next we will show a design overview of the WebKit implementation of the spec. Then we'll go through the iterative evolution of the GStreamer platform-specific parts, as well as its implementation quirks and challenges faced during the development. The talk continues with a demo, some clues about the future work and a final round of questions.

*Enrique is a Software Engineer at Igalia with experience in multimedia, open source web engines and embedded devices. He has several contributions to the WebKit and GStreamer projects and has been working for 3 years on topics related multimedia in GStreamer-based WebKit ports, with a special focus on Media Source Extensions.*

### Lightning Talks

Lightning talks are short talks by different speakers about a range of different issues. We have the following talks scheduled so far (in no particular order):

- A big year for Video4Linux2 support in GStreamer  
  *Nicolas Dufresne, Collabora*
- GstGPGPU - GstCUDA and GstOpenCL  
  *Angel Phillips, RidgeRun*
- Playbin3/decodebin3 status update  
  *Edward Hervey, Centricular*
- GStreamer and OpenCV using a GstOpenCV element  
  *Angel Phillips, RidgeRun*
- RTP Bundle Support  
  *Håvard Graff, Pexip*
- ipcpipeline - Split a pipeline into multiple processes  
  *George Kiagiadakis, Collabora*
- GstPriQueue[1](https://github.com/pexip/gstreamer/commit/b466a7d0d930b359bccd05109d3a54824edbf867)  
  *Erlend Graff, Pexip*
- DAMPAT: Dynamic Adaptation of Multimedia Presentations in Application Mobility  
  *Francisco Velázquez, University of Oslo*
- gst-debugger is still a thing!  
  *Marcin Kolny, Amazon*
- GStreamer-sharp: the revival of our .net bindings  
  *Thibault Saunier, Samsung*
- GStreamer support for RTSP protocol version 2.0 (the first implementation ever!)  
  *Thibault Saunier, Samsung*
- Pitivi 1.0 finally on sight!  
  *Thibault Saunier, Samsung*
- Using GStreamer for UAV Computer Vision Applications in Consumer and Commercial Spaces  
  *Braden Scothern and Matt Stoker, Teal Drones*
- Alternative RTMP implementation  
  *Jan Alexander Steffens, make.tv*
- A source element for Android Camera 2 NDK API  
  *Justin Kim, Collabora*
- GStreamer DVR for deploying mpeg-dash format  
  *채창복 (Changbok Chea), LGE*
- GStreamer debugging device for computer vision  
  *Hermann Stamm-Wilbrandt*

**Lightning talk speakers**, please export your slides into a PDF file and either send it to Tim by e-mail (you will receive an e-mail from him about your lightning talk before the event) or have it ready on a usb stick before the start of the lightning talks on Saturday. The idea is that everyone uses the same laptop so that we don't waste time hooking up laptops to the projector and configuring them. There is no particular order or schedule for the talks. When a speaker is called up, we will also mention who is up next. Every speaker has up to ca. 5 minutes for their talk. There will be a countdown timer running. It's not possible to go over time, you'll have to finish up so that everyone has an opportunity to present their talk. If you don't want to use up the full 5 minutes, that's fine as well.

### GstShark profiling: a real-life example. Michael Gruner, RidgeRun {#gst-shark-profiling}

GstShark is a profiling and benchmarking tool for GStreamer pipelines. GstShark is an ongoing OpenSource project by RidgeRun which serves as a front-end for the GstTrace subsystem. GstShark presents raw traces as higher level data such as scheduling and processing time, bitrate, framerate, CPU usage and much more. This data is saved in a standard low-footprint format designed for efficient tracing. The captured data can be plotted and visualized using the tools included in the project, as well as third party tools. GstShark is the result of years of experience tuning and optimizing GStreamer pipelines in resource-limited systems and is key tool RidgeRun engineers use to dispel the myth that GStreamer is slower that an inflexible custom created streaming media application.

In this session GstShark will be used to optimize a low-performance WebRTC streaming pipeline in an NVidia Tegra embedded platform. It will be shown how the different measurements can be used to identify processing bottlenecks, sources of latency and general scheduling problems. By using comprehensive data plots, the pipeline internals are exposed, revealing information before hidden and allowing you to tune pipelines in a more informed, deterministic way.

*Michael Grüner is the Tech Leader at RidgeRun, a GNU/Linux based embedded software development company. GStreamer and multimedia have been his main areas of focus. Michael has a masters degree in Digital Signal Processing and, among other interests, likes OpenGL, CUDA, OpenCL. Michael is always looking for ways to implement efficient, real-time DSP algorithms using GStreamer on embedded platforms.*

### Moar Better Tests. Håvard Graff (hgr), Pexip {#moar-tests}

"*The quality of testing in a codebase is directly proportional to the quality of its functionality*" - Albert Einstein.

This talk will discuss how to write short, concise tests for complex scenarios while maintaining readability. We will show concrete examples of how to use GstHarness efficiently in different situations, testing a src/sink, a muxer/demuxer, an encoder/decoder etc, and how to further harness harnesses to create even better test infrastructure.

*Håvard Graff has worked with GStreamer professionally for 9 years in Tandberg, Cisco and now Pexip. Developing video conferencing systems like Movi, Jabber Video and Pexip Infinity using GStreamer as the backbone. Was instrumental in premiering GStreamer in the AppStore. Still pretends to be a musician with programming as a hobby.*

### The GStreamer-VAAPI report. Víctor M. Jáquez L. (ceyusa), Igalia {#gst-vaapi}

GStreamer-VAAPI is a set of GStreamer elements (vaapisink, vaapipostroc, and a set of encoders and decoders) using the VA-API software stack that aims for hardware accelerated video processing.

The purpose of this talks is to show the progress done along this last year and discuss with the community the following tasks.

*Víctor started to work in GStreamer in 2006, on an initial implementation of GStreamer elements wrapping OMX components. Later on, he moved to other related projects such as the WebKit, Ekiga, etcetera. He later returned to the GStreamer arena, helping with gstreamer-vaapi.*

### Oxidising GStreamer: Rust out your multimedia! Sebastian Dröge (slomo), Centricular {#rust}

As a continuation of my talk last year, this year I will give an update of what happened with Rust support for GStreamer based applications and plugins.

Now is the right time to get started with writing your GStreamer code in Rust instead of C/C++ or even Python/C# for improved safety & productivity and hopefully fun writing the code, while still having the high performance and low overhead usually only known from C/C++ and being able to run your code on small embedded devices.

While learning a new language might not seem worthwhile and there are just too many languages anyway, I will show you why you should care and why the language seems like the perfect fit for multimedia related applications and many other embedded use cases. And how you can get started, including some short code examples.

*Sebastian Dröge is a Free Software developer and one of the GStreamer maintainers and core developers. He has been involved with the project since more than 10 years now. He also contributes to various other Free Software projects, like Debian, GNOME and WebKit. While finishing his master's degree in computer sciences at the University of Paderborn in Germany, he started working as a contractor for GStreamer and related technologies. Sebastian is one of the founders of Centricular, a company providing consultancy services, where he's working from his new home in Greece on improving GStreamer and the Free Software ecosystem in general.*

*Apart from multimedia related topics, Sebastian has an interest in digital signal processing, programming languages, machine learning, network protocols and distributed systems.*

### Linux Explicit DMA Fences in GStreamer. Nicolas Dufresne (ndufresne), Collabora {#dma-fences}

This talk will cover the use of the explicit DMA Fence in multimedia pipelines and how these fences can be used to improve smoothness and reduce latency in your streaming application. We will also outline how we plan to integrate these new kernel object in GStreamer framework.

*Nicolas Dufresne is a Principal Multimedia Engineer at Collabora. Based in Montréal, he was initially a generalist developer with background in STB development. Nicolas started in 2011 contributing to GStreamer Multimedia Framework adding infrastructure and primitives to support accelerated upload of buffers to GL textures. Today, Nicolas is implicated in both GStreamer and Linux Media communities to help create a solid support for CODEC on Linux.*

### Preparing GStreamer for high packet-rate video streaming. Tim-Philipp Müller (\_\_tim), Centricular {#high-packet-rate-video}

As the broadcast and film industry moves towards IP-based workflows such as SDI-over-IP, with ever-increasing video resolutions, frame rates and pixel depths, data rates in the tens of Gbps and packet rates in the hundreds of thousands if not millions are no longer inconceivable, but rather inevitable.

Similarly, the emergence of RTP-based WebRTC as de-facto standard for live streaming to web browsers means streaming media at high bitrates to hundreds or thousands of clients will be increasingly common or in demand.

This poses challenges pretty much everywhere in the multimedia pipeline, from capture to processing to sending.

This talk will look at the demands of processing media streams with a very high packet rate in GStreamer and will propose some solutions.

*Tim is a GStreamer core developer and maintainer, and backseat release manager. He works for Centricular Ltd, an Open Source consultancy with a focus on GStreamer, cross-platform multimedia and graphics, and embedded systems. Tim lives in Bristol, UK.*

### Efficient Video Processing on Embedded GPU. Kammacher Tobias, Zurich University of Applied Sciences {#efficient-video-on-embedded-gpu}

Learn how to develop and test a 4K video processing and streaming application on the NVIDIA Jetson TX1/TX2 embedded platform with GStreamer. To achieve real-time video processing, the diverse processing resources of this high-performance embedded architecture need to be employed optimally.

The heterogeneous system architecture allows capturing, processing, and streaming of video with a single chip. The main challenges lie in the optimal utilization of the different hardware resources of the Jetson TX1 (CPU, GPU, dedicated hardware blocks) and in the extensive software stack (from Linux drivers to GStreamer application).

We'll discuss variants, identify bottlenecks, and show the interaction between hardware and software. Simple capturing and displaying video from the built-in camera can be achieved using out-of-the-box methods. However, for capturing 4K from HDMI we had to dig into the documentation, rewrite the drivers for the Video capture system, write a driver for an external HDMI to CSI converter and figure out efficient zero-copy methods. GPU-based enhancements were developed and integrated for real-time video processing tasks (scaling and video mixing).

Blog post about the drivers: <https://blog.zhaw.ch/high-performance/2016/06/01/open-source-driver-for-hdmi2csi-module-released/​>

*Tobias Kammacher has worked for the last three years in the High Performance Multimedia and Data Acquisition Research Group in the Institute of Embedded Systems at Zurich University of Applied Sciences. He and his colleagues carry out research projects with industry partners, focused on implementing signal and video processing applications on SoC, FPGA, and mixed architectures. Tobias received his B.S. in electrical engineering and M.S. in engineering.*

### VA-API rust-binding. Hyunjun Ko (zzoon), Igalia {#vaapi-rust}

GStreamer VA-API has been supporting to use H/W accelleration when you're enjoying video playback, streaming and even transcoding on Linux. This project has been developed actively and still keep improving its features/performance/stability.

In this talk I will give an overview of the current status of VA-API Binding to Rust, my experience with Rust so far, what problems I encountered and what is already possible today.

In the end, we're going to talk about how to integrate into gst-plugins-rs with showing demo of vaapisink plugin written by Rust as an example.

*Hyunjun started to work on GStreamer in 2013. He had been working on implementation of Wi-Fi Display using GStreamer and now he's a regular contributor of GStreamer VA-API project since he joined Igalia.*

### AV1: The Quest is Nearly Complete. Thomas Daede, Mozilla {#av1}

AV1 has gained many features over the past year, and the end is finally in sight! This talk will cover the progress that has been made over the last year on this royalty-free video codec. It will also cover the remaining work to be done in preparing to deploy this new format across the web.

*Thomas Daede is a Video Codec Engineer at Mozilla.*

### GStreamer is in the air. Jan Schmidt (thaytan), Centricular {#in-the-air}

It's everywhere you look around. At least, everywhere I look around - I may be atypical.

In 2013, I gave a presentation titled "My GStreamer-Enabled Home". Since the conference is re-visiting the past this year in Prague, I thought I would too. So this year, I'm talking about a bunch of best ways I've used or seen people using GStreamer.

Come along and see how GStreamer is in the air, in every sight and every sound (\*) (\*\*)

\* Apologies to John Paul Young.

\*\* GStreamer may not actually be in every sight and every sound (yet).

*Jan Schmidt has been a GStreamer developer and maintainer since 2002. He is responsible for GStreamer's DVD support, and primary author of the Aurena home-area media player. He lives in Albury, Australia and keeps sheep, chickens, ducks and more fruit trees than is sensible. In 2013 he co-founded Centricular - a consulting company for Open Source multimedia and graphics development.*

### Of GStreamer, containers, QA and fuzzing. Edward Hervey (bilboed), Centricular {#containers-qa-fuzzing}

While some would say that containers are just "yet-another" linux system, the way they are used and the opportunities involved provide interesting challenges for the GStreamer project.

In this talk, we will go over how the re-usability, reproducibility and fast startup time of containers help the GStreamer project. In a first step we will look at the maintainer/contributor side of things, with the Continuous Integration setup and providing high(er) Quality Assurance. This will essentially see how one can automate as much as possible with containers to provide easier/faster testing environment and regression detection.

In a second step we will go over what is needed to make the most out of containers, such as providing the smallest container possible for GStreamer-based projects. This will dabble into static builds, re-using 3rd party libraries and the pitfalls encountered along the way. One of the example we will go over is how to integrate into the google [oss-fuzz](https://github.com/google/oss-fuzz) project.

*Edward Hervey has been contributing to the GStreamer project for the past 14 years, from core components to high-level projects such as the pitivi video editor. Currently a Senior Engineer at Centricular, he has helped numerous clients in current and past companies to make the most out of GStreamer in various areas. He is currently in charge of Continuous Integration and overseeing QA infrastructure for the GStreamer project.*

<a id="bof2"></a><a id="bof3"></a><a id="bof4"></a>
### BoFs / workshops {#bof1}

These are opportunities for interested people to suggest or organise working groups or get-togethers for a particular topic.
