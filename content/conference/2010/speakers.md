---
title: "Speakers bio and abstracts - GStreamer Conference 2010"
year: 2010
type: "conference"
---

## Cambridge, United Kingdom, 26th of October 2010

[Back to conference main page](/conference/)

[Back to conference timetable](gstreamer-conference-timetable.html)

### Keynote - GStreamer - Current and future development, Wim Taymans, Collabora Multimedia {#taymans}

Wim Taymans is one of the founders of the GStreamer project and the man behind the current GStreamer design. Wim has a long history in the development of multimedia software, starting with computer game development on the Commodore 64. Wim Taymans is a co-founder of Collabora Multimedia and is working on assisting Collabora Multimedia customers with the design and use of GStreamer.

Wim Taymans will in his keynote be speaking about the current state of the [GStreamer](/) project and the development plans for GStreamer 1.0.

### Webkit, HTML5 and GStreamer, Philippe Normand, Igalia {#normand}

Philippe Normand has worked at ENST-Bretagne (France) on home-care and domotic technologies for elderly people. He too worked on the Elisa/Moovida media-center project at Fluendo. At Igalia he currently works on improving the HTML5 audio/video support in WebKitGTK+ with the GStreamer multimedia framework. Philippe has a Master degree in Computer Sciences.

This talk will cover integrating a GStreamer-based media player in multiple [WebKit](http://webkit.org/) ports to provide HTML5 audio/video support on a variety of platforms including (but not limited to) Linux, Mac OS X and Windows. It will describe the modifications done on the player first developed for the GTK+ WebKit port to be cross-platform and modular enough to be used by other ports such as WinCairo and the official Mac WebKit port.

Other topics discussed will include the fullscreen video support implementation, a check-list explaining how to enable the GStreamer player for your WebKit port and a small HTML5 video showcase of the current WebKit ports supporting the GStreamer player.

### Cross platform development with GStreamer, Michael Smith, Songbird {#smith}

Michael Smith is the main GStreamer developer at Songbird, a company making the cross-platform music player Songbird. Michael will talk about their experiences with using GStreamer as a cross-platform media engine on Linux, Windows and Mac OS X.

This talk will focus on the advantages and challenges when using GStreamer as a cross platform middleware based on the experiences with developing the [Songbird](http://getsongbird.com/) Music Player on Windows, MacOS X, Solaris and Linux, all using the GStreamer framework for media playback.

### Challenges of video editing in your pocket, Edward Hervey, Collabora Multimedia {#hervey}

Edward Hervey started developing [PiTiVi](http://www.pitivi.org/) during his final years at the EPITECH engineering school in Paris. He soon found that PiTiVi's needs required improvements to the GStreamer framework, and began developing them. As one of the founders of Collabora Multimedia, Edward manages the PiTiVi team and continues to contribute substantially to the GStreamer project.

This talk will focus on the [GStreamer Editing Services (GES)](http://blogs.gnome.org/edwardrv/2009/11/30/the-result-of-the-past-few-months-of-hacking/) layer for GStreamer which adds support for high quality and low overhead video editing in an easy manner with GStreamer. GES is developed with the embedded space in mind, but will also be useful for desktop developers who want to add simple video editing support to their applications.

### A GStreamer based framework for adaptive streaming applications, Emanuele Quacchio, ST Microelectronics {#quacchio}

Emanuele Quacchio received the Master Degree in Electronic Engineering from the Polytechnic University of Turin, Italy in 2003. He worked two years as a researcher in the Dept. of Electronics of the same university and joined STMicroelectronics at the AST-system R&D group in 2006, where he is currently working as a Senior System Engineer. His activities are mainly focused on embedded SW development for STB/mobile platforms, video compression standards and streaming protocols. He published and co-authored several papers on the principal journals of engineering and conferences. Since 2006 he has participated to a number of EU funded projects (ASTRALS, SEA, P2PNext, COAST) and he has given lectures at Polytechnic of Turin on video communication.

In this work we present novel gstreamer plugins that lay the groundwork for the development of adaptive streaming applications supporting the novel video coding standard known as Scalable Video Coding (SVC) , extension of state-of-art H.264/AVC standard.

### GStreamer and OMAP4, Rob Clark, Texas Instruments {#clark}

Rob Clark has been working in the arm embedded world for more than 10 years, and playing with linux for even longer. And most recently, gets to combine the two. For the last year or so, he has been making GStreamer work with the hardware accelerated codecs and video on the TI OMAP4 platform.

An overview of GStreamer based multimedia on TI OMAP4 linux platform. For optimal integration of the accelerated video encoders and decoders, camera, and display we ran in to a number of missing features in GStreamer, such as support for rowstride, more flexible caps negotiation, zero copy crop/vstab, buffer padding and alignment requirements. In addition, there is still optimization possible if cache operations (invalidate/clean) could be eliminated in pipelines where we know software is not touching the buffers, as would typically be the case on an SoC like OMAP4. We would like to present how we've solved these problems currently, and how we could possibly solve them in GStreamer 1.0.

### Implementing DLNA using GStreamer, Zeeshan Ali, Nokia {#ali}

Zeeshan Ali is a Lead Developer/Architect at Nokia MeeGo Computers division in Helsinki, He started as a GStreamer plugin and application developer and is known in the GNOME community for his video-whale project. For the past three years, he had been obsessed with UPnP and in turn the GUPnP project and [Rygel](http://live.gnome.org/Rygel). When he gets some time from his office work and GUPnP, he hangs around with his wife, plays Star Trek Online & Street Fighter in his spare time and sometimes tries to learn some Finnish.

Rygel is a collection of DLNA (UPnP AV) services implementing the [DLNA](http://www.dlna.org) standard for interoperable multimedia devices, implemented through a plug-in mechanism. UPnP in simplest words is a set of protocols that defines how different devices on a home network can seamlessly (without or with minimum configuration) communicate with each other. This talk will introduce you to the current state of Rygel and give you an introduction how Rygel can be quickly deployed to enable you to ship a DLNA-enabled device.

### Integrating VideoConferencing into Everyday Applications, Olivier Crete, Collabora {#crete}

Olivier Crete has been involved in free software since 2000. He's been the maintainer of GnomeICU (a Gnome ICQ client) since 2002 and a Gentoo developer since 2003, starting the amd64 port and also helping maintain various IM applications. He currently works for Collabora on GStreamer, the Farstream VoIP framework and its integration into Telepathy.

This talk will discuss how until now, videoconferencing has lived in dedicated applications. We've had instant messengers with VoIP, softphones, but they don't integrate into the everyday workflow. [Farstream](http://www.collabora.co.uk/projects/farstream/), the next generation of Farsight, the GStreamer based VoIP and videoconferencing framework not only provides media handling to communication applications such as Empathy, Pidgin, aMSN and the Nokia Internet Tablets, but can also be used to integrate videoconferencing into everyday applications.

This talk will give a brief introduction to Farstream and [Telepathy](http://www.collabora.co.uk/projects/telepathy/) and how they integrate. I will then show how to integrate videoconferencing features into an application such as a non-linear editor. It will also demonstrate how easy it is for application developers to integrate such features into their applications and how useful it can be for users.

### Optimizing multimedia with Orc, David Schleef, Entropy Wave. {#schleef}

David Schleef is one of the leading experts on open source multimedia. He has been active for 13+ years in leading and developing several open source projects, including GStreamer, Swfdec, Comedi, Dirac/Schroedinger, and Liboil/Orc. His most recent project, Orc, allows developers to harness the power of CPU vector extensions without having to write assembly code or intrinsics. Allegedly, he got tired of writing yet another thousand lines of assembly code and wrote a program to write it for him.

This talk will present the [Orc](http://code.entropywave.com/projects/orc/) library and set of tools for compiling and executing very simple programs that operate on arrays of data. The “language” is a generic assembly language that represents many of the features available in SIMD architectures, including saturated addition and subtraction, and many arithmetic operations. The talk will also cover the recently released NEON backend for ORC.

### Case study - Tandberg and GStreamer, Håvard Graff, Tandberg {#graff}

Håvard was introduced to GStreamer when he started working for TANDBERG (now Cisco) three years ago, and has been in love ever since. Håvard is particularly interested in dynamic pipeline-building, synchronization, MT-safeness and audio. When not trying to understand caps-negotiation, Håvard tries to play the piano. Works on [Movi](http://www.tandberg.com/personal-video-conferencing/pc-mac-video-movi-v2..jsp), a cross-platform, telepresence application for the desktop.

This talk will cover our experiences with gstreamer, how we work with it, management issues, support, customizing and so on. We will also specifically look at the Movi application developed by Tandberg using GStreamer, including an in depth look at how we "do it" Points of interest, challenges with dynamic live pipelines, plumbing solutions etc. We will also talk about acoustic echo cancelling in gstreamer including how we solved it, challenges, tips and hints.

### Landell - live streaming for the masses, Luciana Fujii, Holoscopio {#fujii}

Luciana Fujii is the main developer of [Landell](http://landell.holoscopio.com) , a free software designed to allow live recording and streaming with simple GTK+-based interface. In Holoscópio, she has also worked in embedded systems development. Luciana has a bachelor's degree in Computer Science.

Features of Landell include switching sources, picture-in-picture, watermark, multiple filters and multiple simultaneous outputs without stopping the pipeline.The presentation will show the challenges faced during Landell development, specially regarding dynamically changing a quite complex pipeline.

### Case study - Flumotion and GStreamer, Zaheer Merali {#merali}

Zaheer Merali is a long standing GStreamer developer, now working at Tandberg/Cisco as a senior software engineer. He was at Flumotion for 4 1/2 years where he has heavily influenced the design and code of the open source Flumotion streaming server.

This talk will feature an introduction to [Flumotion](http://www.flumotion.net/) the open source streaming server, the GStreamer, Python and Twisted powered streaming server. It will discuss how flumotion distributes GStreamer pipelines across processes and how flumotion tries to ensure sync between different processes doing for example capture that could even be on different machines. We will also look at how flumotion streams to the end user client, adminning a Flumotion streaming server and finally how to create your own Flumotion component.

### Case study - GStreamer on Axis devices, Jonas Holmberg, Axis {#holmberg}

Jonas Holmberg is a Master of Science in Computer Science from Sweden. He works as an expert Software Engineer at Axis Communications, being an system architect and software developer.

In 2006 Axis camera developers decided to implement a GStreamer based streaming application for their camera and video server hardware. Two years later the first GStreamer based Axis camera was released.

This case study will discuss lessons learned during development of a GStreamer based application on custom hardware.

### Using ICE middleware with GStreamer to implement real-time QoS-aware video streaming for remotely controlled vehicle. , Andrey Nechypurenko and Maksym Parkachov {#nechypurenko}

Andrey Nechypurenko is currently working as a senior software engineer at General Electric. He has many years of experience in defining architecture and implementing large scale distributed real-time and embedded systems in automotive and industrial automation domain. As his hobby, Andrey is developing different kinds of ground and air vehicles which can be controlled over the Internet.

Maksym Parkachov is working as senior CRM consultant at the Riverland GmbH. His expertise area lies in integration of the enterprise front-facing applications with industry standard back-ends, optimizations of parallel processing systems and data quality processes implementation . In his free time, he is building remote controlled embedded systems.

Typically, remotely controlled vehicles are equipped with video camera to let the remote driver see surrounding environment. To enable precise control of the vehicle over the Internet, it is necessary to assure low video latency and ability to adapt to the changing network conditions. In addition, low power consumption is required to increase the battery-based operation time. In this paper we: a) outline our embedded control system based on BeagleBoard open hardware and Ångström Linux distribution; b) provide requirements, motivation and describe how we build real-time quality of service (QoS) aware video streaming solution with ICE open-source middleware and GStreamer on this platform; c) we contrast and compare our solution with RTP/RTCP-based streaming alternatives and d) provide performance measurements for our adaptation algorithms.

### 3D Stereoscopic and GStreamer, Martin Bisson {#bisson}

Martin Bisson has completed his Master's Degree in Computer Science at École Polytechnique de Montréal, working on a 3D visualization tool for minimally invasive spine surgery. During his studies, he worked for various high technology companies in the fields of image and video processing as well as computer graphics, such as Matrox and Autodesk (Media & Entertainment Division formerly known as Discreet). In 2008, he co-founded Float4 Interactive (www.float4.com), a creative technology company that develops interactive systems for entertainment, advertising and design applications.

With recent developments in 3D video technology and its success, adding support now for this uprising technology will make GStreamer an attractive choice for application developers. The support has been implemented as part of a Google Summer of Code project. Different possible implementations, each with its own strengths and weaknesses, were considered, but a simple and hopefully complete one was chosen. ORC can be used for the CPU-intensive but easily parallelized task of generating anaglyph images. Work still needs to be done, especially on support of different 3D display hardware..

### Case Study - Intel SMD elements in GStreamer, Josep Torra, Fluendo {#torra}

Josep Torra holds a Computer Engineering degree from the Open University of Catalonia (UOC), Catalonia, Spain. He joined Fluendo as senior developer and became a part of the codec development team for embedded systems in 2006. He currently works as a Technical Lead for the team developing codecs and multimedia related projects in a wide range of platforms, from desktop to embedded systems. Embedded Linux development, HW accelerated decoders, and performance optimization techniques are of special interest for Josep. He is also a developer on the GStreamer project.

Intel C3100 (aka Canmore)and C4100 (aka Sodaville) are integrated system-on-a-chip solutions that could be used in set-top boxes to integrate the Internet on TVs. This talk discuss the work done at Fluendo to support the Moovida media center solution on Intels chipset and the state of running these kind of applications on Linux systems.

### WebM and GStreamer, Sebastian Dröge, Collabora Multimedia {#droge}

Sebastian Dröge is working on GStreamer since early 2006 and nowadays is one of the main developers. He is working for Collabora Multimedia since 2008 and also works on other open source projects in his free time. Sebastian has a bachelor's degree in computer sciences and is currently finishing his master's degree.

This year Google released the [WebM](http://www.webmproject.org/) video format for the web. This talk presents the work done by Collabora Multimedia and Entropy Wave to support this format from day one in GStreamer and how vendors can quickly and easily support WebM on their devices using GStreamer.

### Case study - Using gstreamer for building automated webcasting systems, Florent Thiery, Ubicast.eu {#thiery}

Florent Thiery is co-founder and C.T.O. of UbiCast, a small french company dedicated to providing turnkey, automated multimedia capture appliances for the conference, training and educational market. Based on the gstreamer framework and other open source technologies (notably, OpenCV, twisted and Clutter), these solutions aim at lowering the complexity of producing and publishing video to the Internet by automating as much tasks as possible for the end user. Being a gstreamer application architect and developer, he focuses on audio/video capture devices, web streaming and computer vision technologies.

<a id="thiery"></a>
### Interactivity in GStreamer pipelines, Jan Schmidt, Oracle Corporation {#schmidt}

This talk will discuss the challenges encountered when implementing features such as DVD menu support with GStreamer, and the solutions that were implemented. It will discuss how these can be used in other scenarios, such as interactivity over the network, and Blu-ray disc support.

Jan is a GStreamer maintainer. After leaving Fluendo in 2007, he moved to Ireland and joined Sun Microsystems and subsequently Oracle on their acquisition of Sun in 2009. These days, he lives in Australia and hacks on GStreamer as he can.

The slides for this talk are available at: <http://people.freedesktop.org/~thaytan/gstinteract-0.10.1.tar.gz>

**Note:** there will be further GStreamer-related talks on October 27/28 as part of the [main CE Linux program](http://www.embeddedlinuxconference.com/elc_europe10/program.html).
