---
title: "Speakers bio and abstracts - GStreamer Conference 2013"
year: 2013
type: "conference"
---

## Edinburgh, Scotland, UK, 22-23 October 2013

[Back to conference main page](/conference/)

[Back to conference timetable](schedule.html)

### Keynote - Taking GStreamer to the Next Level, Tim-Philipp Müller (\_\_tim), Centricular {#muller-nextlevel}

This keynote will take a bird's eye look at what's been happening in and around GStreamer in the last twelve months, speculate on where the project is headed, and reflect on what's needed to take GStreamer to the next level.

*Tim Müller is a GStreamer developer, maintainer, and release manager. In the past he worked for Fluendo and co-founded Collabora Multimedia. He recently joined forces with GStreamer legends Jan Schmidt and Sebastian Dröge and started Centricular Ltd, a new Open Source consultancy with a focus on GStreamer, cross-platform multimedia and graphics. Tim lives in Bristol, UK.*

### Automated Set-top Box Testing with GStreamer, David Röthlisberger, YouView {#rothlisberger-stb-testing}

We'll see how easy it is to develop a video-capturing image-recognition system using GStreamer, by building one in 3 minutes!

A leading example of such a system is [stb-tester](http://stb-tester.com/), an open-source tool developed at YouView to automate the user interface testing of our set-top boxes. We'll see stb-tester in action, and hear about the flexibility offered by its GStreamer underpinnings.

*David Röthlisberger is the creator of stb-tester, and heads test automation at YouView.*

### Latest GStreamer Streaming Server features: Video on Demand, Smooth Streaming, and DRM, David Schleef (ds), Rdio {#schleef-gss}

In the past year, GSS (GStreamer Streaming Server) has morphed from a simple live streaming server into a web framework written in C, with a strong media bias. This talk will be a reintroduction to GSS with information on features, how to use and deploy GSS, and future directions. New features, such as the video-on-demand system, Microsoft Smooth Streaming, MPEG DASH, and DRM encryption will be discussed in detail. The deployment of GSS at Rdio Inc for video streaming will be used as an example.

GSS is a custom standalone HTTP server and web framework written in GLib-style C and based on GStreamer, Libsoup for HTTP processing, Bootstrap for HTML user interface, and JSON-GLib for request processing. Streaming protocols include HTTP, RTSP, RTMP, Icecast, HTTP Live Streaming, Microsoft Smooth Streaming, and MPEG DASH.

*David Schleef is a long-time contributor in the open-source community, working on projects such as GStreamer, the Dirac video codec, Swfdec, Orc, Debian, Comedi, and Xiph.org projects. He is a Senior Engineering Manager at Rdio Inc, handling music and video ingestion, transcoding, and streaming. His current interests relate to improving the tools used for converting and delivering high-quality content to viewers.*

### The never-ending story: GStreamer and hardware integration, Sebastian Dröge (slomo), Centricular {#droge-hw-integration}

In the past usage of specialized hardware features, especially those of embedded hardware DSPs, VPUs and GPUs, was always a challenge with GStreamer. GStreamer 0.10 had many shortcomings in this area, and many hacks were necessary to use hardware in an efficient way or make it usable at all. In GStreamer 1.0 and later versions many new interfaces were introduced or existing interfaces were improved to allow clean and efficient integration of specialized hardware features. This talk will provide an overview about these changes, with examples of usage for APIs like OpenGL, EGL, OpenMAX IL, VDPAU, VAAPI. There will also be some guidance about which interfaces should be used how and in which cases.

*Sebastian Dröge is, among other things, a free software developer and one of the GStreamer maintainers and core developers since 2006 and also contributing to many other free software projects. While finishing his computer sciences degree, he started to work as a contractor for Collabora and stayed there until 2013 to work on GStreamer and related technologies. He also was the technical lead of the GStreamer SDK project at Collabora, which provides easy to use binaries for Windows, Mac OS X, Android and iOS.  
Nowadays Sebastian is working at Centricular, a new company providing consultancy services around GStreamer and Free Software in general.*

### GStreamer and OpenGL plugins in 1.0, Matthew Waters (ystreet00) {#waters-opengl}

OpenGL is a powerful API usually accompanied by powerful hardware that currently goes mostly unused by GStreamer. Equipped with GLSL, one can envisage complex (or simple) filters that transform the typical video into a psychedelic light show. This talk will provide for the current state of gst-plugins-gl and a look into the future of GStreamer with OpenGL.

*Matthew Waters has only just started his hopefully long and rewarding FOSS career after using Linux for the past couple of years. When he isn't hacking on gst-plugins-gl, he is attending University and playing around with waveforms.*

### Latest GStreamer RTSP Server features, Wim Taymans (wtay), Collabora {#taymans-rtsp}

This talk presents an RTSP server built on top of GStreamer and its various RTP elements and libraries. We will cover the design of the server and how it integrates with GStreamer. We will also talk about some of the new features such as the security infrastructure and multicast support.

*Wim Taymans has a computer science degree from the Katholieke Universiteit in Leuven, Belgium and decades of software development experience. He co-founded the GStreamer multimedia framework in 1999 and is the person behind much of the current design. Wim has a long history in the development of multimedia software, starting with computer game development on the Commodore 64. Wim Taymans is working on assisting Collabora customers with the design and use of GStreamer as well as general research and development.*

### GStreamer for Mobile Platforms: Android and iOS, Andoni Morales (ylatuya), Fluendo {#morales-android-ios}

Mobile platforms such as Android and iOS are growing very fast and GStreamer offers an excellent alternative to the native API's to develop complex multimedia applications. The recent work on the GStreamer SDK to port the missing bits to these platforms, combined with cerbero's build system, provides all the tools for developers to use it as their multimedia framework and create apps ready to be deployed to the Android Market and App Store.

This talk will cover the new system plugins for these platforms and describe the build process used to compile GStreamer and its dependencies. We will also describe the integration with the native build systems and how GStreamer is bundled in the application. Finally we will show an example on how to build a simple media player for Android with Eclipse and for iOS with XCode.

*Andoni Morales is a software engineer with experience in multimedia middleware, cross-platform applications and build systems. Andoni holds a master degree in Telecommunications Engineering and he is a multimedia engineer at Fluendo, working in the design and development of the company’s multimedia solutions. On his spare time, he works in LongoMatch, a performance video analysis tool for sports powered by GStreamer.*

### Alternative playback solutions for Hardware Manufacturers, Jeongseok Kim, LG Electronics {#kim-alt-playback}

LGE is developing a mediaframework for WebOS based on Gstreamer. Although GStreamer provides very good architecture, LGE still has problems to adapt for restricted environments such as limitation of hardware, and product-specified requirements so that I and my team decided to design an alternative playback solutions. In this talk, I'll share a short story and our approach to make solutions for unusual requirements. This talk would be helpful for developers who are trying to make their own products with playbin.

*Jeongseok Kim has worked for over 10 years as an embedded system software developer. At LG Electronics he's a senior research engineer and also the leader of GStreamer core team for WebOS.*

### GStreamer-based Media Player for SetTopBox, Romain Picard, SoftAtHome {#picard-stb-player}

Good quality multimedia playback is now a mandatory feature in SetTopBox devices. Providing the same user experience on multiple settopbox and chipset can be challenging since the hardware and software/driver specifications are different for each device. Moreover more container/codec combinations must be supported each year. We present a multimedia player design allowing progressive enhancement and easy board customization with minimal code changes, leveraging the GStreamer framework modularity.

*Romain Picard is software architect at SoftAtHome, a software editor based in France and Belgium. He has been working for more than 10 years on digital tv. He was involved in the design and development of media components used in many SetTopBoxes : dvb player, recorder and streamer, multimedia player.*

### FluMediaPlayer: Growing our user base through high level media player API, Julien Moutte (dolphy), Fluendo {#moutte-flump}

Thanks to the GStreamer SDK effort it is now possible to easily build and deploy GStreamer applications on almost all major operating systems in the market. However GStreamer API is still pretty complex/low level in comparison to competition on those new platforms. Indeed, creating a simple, yet powerful media player using Java on Android or Objective C on iOS, can become a serious nightmare for the usual "App" developer which is used to a simple \_open/\_play/\_close API.

Fluendo created a media player engine aiming at making it straightforward to create such applications leveraging GStreamer's versatile infrastructure to support all media formats, adaptive streaming, hardware accelerated decoding, etc. Thanks to its high level API (C, JNI, ...) it is now much faster and easier to start using GStreamer in your "App" and benefit from the cross platform goodness it can offer you without becoming a GStreamer guru.

*Combining both a strong technical and business understanding of the IT market, Moutte co-founded more than 4 companies since 1998 before bringing his visionary leadership to the establishment of the Fluendo group in 2004. An active contributor to the Free Software community since 2001, Moutte has participated in the creation of GStreamer, the multimedia framework chosen by most multimedia software producers. Moutte has also been at the origin of several innovative solutions within the multimedia environment.*

### WebKit and GStreamer, Xabier Rodríguez Calvar (calvaris), Igalia {#calvar-webkit}

WebKit is a well known open source browser engine used by Apple, GNOME, EFL, Blackberry and others and shares quite a big codebase with Blink. It was the result of a fork from KHTML and KJS.

As a simplification we can say that it has three main layers, the API, the core and the backend. The different ports implement their API and their backends and the core is shared. WebKit 2 is robust and transparent multiprocess architecture allowing safer interactions with webpages.

GStreamer is the multimedia backend of some WebKit ports and in this talk we will see its architecture, status, challenges and future.

*Xabier Rodríguez Calvar (calvaris) is a Free Software developer living in A Coruña and partner at Igalia. He has always worked on GNOME technologies though he has also experience in Qt. These last years he has focused his energies in multimedia with GStreamer and now he is a WebKit hacker.*

### Application Showcase: Toonloop, the Live Stop Motion Editor, Alexandre Quessy (aalex), Perte de Signal {#quessy-toonloop}

Toonloop is a free software for live stop-motion animation. It allows to create frame by frame animation, pixilation and other animation techniques. Developed by Alexandre Quessy since 2008, the software recalls the experiments of Norman McLaren and Pierre Hébert and has the particularity to show the result all the while users are creating new images. By giving an instant feedback to its users, Toonloop encourages video contents creation. The whole process can be fun to watch, and it is suitable for live performing arts.

With Toonloop, creators can create stop motion animations in a wink. The images of the resulting clips are displayed in a never ending loop. Each image is added one by one. Toonloop can be useful for different purposes, such as teaching new media technique and theory, art-therapy, VJing, rapid prototyping, and more.

Toonloop as been written in the C++ language using GStreamer for its video pipeline. It is interoperable via MIDI and OpenSoundControl, and supports some special effects or playback modes. Toonloop is a free software released under the terms of the GPL.

In this presentation, the creator of Toonloop will explain the project and demonstrate it in a short live performance. The presentation should last around 30 minutes, or longer if desired.

*Alexandre Quessy is a Montreal-based artist and software developer. He is interested in sampling audio, video and data. He is much involved in creating and teaching free software for arts. His projects went to Canada, USA, Norway, France, Mexico, Taiwan and Belgium. He is the main author of the Toonloop live animation software. Quessy studied communication and music. He is a member of the artist-run centre Perte de Signal.*

### Case Study: GStreamer on the Dreambox, Andreas Frisch (fraxinas), Dream Property {#frisch-dreambox}

The Dreambox is a prototypical example of a multimedia embedded linux device and has been making use of Gstreamer since 2006. In this case study, I will shortly introduce our line of consumer electronics products and then focus on how it relies on Gstreamer: what were the pitfalls and how did we (fail to) master them? The talk will explain how we solved audio and video playback with SOC hardware decoders using the LinuxTV API and custom Gstreamer sink elements. I will expound on how our Gstreamer 1.0 port is coming along and what plans the future holds.

*Andreas aka "Fraxinas" in the FOSS world, graduated from the University of Applied Sciences in Aschaffenburg with a degree in electrical engineering and information technology. Since writing his thesis paper about a streaming video server for set top boxes, he has been working for Dream Multimedia, the company which released the first Linux-based STB called "Dreambox".*

### Next Generation Video Coding with HEVC: Facts and Figures, Thijs Vermeir (lovebug356), Barco {#vermeir-hevc}

HEVC (High Efficiency Video Coding) is developed as the successor of the H.264/AVC video coding standard. The goal of the HEVC standardization process was to develop new algorithms to reduce the bandwidth by 50% for equivalent perceptual quality and to support higher resolutions. A first version of the standard was published in January 2013. But next to the technical details, market adoption is even more important for a codec’s success. There are a lot of questions that need answering: Why is the performance of H.264/AVC not good enough? Do we really need better compression? Is the market ready for HEVC? Are we able to notice the difference between HD and 4k (or 8k)? Is there silicon available? …

The first part of the talk will provide a high level overview of HEVC, with respect to the improved coding tools as well as performance. The second part of the talk will provide insight on how this new codec can be adopted in the market and what the burdens are on its way to success.

*Thijs Vermeir has been contributing to the GStreamer project since 2006. After working at Fluendo, he is now research engineer for Barco, where he is doing research in video processing including video compression and network streaming.*

### Application Showcase: gst-media-info, Stefan Sauer (ensonic), Google {#sauer-mediainfo}

GStreamer has the discoverer feature to quickly collect metadata from media files. The included command-line tool is not convenient for going through a larger set of files. In this demo I show gst-mediainfo as an alternative UI.

*Stefan is a software engineer working for Google on build infrastructure tools. In the past he was working for Nokia on the multimedia stack used on their maemo/meego internet tablets and phones. In his free time his is contributing to GStreamer, other GNOME projects (e.g. gtk-doc) and working on his music editor buzztrax. He has a PhD in Human Computer Interaction from the Technical University of Dresden/Germany. Stefan now lives in Munich/Germany with his wife and his two kids.*

### GES - The Open Source Swiss Army Knife of Multimedia Editing, Mathieu Duponchelle (Mathieu_Du) and Thibault Saunier (thiblahute), Collabora {#duponchelle-saunier-ges}

The purpose of this talk is to first present the current state of Gstreamer Editing Services, and in a second time analyse how our design, and the design of the underlying framework, will allow us to provide solutions to the various challenges the multimedia edition world will throw at us. An offline, featureful video editor named Pitivi makes extensive use of GES and serves partly as a showcase, but we will show how GES has the potential to be used in much more use cases than this particular one: online editing, collaborative editing, live broadcasting, and how Pitivi could be extended to match specific use cases.

*Mathieu Duponchelle is a student in Epitech Paris. He contributes to pitivi and GStreamer since 2010, and, as of September 2013, is finishing a Google Summer of Code which purpose was to eliminate as many bugs as possible across the multimedia stack.*

*Thibault Saunier joined the PiTiVi project as a Summer of Code student in 2010 and has been hooked ever since. He now maintains and leads PiTiVi, GNonLin and GStreamer Editing Services development.*

### Cairosink and GPU Buffer Sharing, Guillaume Emont (guijemont), Igalia {#emont-cairosink}

GStreamer 1.0 introduced a new architecture that makes memory management easier. In particular, handling non-system memory and sharing it between elements is made easier.

While building a video sink for cairogles, I wanted to explore the possibility of sharing GPU memory (in my case, GL or GLES textures) between elements of a pipeline. In this talk, I will explain how I made the various parts fit together, and discuss the challenges that I have met and how I have worked on them.

*Guillaume Emont has been playing around on various things related to multimedia (Elisa/Moovida, Pigment, Grilo and of course GStreamer) in the Free software world for a few years and enjoys it a lot. He is proudly part of the awesome group of hackers known as Igalia.*

*When he doesn't hack on software, he enjoys travelling around the world, discussing with like-minded people around a drink or a good meal, various outdoor sports in and around sunny Barcelona, helium balloon photography or building interactive laser installations, among many other things.*

### Keynote - Pitfalls and Best Practices for Using GStreamer to Build Products, Wim Taymans (wtay), Collabora {#taymans-pitfalls}

This Keynote compiles a set of guidelines and best practices for integrating GStreamer into your products. It is meant to be a series of 'lessons learnt' from a decade of GStreamer consulting which can hopefully help you avoid some of the common pitfalls. We will talk about integration with existing hardware and software solutions as well as dealing with the community to make the most out of GStreamer and its ecosystem.

*Wim Taymans has a computer science degree from the Katholieke Universiteit in Leuven, Belgium and decades of software development experience. He co-founded the GStreamer multimedia framework in 1999 and is the person behind much of the current design. Wim has a long history in the development of multimedia software, starting with computer game development on the Commodore 64. Wim Taymans is working on assisting Collabora customers with the design and use of GStreamer as well as general research and development.*

### Multimedia on Embedded Linux - Pushing GStreamer to its Limits, Michael Olbrich, Pengutronix {#olbrich-embedded}

Modern ARM SoCs have a number of hardware multimedia units. GStreamer's modular design makes it the ideal candidate to integrate these units into a multimedia application.

This talk is a chronicle of GStreamer application development on Freescale i.MX53 SoCs. It shows the problems faced when working with embedded systems in general and the challenges encountered while integrating hardware acceleration units like the scaler/colorspace converter or the video encoder/decoder.

I intend to show what can be done when putting it all together, because decoding and displaying a video or encoding and streaming from a camera barely scratches the surface of what can be done with GStreamer on embedded systems.

*Michael works for Pengutronix on embedded Linux topics and has been using GStreamer here for several years. He recently started to contribute to GStreamer, mostly to the video4linux plugin and related topics.*

### Time and Synchronization for Dummies (yes, you!), Edward Hervey (bilboed), Collabora {#hervey-time}

An overview of all time usages in GStreamer, how it all fits together, and what can be improved. If you are unsure about time and synchronization in GStreamer, this is your chance to fix that.

*Edward Hervey has been contributing since 2003 to the GStreamer framework. Edward is interested in all fields of applications and usage of GStreamer, which he applies as the Multimedia Domains Lead at Collabora where he has worked for the past 6 years.*

### GStreamer and the move from a hardware centric product design towards a software centric product design, Marc Leeman (den_erpel), Barco {#leeman-drive-towards-software}

Until quite recently, the domain of professional video processing in our company has been the exclusive domain of hardware engineers and opticians.

As digital and streaming video entered the professional markets in the beginning of the new millennium, the complex and often unstandardised formats required some kind of pre-processing of the streams. Later, all kinds of session management systems started to come into the picture. This required the introduction of some kind of control logic on the devices itself; best performed by a software layer.

However, next to overall management software on the system level, the software on the devices themselves was limited to control of the peripherals and user interaction. Traditional hardware design was still very much at the core of the products.

Two main drivers shattered this comfort zone: increasing parallelism in processors combined with mature and stable user-land open source software.

While the initial investment of hardware design is high, creating a significant step-in cost; a software approach is flexible and runs on, in comparison, "low cost" hardware. Deciding on custom hardware design is currently like crossing the Rubicon: committing resources for longer periods of time. These decisions must be taken with the utmost care.

This talk focusses on the disruptive nature of this marriage of technologies in an environment where hardware design was at the core of what we did. The focus is on how GStreamer is a driving force in the transition; impacting day-to-day work, training, product design and system definition.

*Marc has a background in electrical engineering and performed research on the usage and impact of dynamic memory in small and constrained systems.*

*Putting theory to practice; he joined Barco, where he did U-Boot and the Linux kernel porting to a line of embedded streaming video products and was part of a team that designed the users pace software. When more powerful processing became available, he introduced GStreamer in a stream normalising system, that in turn was used for software decoding and made full circle to "embedded systems".*

*In his spare time, he's mainly driving his three daughters to horse riding academy or does some road bicycle racing and has recently taken up the challenge to construct his own carbon bicycle. He does some Debian package maintenance and published a low cost system to control KNX automation systems.*

### My GStreamer-Enabled Home, Jan Schmidt (thaytan), Centricular {#schmidt-gst-enabled-home}

Officially, this is a talk about using GStreamer around the house.

Really, it's a talk about being lazy, chickens, sheds and tiny humans.

It might also touch on network media, streaming and synchronisation.

*Jan Schmidt has been a GStreamer developer and maintainer since 2002. He is responsible for GStreamer's DVD support, and primary author of the Aurena home-area media player. He lives in Albury, Australia and keeps sheep, chickens, ducks and more fruit trees than is sensible. Recently, he co-founded Centricular - a new company for Open Source multimedia and graphics development.*

### Achieving Pexcellence - Challenges of real time streaming applications, Håvard Graff (hgr), Pexip {#graff-testing}

How can you test real time systems deterministically? How can you fix bugs that only happens once every millionth run of your application? (and never with you or your debugger present). Pexip have invested a lot of time and effort towards these issues, and we want to share some of our thoughts, techniques and code with you.

*Håvard Graff has worked with GStreamer professionally for 6 years in Tandberg, Cisco and now Pexip. Developing video conferencing systems like Movi, Jabber Video and Pexip Infinity using GStreamer as the backbone. Was instrumental in premiering GStreamer in the AppStore. Still pretends to be a musician with programming as a hobby.*

### Return of the PulseAudio Update, Arun Rhagavan (Ford_Prefect), Collabora {#raghavan-pulseaudio}

When we last left or heroes, it was autumn in Prague, 2011. A 1.0 release has just been made, the citizens of Linuxia were rejoicing and world domination was close at hand.

In this next chapter of our heroes' adventures we shall see what fate befalls them, as they navigate the swamps of Android, fight the beasts of ARM, and finally vanquish the Use Case Manager. Will they finally get a stable release cycle? Will they stop breaking your audio? Join us, to find out more!

*Arun Raghavan is a long-time open source support and contributor. He works at Collabora where he hacks on PulseAudio, GStreamer, and whatever else comes his way. You can usually find him on the usual IRC networks as Ford_Prefect, demanding that you get off his lawn.*

### Opus and Daala: State of the Art Royalty-free Codecs, Greg Maxwell (gmaxwell), Mozilla {#maxwell-free-codecs}

Opus is a state-of-the-art royalty-free lossy audio codec convering more applications than any other single audio codec— from low latency VoIP to high fidelity music storage. After five years of open development, including contributions from Xiph.Org, Skype/Microsoft, Mozilla, Broadcom, and many individual developers, Opus was standardized in 2012 by the IETF in RFC 6716 and has since been deployed to hundreds of millions of computers and devices.

Daala is a new open effort to build a state-of-the-art video codec targeting compression performance beyond HEVC and VP9. Leveraging the experience we had with Opus we are building a new technical framework for video coding the ground up to avoid patent thickets and be royalty free: By breaking from the common design pattern of block based transform codecs we avoid many licensing complications and create an opportunity to better resolve some of the weaknesses of existing formats.

This talk will cover our success with Opus and our plans for Daala and how we will create codec infrastructure which is convincingly royalty free, has state-of-the-art performance, and can be easily deployed and integrated, with the hope that someday everyone can stop worrying about codecs and go on to build fantastic things without having to compromise on performance or navigating licensing.

*Greg has worked on unencumbered multimedia codecs with the Xiph.Org Foundation since 1999 and is currently working for Mozilla on next-generation royalty-free video coding standards.*
