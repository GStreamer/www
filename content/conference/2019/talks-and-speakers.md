---
title: "GStreamer Conference 2019 - speaker biographies and talk abstracts"
year: 2019
type: "conference"
---

## Lyon, France, 31 October - 1 November 2019

[Back to conference main page](/conference/2019/)

[Back to conference timetable](schedule.html)

### GStreamer State of the Union. Tim-Philipp Müller (\_\_tim), Centricular {#state-of-the-union}

This talk will take a bird's eye look at what's been happening in and around GStreamer in the last twelve months and look forward at what's next in the pipeline.

*Tim is a GStreamer core developer, maintainer, and release manager. He works for Centricular Ltd, an Open Source consultancy with a focus on GStreamer, cross-platform multimedia and graphics, and embedded systems. Tim lives in Bristol, UK.*

### 3D Cameras in GStreamer: RGB-D Camera Support and Depth Video Compression. Raphael Dürscheid, Aivero {#3d-cameras}

Since the release of the famous Kinect camera in 2010 3D, Depth or RGB-D cameras have enjoyed great popularity in the research robotics and tinkering scene. The recent excitement around autonomous driving, as well new(-ish) additions such as the Intel Realsense camera series and the new Azure Kinect are bringing 3D data into the professional and industrial space.

New 3D cameras are popping up like weeds, often with their own interfaces based on their own standards and proprietary libs. What all of them have in common is the vast amount of data being generated, lacking effective tools for compression.

This talk introduces our work on the open source \`realsensesrc\`, \`k4asrc\` as well as \`rgbd\` caps interface and our proprietary depth compression - developed using the GStreamer Rust bindings.

*Raphael is tech lead for Aivero, where he and his colleagues are building services for scaling depth video in industrial robotics applications. He is a fan of GStreamer on Rust and the conan package manager.*

### Introduction to Validateflow. Alicia Boya García (ntrrgc), Igalia {#validate-flow}

validateflow is an upstream plugin for gst-validate that records buffers and events from arbitrary pipelines and validates them against expectation files. It provides a new effective way to test non-regular- playback use cases without extensive coding. Topics covered include:

- Overview of existing validating techniques for GStreamer
- How validateflow fits and compares to other techniques
- Basics of gst-validate
- Testing procedure with validateflow
- How to fit all together: pipelines.json
- Examples of what can be done

*Alicia Boya is a software engineer working in Spain. Starting early with a generalistic background, nowadays she works at Igalia as part of the Multimedia Team where she is dedicating most of her work to the MediaSource Extensions implementation of WebKit for the GStreamer- based ports (WPE and WebKitGTK).*

### GStreamer Video Analytics: Optimizing inference across HW targets. Neelay Shah, Neena Maldikar, Mikhail Nikolsky & Ilya Belyakov, Intel {#video-analytics}

Intel has recently open sourced a set of [video analytics plugins](https://github.com/opencv/gst-video-analytics) based on the OpenVINO inference engine. These plugins provide an easy way to add neural net based analytics (object detection, classification, identification, etc.) to GStreamer pipelines in a way that is optimized across different HW types (CPU, GPU, VPU, FPGA). In this talk we will describe how the plugins are designed and how to use and customize them in applications. We are excited to demonstrate these new capabilities as well as solicit feedback from the community on the future roadmap.

*Neelay Shah is a software architect at Intel developing video analytics applications using GStreamer for use cases in smart cities, retail and broadcasting. Graduating from the University of Illinois at Urbana Champaign in 2006 with a master’s degree in computer science, he has worked at Intel for over 10 years on various projects including UPnP, context sensing and most recently visual computing.*

*Neena Maldikar is the product owner for GStreamer Video Analytics. She has a master’s degree in Computer Science from Portland State University. She has been working at Intel for the past 6 years. Before joining the Video Analytics team, she worked on bringing contextual awareness to PC platforms through new libraries, applications and the integration of new sensors.*

*Mikhail Nikolskii is the lead architect and developer of GStreamer Video Analytics. He has worked at Intel for over 15 years on various Intel software products. Mikhail has a master’s degree in Computer Science from Moscow State University*

*Ilya Belyakov is the engineering manager for GStreamer Video Analytics. He graduated from the State University of Nizhni Novgorod with a degree in computer science. He has worked at Intel for the past 7 years on various technologies including Intel(R) RealSense(TM) and advanced labeling tools to train autonomous driving algorithms.*

### HDR: Seeing the World As It Is. Edward Hervey (bilboed), Centricular {#hdr}

From its inception, the goal of video has been to convey to your eyes life at it is, to transport us to other places. While many advances throughout the ages (introducing color, more pixels, depth/3D, VR and more frames per second) have brought us closer to that feeling of being transported, it was still giving us a "clamped" view of what our eyes can actually perceive. And then came HDR.

The goal of this talk is to explain what "HDR" truly means and why it is so important (and not just a marketing term). Going from the basics of how we "see" the world, we will go over the challenges that had (and still have) to be overcome to allow us to see more of the world. Along the way we will go over what GStreamer (and the underlying stack/hardware) offers to bring us to that vision.

*Edward Hervey has been contributing to the GStreamer project for the past 15 years, from core components to high-level projects such as the pitivi video editor. Currently a Multimedia and Systems Architect at Centricular, he has helped numerous clients in current and past companies to make the most out of GStreamer in various areas.*

### TV Broadcast compliant MPEG-TS. Jan Schmidt (thaytan), Centricular {#broadcast-compliant-mpegts}

This talk will provide an overview of some of the complexities of the MPEG transport stream, and recent improvements in the GStreamer MPEG-TS muxer.

The changes to the muxer allow it to generate streams that pass many compliance checks - but there's more work to be done, and an important part of that is having a way to check for problems in the output streams.

*Jan Schmidt has been a GStreamer developer and maintainer since 2002. He is responsible for GStreamer's DVD support, and primary author of the Aurena home-area media player. He lives in Albury, Australia and keeps sheep, chickens, ducks and more fruit trees than is sensible. In 2013 he co-founded Centricular - a consulting company for Open Source multimedia and graphics development.*

### Karapulse - Writing a Karaoke Application in Rust. Guillaume Desmottes (cassidy), Collabora {#karapulse-karaoke}

Karapulse is a Linux karaoke player supporting CDG/MP3 as well as video files. It provides a self-served web application that singers can use with their phone to search for and queue their favorite songs. It's written in Rust and uses GStreamer for all its UI rendering.

In this talk I'll briefly present the application and share the experience I gained while writing it. I'll try to show how Rust has been a great and effective choice of technology thanks to the features offered by the language and its ecosystem. I'll also explain how Flatpak made packaging so convenient to ship such kind of applications to users.

*Guillaume has been working for more than 10 years at Collabora and been involved in various parts of the GNOME project. He's now part of Collabora's multimedia team and has gained great interest in the Rust language, hoping it will save him from having to use C for the upcoming next 10 years.*

### Revisiting RTP Jitter Buffer Timers. Nicolas Dufresne (ndufresne), Collabora {#rtp-jitterbuffer-timers}

The rtpjitterbufer in GStreamer serves a major role in any type or RTP receivers, but is often by far the highest CPU consumer. In this talk, Nicolas will tell his journey through unknown fields that eventually lead to a major rework of the RTP Jitter Buffer timer code.

This talk is addressed toward developers interested in efficient multi-threaded application and the importance of a good design to avoid scheduling performance traps. RTP knowledge is optional.

*Nicolas Dufresne is a Principal Multimedia Engineer at Collabora. Based in Montréal, he was initially a generalist developer with background in STB development. Nicolas started in 2011 contributing to GStreamer Multimedia Framework adding infrastructure and primitives to support accelerated upload of buffers to GL textures. Today, Nicolas is implicated in both GStreamer and Linux Media communities to help create a solid support for CODEC on Linux.*

### GStreamer, PulseAudio and Compress Offload. Arun Raghavan (Ford_Prefect), nilenso systems {#pulseaudio-compress-offload}

Modern systems often have a DSP in the audio path between the CPU and the DAC, and this hardware can be used to implement power-efficient audio decoders. On such systems, compressed data (AAC, MP3, etc.) can be sent from the CPU to the audio hardware and be decoded and rendered more efficiently than if decoding was done on the CPU.

While the ALSA layer has had support for this via the "compress offload" API for a while, the upper layers of the Linux audio stack have not. In this talk, I will go through some of the work done to allow applications to transparently leverage such hardware capabilities via PulseAudio and GStreamer.

*Arun is a maintainer of the PulseAudio audio server and a GStreamer contributor. He enjoys working in the lower layers of the system stack, long walks on the beach, and thinking about the impact of modern type-safe languages on software development.*

### Building a Crowdsourced News Service with GStreamer. Paul Calleja, GlobalM & Mart Raudsepp (leio), LeioTech {#crowdsourced-news}

GlobalM is a news and sports content crowdsourcing service. Our live and file based services are heavily based on GStreamer. GlobalM uses GStreamer in the following ways:

- Mobile: running a GStreamer pipeline on both Android and iOS for live streaming using SRT
- Streaming Gateway: GStreamer is used to redistribute live streams to GlobalM customers in our cloud environment
- Transcoding pipelines: all live streams are transcoded to HLS for previewing within the GlobalM applications as well as being transcoded to high quality files for later download. Files uploaded to GlobalM are transcoded and published to the platform as preview, proxy or high quality file downloads.

We would like to present the use cases for GStreamer in the GlobalM platform, how we have used GStreamer to meet our end to end media workflow requirements, what challenges we have faced, and what shortcomings we see that are still to be solved for GStreamer.

*Paul Calleja graduated from the Royal Melbourne Institute of Technology with a diploma of Audiovisual systems in 2003. Paul has worked for many leading broadcasting networks including the BBC, Sky and the EBU. Now CTO and Co-Founder of GlobalM, a news and sports crowdsourcing application with professional live and file based delivery methods built in.*

*Mart Raudsepp is an IT consultant and open source enthusiast from Estonia. He contributes to various projects including Gentoo Linux, GStreamer, and GNOME.*

### Implementing a Trickmode Player with ONVIF, RTSP and GStreamer. Mathieu Duponchelle (Mathieu_Du), Centricular {#onvif-trickmodes}

The [ONVIF streaming specification](https://www.onvif.org/specs/stream/ONVIF-Streaming-Spec.pdf) extends upon RTSP to support various trickmodes. At Centricular, we have worked on supporting these new features natively both on the server and the client side.

In this talk I will present the various improvements that were made, some new concepts in GStreamer, and usage examples, complete with demo!

*Mathieu is a developer specializing in multimedia. He has contributed to many GStreamer components, and helps maintain the pitivi video editor and GStreamer Editing Services (GES) library. He currently works at Centricular.*

### PipeWire. Wim Taymans (wtay), RedHat {#pipewire-update}

A talk about the current status of PipeWire with hopefully a lot of demos. I want to show the new vulkan video source and also how some JACK flagship apps run on top of PipeWire.

*Wim Taymans has a computer science degree from the Katholieke Universiteit Leuven, Belgium. He co-founded the GStreamer multimedia framework in 1999. Wim Taymans is a Principal Software Engineer at Red Hat, responsible for various multimedia packages and is currently working on PipeWire.*

### Room Scale VR Tracking with OpenHMD. Jan Schmidt (thaytan), Centricular {#vr-tracking-openhmd}

The OpenHMD project provides cross-platform support for a range of virtual reality hardware. A variety of projects can use OpenHMD for VR - like the Godot game engine, Blender and the Monado OpenXR platform.

This talk will provide an overview of VR (what is room scale tracking anyway?), the OpenHMD VR ecosystem and then work on implementing tracking support for the Oculus Rift and where GStreamer fits into that.

*Jan Schmidt has been a GStreamer developer and maintainer since 2002. He is responsible for GStreamer's DVD support, and primary author of the Aurena home-area media player. He lives in Albury, Australia and keeps sheep, chickens, ducks and more fruit trees than is sensible. In 2013 he co-founded Centricular - a consulting company for Open Source multimedia and graphics development.*

### NVCodec plugin improvements. 양승하 Seung Ha Yang (Seungha), Naver Corp {#nvidia-hwaccel-plugin}

NVENC/NVDEC is a successor to VDPAU and it's widely used by desktop users to accelerate encoding and decoding via hardware and it's also a popular solution for the cloud computing. This talk will present about the improvement of NVENC/NVDEC since 1.16 release and about what's we are considering for further optimization.

*Seungha has been working on multimedia solution and contributing to GStreamer since 2016. He is currently working for NAVER corp. and developing a media transcoding server.*

### The First Stable libcamera Release: A Call for Public API Review. Jacopo Mondi, independent & Laurent Pinchart, Ideas on Board {#libcamera}

[libcamera](http://www.libcamera.org/) will soon turn one year old and keeps advancing in its purpose to provide a complete userspace camera stack for Linux-based systems.

Since its conception and initial developments, libcamera has progressed to support an increasing number of platforms and devices, has expanded its feature to provide integration in other Linux-kernel-based operating systems (such as Android and ChromeOS). It now allows integration of 3A algorithms while still trying to provide an easy to grasp API for camera applications.

As libcamera is reaching feature stability, it has entered the API review and stabilisation phase and needs feedback from application developers and camera vendors. This talk is part of our call for review, starting with a presentation of the libcamera features, architecture and API (based on practical examples), and then moving to a discussion with the audience to gather feedback.

*Jacopo is software engineer with a passion for embedded, operating systems and free software. In the last 5 years he mostly worked on integrating video and graphics peripherals on Linux systems as part of the Renesas Electronics mainline kernel team and, since 1 year or so, he embarked on the Libcamera boat.*

*Laurent Pinchart has been a Linux enthusiast since 1997 and Linux kernel developer since 2001. He has written the Linux UVC driver which supports several hundreds of webcams. Laurent is the founder and owner of Ideas on board, a company specialized in embedded Linux design and development where he develops a wide range of embedded drivers including DRM/KMS and V4L2.*

### GStreamer Bug Extermination Techniques. Vivia Nikolaidou (vivia), Make.tv {#bug-extermination-techniques}

This talk will show how to debug common issues in GStreamer. It will explain the first steps in debugging some issues that tend to appear frequently when using GStreamer, such as deadlocks, races, memory corruptions, memory leaks, negotiation failures, pipelines getting stuck because of inadequate queuing, etc.

*Paraskevi Nikolaidou (also known as Vivia) is currently working as a GStreamer developer. She has been active in the Open Source community and has participated in various Free and Open Source projects since 2004 when she joined the Agent Academy project. Vivia obtained her PhD in Electrical and Computer Engineering from the Aristotle University of Thessaloniki in 2011, where she worked on multi-agent systems as well as data mining methods in supply chain management. Her open source contributions range from SCCORI Agent which was part of her PhD studies, to her contributions to the GStreamer multimedia framework, passing by her involvement with the aMSN project during her spare time. She lives in Thessaloniki, Greece, where she is currently employed remotely at Make.TV, working on their GStreamer-based platform for live video acquisition and management on the cloud. She likes ducks, green tea, learning foreign languages, and playing the flute.*

### AV1 Overview: Codec and Ecosystem. Luca Barbato (lu_zero), Luminem SRLs & VideoLan {#av1-codec}

AV1 is open and free high performance video codec. It had been the result of the joint work of many companies and organizations over the past years under the Alliance for Open Media. This talk will give you a quick overview on what AV1 can do and what you can actually do with it today and in the future.

*Luca Barbato, member of the VideoLan association, develops a rust AV1 encoder called rav1e and pure-rust experimental multimedia toolchain called rust-av.*

### Lightning Talks

Lightning talks are short talks by different speakers about a range of different issues. We have the following talks scheduled so far (in no particular order):

- **Raising the Importance of the V4L2 plugin and Challenges**  
  *Nicolas Dufresne, Collabora*
- **WebKit-powered HTML overlays in your pipeline with GstWPE**  
  *Philippe Normand, Igalia*
- **Detect a metal can using GStreamer/OpenFoodFacts**  
  *Stéphane Cerveau, Collabora*
- **A new GStreamer RTSP Server**  
  *Sebastian Dröge, Centricular*
- **A brand new documentation infrastructure for the GStreamer framework**  
  *Thibault Saunier, Igalia*
- **GStreamer on Windows: Everything New**  
  *Nirbheek Chauhan, Centricular*
- **An Improved Latency Tracer**  
  *Nicolas Dufresne, Collabora*
- **Using Bots to Improve the Gitlab Workflow**  
  *Jordan Petridis, Centricular*
- **GNOME Radio**  
  *Ole Aamot, GNOME*
- **SCTE-35 support in GStreamer**  
  *Edward Hervey, Centricular*
- **Closed captions, AFD, BAR**  
  *Aaron Boxer, Collabora*
- **Applying a new streaming protocol to an old version of GStreamer**  
  *서희경님 Heekyoung (Lina) Seo, SK Telekom*
- **Embracing CI for GStreamer codec acceleration on Intel platform**  
  *Haihao Xiang, Intel*
- **More Windows supports, Direct3D11, DXVA2, and Media Foundation with GStreamer**  
  *양승하 Seung Ha Yang, Naver Corp*
- **Utilizing the Conan package manager for development and deployment**  
  *Niclas Moeslund Overby, Aivero*
- **GStreamer on the Magic Leap One**  
  *Olivier Crête, Collabora*
- ...and more to come
- *Submit *your* lightning talk now!*

**Lightning talk speakers**, please export your slides into a PDF file and either send it to Tim by e-mail (you will receive an e-mail from him about your lightning talk before the event) or have it ready on a usb stick before the start of the lightning talks on Thursday. The idea is that everyone uses the same laptop so that we don't waste time hooking up laptops to the projector and configuring them. There is no particular order or schedule for the talks. When a speaker is called up, we will also mention who is up next. Every speaker has up to ca. 5 minutes for their talk. There will be a countdown timer running. It's not possible to go over time, you'll have to finish up so that everyone has an opportunity to present their talk. If you don't want to use up the full 5 minutes, that's fine as well.

### 20 Years of GStreamer. Wim Taymans (wtay) {#twenty-years-of-gstreamer}

This year GStreamer turns 20! In this talk, GStreamer cornerstone Wim Taymans will walk back through the history of the project. He'll explain how it first started, reveal some of the design challenges that have confronted the framework along the way, and the choices that lead to the framework today.

*Wim Taymans has a computer science degree from the Katholieke Universiteit Leuven, Belgium. He co-founded the GStreamer multimedia framework in 1999. Wim Taymans is a Principal Software Engineer at Red Hat, responsible for various multimedia packages and is currently working on PipeWire.*

### Video Editing: Targeting Professional Post Production Use cases. Thibault Saunier (thiblahute), Igalia {#video-editing-professional-use-cases}

During the last year we have been focusing on implementing missing pieces in the GStreamer Editing Services to allow integrating GStreamer in existing post production pipelines, this talk will describe that work, where we are now and what is next.

*Thibault Saunier is a Senior Software Engineer currently working at Igalia. He is a GStreamer developer who maintains GStreamer validate, the GStreamer Video Editing Stack as well as the Pitivi video editor.*

### Changing Playback Rate Instantly. Jan Schmidt (thaytan), Centricular {#instant-rate-change}

An overview of some work to allow playback pipelines to change playback speed instantly in some cases, by avoiding the overhead of seeking and flushing the pipeline.

This new behaviour is especially useful when operating on streaming content where seeking might mean re-buffering a stream from a remote server.

*Jan Schmidt has been a GStreamer developer and maintainer since 2002. He is responsible for GStreamer's DVD support, and primary author of the Aurena home-area media player. He lives in Albury, Australia and keeps sheep, chickens, ducks and more fruit trees than is sensible. In 2013 he co-founded Centricular - a consulting company for Open Source multimedia and graphics development.*

### Which Network Streaming Protocol Should I Pick?. Olivier Crête (ocrete), Collabora {#which-streaming-proto}

GStreamer now implements a large number of different ways to GStreamer audio & video over a network. Just to name a few, there are RTSP, SRT, RIST, WebRTC, HLS, DASH, AES67, SmoothStreaming, RTMP! Depending on the use-case, these protocols have different upsides and downsides. To create a successful project, one needs to select the best suited technology.

I'll go over the various protocols and explain how they relate to each other and their individual advantages and inconveniences.

*Olivier Crête has been involved in free software since 2000. He has been involved in GNOME since 2003 and in Gentoo from 2003 to 2012. He currently works for Collabora, where he leads the multimedia team. He's been an active GStreamer developer since 2007, first working on VoIP and video calls, but lately he's been working on all kinds of multimedia projects.*

### Extending Cerbero to Build and Package Products based on GStreamer. Pablo Marcos (pamarcos) & Andoni Morales (ylatuya), Fluendo {#cerbero-products}

In this talk, we will focus on how we extend Cerbero at Fluendo and we will show you how to use it as a full DevOps automation system to build, test, package and release projects. During this presentation, we will demonstrate that Cerbero has a lot of potential beyond a simple build system aggregator. We will explain how you can customize and extend it to your needs to automate the lifecycle of a project: from an SDK to a desktop application.

*Andoni is a telecommunications engineer with experience in Open Source and commercial projects around multimedia technologies and cross-platform applications. Andoni founded LongoMatch, a multi-platform video analysis software for sports based on GStreamer and has been a GStreamer contributor since 2009.*

*Pablo Marcos is a Telecommunications Engineer who has developed mainly in C and C++. From mobile networks to Linux kernel drivers, passing through cross-platform desktop applications. He is passionate about Open Source and video game development and enjoys sane and fast build systems that help decrease iteration times to the bare minimum. Advocates to design simple solutions and enjoys scratching his head to squeeze all the performance he can. He believes Rust is the future of systems programming and supports it.*

### GStreamer, Windows UWP, and Firefox on the HoloLens 2. Nirbheek Chauhan (nirbheek), Centricular {#windows-uwp-firefox-hololens}

Mozilla is releasing Firefox for the Microsoft HoloLens 2 under the name ["Firefox Reality"](https://blog.mozvr.com/bringing-firefox-reality-to-hololens-2/). This is actually Servo, which is written in Rust and uses GStreamer under the hood for all multimedia (MSE, WebAudio, WebRTC, etc).

In this talk, you'll get to hear about the work I've been doing on the GStreamer side of things to make that possible. The primary challenge was porting GStreamer and GLib to the Universal Windows Platform, also known as Windows Runtime, which deprecates almost all Win32 API.

*Nirbheek Chauhan writes software and hacks on GStreamer for a living and for fun. His other software-side inclinations include GNOME, the Meson build system, and diversification (go say hi and ask him what he means by that!)*

### The Rise and Fall and Rise of JPEG2000. Aaron Boxer (aboxer), Collabora {#jpeg2000}

Released in 2000 as a potential replacement for the wildly successful JPEG standard, JPEG 2000 is versatile codec with many sophisticated features including:

- Superior compression at low bit rates
- Storage of multiple resolutions in a single bitstream
- Precise rate control without re-compression
- Lossy and losssless compression
- Progression by resolution, component, spatial region or quality

It is an essential codec in medical imaging, digital cinema and remote sensing. However, due to its high complexity, it has remained a niche codec that never gained the popularity of its predecessor.

All of this is about to change with the recently released High Throughput JPEG 2000 standard that speeds up the codec by up to 10x, while leaving almost all of its features intact. This will propel it into the mainstream, particularly in broadcast and digital cinema.

I will talk about the history of JPEG 2000, give an overview of its features and discuss the upcoming changes. I will also talk about current and planned GStreamer support for JPEG 2000.

*Aaron is a mathematician and developer, and has been building open-source systems since 2009. Fascinated by image compression, he maintains the Grok open source JPEG 2000 library. He currently works for Collabora and is based in Toronto, Canada.*

### Enabling a Different Piece of Hardware, a Story. Guillaume Desmottes (cassidy), Collabora {#hardware-enablement-story}

The Xilinx Zynq UltraScale+ MPSoC is a uniquely flexible yet powerful chip due to the combination of an FPGA fabric with hardened blocks such as ARM Cortex-A53 and Mali-400 MP2 cores as well as high performance H.264/H.265 codec.

We'll explain the different challenges we faced at Collabora to integrate GStreamer on the Zynq and achieve high end performances pipelines: multi-streams 4k60 transcoding, sub-frame latency encoding and decoding, etc. This talk will also explain how we implemented new hardware specific features like scene change detection using GStreamer and existing frameworks (video4linux, OMX).

*Guillaume has been working for more than 10 years at Collabora and been involved in various parts of the GNOME project. He's now part of Collabora's multimedia team and has gained great interest in the Rust language, hoping it will save him from having to use C for the upcoming next 10 years.*

### GStreamer and the Faster Than Light (FTL) Streaming Protocol. Francisco Velázquez (francisv), Make.tv {#ftl-streaming-protocol}

FTL is a streaming protocol that allows sub-second latency streaming of video and audio to mixer.com. FTL stands for Faster Than Light streaming protocol and is part of the Mixer video game live streaming platform owned by Microsoft. We have implemented the ftlsink GStreamer plugin to stream to the Mixer streaming service. The plugin is implemented using the SDK of Mixer and it works out-of-the-box when using it in GStreamer pipelines to stream H.264 video and Opus audio formats. Results from our evaluation show that the plugin performs as efficient as using the client included in the SDK.

*Francisco Velázquez works as Video Engineer for Make.TV. He started to get involved in the GStreamer community in 2015 while researching state-of-the-art multimedia frameworks as part of his PhD. He obtained his PhD from the University of Oslo in 2019, where GStreamer is the research base for the implementation of autonomous self-adaptive multimedia processing in ubiquitous computing environments.*

### GStreamer Vulkan. Matthew Waters (ystreet00), Centricular {#gstreamer-vulkan}

There are a number of new graphics APIs (Vulkan, Metal, DirectX 12) that aim to increase the performance of using the GPU over previous generation APIs (OpenGL, DirectX 11 and earlier). This talk will include a short overview of each API and then narrow in on the Vulkan API with the challenges faced when integrating with a pipeline-based media framework like GStreamer.

*Matthew Waters is the principal maintainer of the OpenGL integration with GStreamer from the start of GStreamer 1.x and has integrated GStreamer's OpenGL library with many other decoding, encoding and rendering technologies. He's also played around extensively with Vulkan, a new high-performance, cross-platform 3D graphics API. Lately he's been working on a new WebRTC stack for GStreamer.*

*Matthew is a Multimedia and Graphics developer for Centricular Ltd, an Open Source consultancy focusing on GStreamer, embedded systems and cross-platform multimedia and graphics.*

### GStreamer & Rust: An Update. Sebastian Dröge (slomo), Centricular {#gstreamer-and-rust}

Since last year's GStreamer conference there were many changes in the GStreamer Rust bindings, many new plugins were written in Rust and overall Rust moved closer to be a complete alternative to C for writing GStreamer applications.

In this presentation an overview of those changes since last year will be given.

*Sebastian Dröge (slomo) is a Free Software developer and one of the GStreamer maintainers and core developers. He has been involved with the project since more than 10 years now. He also contributes to various other Free Software projects, like Debian, Rust, GNOME and WebKit. While finishing his master's degree in computer sciences at the University of Paderborn in Germany, he started working as a contractor for GStreamer and related technologies. Sebastian is one of the founders of Centricular, a company providing consultancy services, where he's working from his new home in Greece on improving GStreamer and the Free Software ecosystem in general. Apart from multimedia related topics, Sebastian has an interest in digital signal processing, programming languages, machine learning, network protocols and distributed systems.*

### Low Latency in Video Surveillance System with SRT. Justin Kim, SK Telekom {#srt-in-surveillance-systems}

Since SRT (Secure, Reliable, Transport) is announced as opensource, it is being used widely in the broadcast industry. Then, SK Telecom found it suitable for more difficult areas, such as real-time video surveillance with PTZ control, and flight control of drone. In this talk, I'd like to share how much latency we can achieve with SRT and what project we are doing in github.

*Justin Kim has been contributing to GStreamer since 2012. He is an open source project enthusiast and recently joined ICT R&D Center, SK Telecom in Korea to spread the open source habits.*

### Dashsink plugin to complete the GStreamer offering. Stéphane Cerveau (dabrain34), Collabora {#dashsink}

In this talk, I'd like to introduce first to DASH technology and its value to be supported by GStreamer and then talk about my work performed to support a multiple stream (audio/video) MPD generator, dashsink.

*Stéphane Cerveau is a Senior Software Engineer who joined Collabora 6 months ago, bringing with him 15 years of experience in the multimedia embedded ecosystem including STB, HBBTV, DLNA and of course GStreamer.*

### Google Transport-wide Congestion Control. Håvard Graff (hgr), Pexip {#google-twcc}

Described in <https://tools.ietf.org/html/draft-holmer-rmcat-transport-wide-cc-extensions-01>, we will look at how this works, how it can be integrated in GStreamer, and what value it potentially provides.

*Håvard Graff has been working professionally with GStreamer since 2007, for Tandberg, Cisco and now Pexip, creating video-conferencing products. The desire for quality has made him an obsessional crusader for more and better testing, and he will try to spring GstHarness on you at any given opportunity.*

### Audio/Video Bridging (AVB) support in GStreamer. Andre Guedes, Intel {#avb-support}

Audio/Video Bridging (AVB) is a set of IEEE technologies that enable time-sensitive Audio/Video applications on top of Local Area Networks (LANs). AVB provides time synchronization, bounded transmission latency and application interoperability. These features can actually be leveraged by non-AV systems so IEEE rebranded AVB as Time-Sensitive Networking (TSN).

For the past few years, several TSN building-blocks have been developed in Linux upstream ecosystem, including the recent AVTP plugin for GStreamer. This talk will introduce the key TSN concepts required for AVB applications and provide an overview of the GStreamer AVTP plugin. The talk will cover in detail how to leverage the plugin to implement AVB applications as well as discuss the current status and upcoming features. This talk should take about 45 minutes including questions.

*Andre Guedes is a software engineer at Intel. He has been working on multiple kernel and user-space features in order to enable TSN in Linux upstream ecosystem. Andre is the author of the GStreamer AVTP plugin.*

### GstTranscoder: A High Level API to Quickly Implement Transcoding Capabilities in your Applications. Thibault Saunier (thiblahute), Igalia {#gst-transcoder}

A new library and a set of elements have been developed for the pitivi video editing application, after a few years it has finally been merged into gst-plugins-bad. It also includes a command line application that aims at being flexible and provide the same kind of features as the ffmpeg command line interface. This talk will explain where we are with this new API, what its goal is and what comes next.

*Thibault Saunier is a Senior Software Engineer currently working at Igalia. He is a GStreamer developer who maintains GStreamer validate, the GStreamer Video Editing Stack as well as the Pitivi video editor.*

### GStreamer and Multi-project Continuous Integration Pipelines. Jordan Petridis (alatiera), Centricular {#multi-project-ci-pipelines}

High level overview of the new Gitlab CI setup for GStreamer, the contribution workflow and how to keep your CI pipelines green.

*Jordan is a QA and Multimedia engineer at Centricular, part of the GNOME release team and can't stop talking about Rust and Flatpak.*

### Home Automation with GStreamer. Jan Schmidt (thaytan), Centricular {#home-automation}

This talk will revisit a topic from a few years ago - using GStreamer to synchronise the capture of microphones across a network. Since the last talk, interesting developments around the availability of hardware microphone arrays have made some new things possible.

*Jan Schmidt has been a GStreamer developer and maintainer since 2002. He is responsible for GStreamer's DVD support, and primary author of the Aurena home-area media player. He lives in Albury, Australia and keeps sheep, chickens, ducks and more fruit trees than is sensible. In 2013 he co-founded Centricular - a consulting company for Open Source multimedia and graphics development.*

### PipeWire in the Automotive Industry. George Kiagiadakis (gkiagia), Collabora {#pipewire-automotive-industry}

PipeWire has recently been adopted by Automotive Grade Linux for its implementation of the low-level platform audio service, replacing entirely previous solutions like 4A, PulseAudio and AudioManager. Getting there had, of course, many challenges. In this talk, George is going to talk about how PipeWire has managed to overcome these challenges and has evolved to support automotive use cases and hardware through the design and implementation of a new, reusable, session & policy management component, WirePlumber.

*George Kiagiadakis is a computer science graduate from the University of Crete and a free software contributor since 2008. He got involved with GStreamer in 2009 with a Summer of Code project in KDE, from which QtGStreamer later emerged. Since 2010, he is working at Collabora where he is assisting customers with the integration of GStreamer in their products and researching new features.*
