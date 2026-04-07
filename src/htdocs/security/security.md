# Security Center
## Security Contacts

Security notifications or problems should be reported in [GitLab](https://gitlab.freedesktop.org/gstreamer) by
[<u>filing an issue</u>](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/new?issue[confidential]=true)
and marking it as *confidential* before submitting it (if you follow the link on the left the confidential checkbox should already be ticked).

If you have patches, please attach them to the confidential issue and not via a merge requests, as merge requests are always public immediately.

The GStreamer project encourages [responsible disclosure](https://en.wikipedia.org/wiki/Responsible_disclosure) of security issues.

**Distributors** please note that this is not an exhaustive or comprehensive list of security-relevant issues affecting past releases, but merely a list of security issues filed as such by third parties. Fixes that may be security relevant are also landed as part of routine bug-fixing and development activity, and as such we encourage distributors to upgrade to our latest bug-fix releases whenever possible.

## Security Advisories

| ID  | Summary | Date   |     |
| --- | ------- | :----: | --- |
| **GStreamer-SA-2026-0023** | Denial of service in SRT/WebVTT parser  | 2026-04-07 23:59  | [Details](sa-2026-0023.html) |
| **GStreamer-SA-2026-0022**<br/>CVE-2026-pending | Heap buffer overflow in Matroska demuxer  | 2026-04-07 23:59  | [Details](sa-2026-0022.html) |
| **GStreamer-SA-2026-0021**<br/>CVE-2026-pending | Integer overflow in WAV parser cue handling | 2026-04-07 23:59  | [Details](sa-2026-0021.html) |
| **GStreamer-SA-2026-0020** | Assertion failures in FLV demuxer on corrupted streams | 2026-04-07 23:59  | [Details](sa-2026-0020.html) |
| **GStreamer-SA-2026-0019** | NULL-pointer dereferences in mDVDsub subtitle parser | 2026-04-07 23:59  | [Details](sa-2026-0019.html) |
| **GStreamer-SA-2026-0018**<br/>CVE-2026-pending | MOV/MP4 demuxer audio channel parsing vulnerabilities | 2026-04-07 23:59  | [Details](sa-2026-0018.html) |
| **GStreamer-SA-2026-0017** | Integer overflow in H.266/VVC parser leading to stack overflow | 2026-04-07 23:59  | [Details](sa-2026-0017.html) |
| **GStreamer-SA-2026-0016**<br/>CVE-2026-5056<br/>ZDI-CAN-29392 | Integer overflows and out-of-bounds access in MOV/MP4 demuxer | 2026-04-07 23:59  | [Details](sa-2026-0016.html) |
| **GStreamer-SA-2026-0015**<br/>CVE-2026-pending | Integer overflows in JPEG 2000 decimator   | 2026-04-07 23:59  | [Details](sa-2026-0015.html) |
| **GStreamer-SA-2026-0014** | Integer overflow in AV1 LEB128 parser     | 2026-04-07 23:59  | [Details](sa-2026-0014.html) |
| **GStreamer-SA-2026-0013** | H.264 video parser NULL pointer dereference when freeing SPS/MVC data | 2026-04-07 23:59 | [Details](sa-2026-0013.html) | 
| **GStreamer-SA-2026-0012**| H.265 video parser potential denial-of-service | 2026-02-25 23:59 | [Details](sa-2026-0012.html) |
| **GStreamer-SA-2026-0011**<br/>CVE-2026-3084<br/>ZDI-CAN-28910 | Out-of-bounds write in H.266 video parser when parsing picture partitions | 2026-02-25 23:59 | [Details](sa-2026-0011.html) |
| **GStreamer-SA-2026-0010**<br/>CVE-2026-3081<br/>ZDI-CAN-28839 | Stack buffer overflow in H.266 video parser when parsing pic_timing SEIs | 2026-02-25 23:59 | [Details](sa-2026-0010.html) |
| **GStreamer-SA-2026-0009**<br/>CVE-2026-3086<br/>ZDI-CAN-28911 |  Out-of-bounds buffer write in H.266 video parser when parsing Adaptation Parameter Set | 2026-02-25 23:59 | [Details](sa-2026-0009.html) |
| **GStreamer-SA-2026-0008**<br/>CVE-2026-3083, CVE-2026-3085<br/>ZDI-CAN-28851, ZDI-CAN-28850 | Multiple vulnerabilities in RTP QDM2 depayloader element | 2026-02-25 23:59 | [Details](sa-2026-0008.html) |
| **GStreamer-SA-2026-0007**<br/>CVE-2026-2923<br/>ZDI-CAN-28838 | Out-of-bounds read and write in DVB Subtitle Decoder | 2026-02-25 23:59 | [Details](sa-2026-0007.html) |
| **GStreamer-SA-2026-0006**<br/>CVE-2026-2920<br/>ZDI-CAN-28843 | Out-of-bounds write in ASF Demuxer | 2026-02-25 23:59 | [Details](sa-2026-0006.html) |
| **GStreamer-SA-2026-0005**<br/>CVE-2026-2922<br/>ZDI-CAN-28845 | Out-of-bounds write in RealMedia Demuxer | 2026-02-25 23:59 | [Details](sa-2026-0005.html) |
| **GStreamer-SA-2026-0004**<br/>CVE-2026-2921<br/>ZDI-CAN-28854 | Integer overflow in RIFF parser | 2026-02-25 23:59 | [Details](sa-2026-0004.html) |
| **GStreamer-SA-2026-0003**<br/>CVE-2026-3082<br/>ZDI-CAN-28840 | Heap-based Buffer Overflow on Huffman tables reading in JPEG parser | 2026-02-25 23:59 | [Details](sa-2026-0003.html) |
| **GStreamer-SA-2026-0002**| Out-of-bounds read in MP4 demuxer | 2026-02-25 23:59 | [Details](sa-2026-0002.html) |
| **GStreamer-SA-2026-0001**<br/>CVE-2026-1940 | Out-of-bounds read in WAV parser | 2026-02-25 23:59 | [Details](sa-2026-0001.html) |
| **GStreamer-SA-2025-0009**<br/>CVE-2025-67326<br/>CVE-2025-67327 | Multiple out-of-bounds reads in MIDI parser | 2025-12-27 18:00 | [Details](sa-2025-0009.html) |
| **GStreamer-SA-2025-0008**<br/>CVE-2025-67328<br/>CVE-2025-67329 | Multiple out-of-bounds reads in MIDI parser | 2025-12-27 18:00 | [Details](sa-2025-0008.html) |
| **GStreamer-SA-2025-0007**<br/>ZDI-CAN-27381<br/>CVE-2025-6663 | Stack buffer overflow in H.266 video parser | 2025-06-26 23:55 | [Details](sa-2025-0007.html) |
| **GStreamer-SA-2025-0006**<br/>CVE-2025-47806 | Stack buffer overflow in SubRip subtitle parser | 2025-05-29 23:55 | [Details](sa-2025-0006.html) |
| **GStreamer-SA-2025-0005**<br/>CVE-2025-47183 | Out-of-bounds read in MOV/MP4 demuxer II | 2025-05-29 23:55 | [Details](sa-2025-0005.html) |
| **GStreamer-SA-2025-0004**<br/>CVE-2025-47219 | Out-of-bounds read in MOV/MP4 demuxer I | 2025-05-29 23:55 | [Details](sa-2025-0004.html) |
| **GStreamer-SA-2025-0003**<br/>CVE-2025-47808 | NULL-pointer dereference in TMPlayer subtitle parser | 2025-05-29 23:55 | [Details](sa-2025-0003.html) |
| **GStreamer-SA-2025-0002**<br/>CVE-2025-47807 | NULL-pointer dereference in SubRip subtitle parser | 2025-05-29 23:55 | [Details](sa-2025-0002.html) |
| **GStreamer-SA-2025-0001**<br/>ZDI-CAN-26596<br/>CVE-2025-3887  | Stack buffer-overflow in H.265 codec parser during slice header parsing | 2025-04-24 18:00 | [Details](sa-2025-0001.html) |
| **GStreamer-SA-2024-0030**<br/>GHSL-2024-280<br/>CVE-2024-47834 | Use-after-free in Matroska demuxer | 2024-12-03 23:30 | [Details](sa-2024-0030.html) |
| **GStreamer-SA-2024-0029**<br/>GHSL-2024-263<br/>CVE-2024-47835 | NULL-pointer dereference in LRC subtitle parser | 2024-12-03 23:30 | [Details](sa-2024-0029.html) |
| **GStreamer-SA-2024-0028**<br/>GHSL-2024-262<br/>CVE-2024-47774 | Integer overflow in AVI subtitle parser that leads to out-of-bounds reads | 2024-12-03 23:30 | [Details](sa-2024-0028.html) |
| **GStreamer-SA-2024-0027**<br/>GHSL-2024-261, GHSL-2024-260, GHSL-2024-259, GHSL-2024-258<br/>CVE-2024-47778, CVE-2024-47777, CVE-2024-47776, CVE-2024-47775 | Various out-of-bounds reads in WAV parser | 2024-12-03 23:30 | [Details](sa-2024-0027.html) |
| **GStreamer-SA-2024-0026**<br/>GHSL-2024-117<br/>CVE-2024-47615 | Out-of-bounds write in Ogg demuxer | 2024-12-03 23:30 | [Details](sa-2024-0026.html) |
| **GStreamer-SA-2024-0025**<br/>GHSL-2024-118<br/>CVE-2024-47613 | NULL-pointer dereference in gdk-pixbuf decoder | 2024-12-03 23:30 | [Details](sa-2024-0025.html) |
| **GStreamer-SA-2024-0024**<br/>GHSL-2024-116<br/>CVE-2024-47607 | Stack buffer-overflow in Opus decoder | 2024-12-03 23:30 | [Details](sa-2024-0024.html) |
| **GStreamer-SA-2024-0023**<br/>GHSL-2024-228<br/>CVE-2024-47541 | Out-of-bounds write in SSA subtitle parser | 2024-12-03 23:30 | [Details](sa-2024-0023.html) |
| **GStreamer-SA-2024-0022**<br/>GHSL-2024-115<br/>CVE-2024-47538 | Stack buffer-overflow in Vorbis decoder | 2024-12-03 23:30 | [Details](sa-2024-0022.html) |
| **GStreamer-SA-2024-0021**<br/>GHSL-2024-251<br/>CVE-2024-47603 | NULL-pointer dereference in Matroska/WebM demuxer | 2024-12-03 23:30 | [Details](sa-2024-0021.html) |
| **GStreamer-SA-2024-0020**<br/>GHSL-2024-249<br/>CVE-2024-47601 | NULL-pointer dereference in Matroska/WebM demuxer | 2024-12-03 23:30 | [Details](sa-2024-0020.html) |
| **GStreamer-SA-2024-0019**<br/>GHSL-2024-250<br/>CVE-2024-47602 | NULL-pointer dereferences and out-of-bounds reads in Matroska/WebM demuxer | 2024-12-03 23:30 | [Details](sa-2024-0019.html) |
| **GStreamer-SA-2024-0018**<br/>GHSL-2024-248<br/>CVE-2024-47600 | Out-of-bounds read in gst-discoverer-1.0 commandline tool | 2024-12-03 23:30 | [Details](sa-2024-0018.html) |
| **GStreamer-SA-2024-0017**<br/>GHSL-2024-197<br/>CVE-2024-47540 | Usage of uninitialized stack memory in Matroska/WebM demuxer | 2024-12-03 23:30 | [Details](sa-2024-0017.html) |
| **GStreamer-SA-2024-0016**<br/>GHSL-2024-247<br/>CVE-2024-47599 | Insufficient error handling in JPEG decoder that can lead to NULL-pointer dereferences | 2024-12-03 23:30 | [Details](sa-2024-0016.html) |
| **GStreamer-SA-2024-0015**<br/>GHSL-2024-244<br/>CVE-2024-47596 | Integer underflow in MP4/MOV demuxer that can lead to out-of-bounds reads | 2024-12-03 23:30 | [Details](sa-2024-0015.html) |
| **GStreamer-SA-2024-0014**<br/>GHSL-2024-166<br/>CVE-2024-47606 | Integer overflows in MP4/MOV demuxer and memory allocator that can lead to out-of-bounds writes | 2024-12-03 23:30 | [Details](sa-2024-0014.html) |
| **GStreamer-SA-2024-0013**<br/>GHSL-2024-243<br/>CVE-2024-47546 | Integer underflow in MP4/MOV demuxer that can lead to out-of-bounds reads | 2024-12-03 23:30 | [Details](sa-2024-0013.html) |
| **GStreamer-SA-2024-0012**<br/>GHSL-2024-245<br/>CVE-2024-47597 | Out-of-bounds reads in MP4/MOV demuxer sample table parser | 2024-12-03 23:30 | [Details](sa-2024-0012.html) |
| **GStreamer-SA-2024-0011**<br/>GHSL-2024-238, GHSL-2024-239, GHSL-2024-240<br/>CVE-2024-47544 | NULL-pointer dereferences in MP4/MOV demuxer CENC handling  | 2024-12-03 23:30 | [Details](sa-2024-0011.html) |
| **GStreamer-SA-2024-0010**<br/>GHSL-2024-242<br/>CVE-2024-47545 | Integer overflow in MP4/MOV demuxer that can result in out-of-bounds read | 2024-12-03 23:30 | [Details](sa-2024-0010.html) |
| **GStreamer-SA-2024-0009**<br/>GHSL-2024-236<br/>CVE-2024-47543 | MP4/MOV demuxer out-of-bounds read | 2024-12-03 23:30 | [Details](sa-2024-0009.html) |
| **GStreamer-SA-2024-0008**<br/>GHSL-2024-235<br/>CVE-2024-47542 | ID3v2 parser out-of-bounds read and NULL-pointer dereference | 2024-12-03 23:30 | [Details](sa-2024-0008.html) |
| **GStreamer-SA-2024-0007**<br/>GHSL-2024-195<br/>CVE-2024-47539 | MP4/MOV Closed Caption handling out-of-bounds write | 2024-12-03 23:30 | [Details](sa-2024-0007.html) |
| **GStreamer-SA-2024-0006**<br/>GHSL-2024-246<br/>CVE-2024-47598 | MP4/MOV sample table parser out-of-bounds read | 2024-12-03 23:30 | [Details](sa-2024-0006.html) |
| **GStreamer-SA-2024-0005**<br/>GHSL-2024-094, GHSL-2024-237, GHSL-2024-241<br/>CVE-2024-47537 | Integer overflow in MP4/MOV sample table parser leading to out-of-bounds writes | 2024-12-03 23:30 | [Details](sa-2024-0005.html) |
| **GStreamer-SA-2024-0004**<br/>CVE-2024-44331 | RTSP server: Potential Denial-of-Service (DoS) with specially crafted client requests | 2024-10-29 18:00 | [Details](sa-2024-0004.html) |
| **GStreamer-SA-2024-0003**<br/>JVN#02030803 / JPCERT#92912620<br/>CVE-2024-40897 | Orc compiler stack-based buffer overflow | 2024-07-19 12:30 | [Details](sa-2024-0003.html) |
| **GStreamer-SA-2024-0002**<br/>ZDI-CAN-23896<br/>CVE-2024-4453  | Integer overflow in EXIF metadata parser leading to potential heap overwrite | 2024-04-29 20:00 | [Details](sa-2024-0002.html) |
| **GStreamer-SA-2024-0001**<br/>ZDI-CAN-22873<br/>CVE-2024-0444  | AV1 codec parser potential buffer overflow during tile list parsing | 2024-01-24 20:00 | [Details](sa-2024-0001.html) |
| **GStreamer-SA-2023-0011**<br/>ZDI-CAN-22300<br/>CVE-2023-50186 | AV1 codec parser buffer overflow | 2023-12-18 14:00 | [Details](sa-2023-0011.html) |
| **GStreamer-SA-2023-0010**<br/>ZDI-CAN-22299<br/>CVE-2023-44446 | MXF demuxer use-after-free | 2023-11-13 12:00 | [Details](sa-2023-0010.html) |
| **GStreamer-SA-2023-0009**<br/>ZDI-CAN-22226<br/>CVE-2023-44429 | AV1 codec parser buffer overflow | 2023-11-13 12:00 | [Details](sa-2023-0009.html) |
| **GStreamer-SA-2023-0008**<br/>ZDI-CAN-21768<br/>CVE-2023-40476 | Integer overflow in H.265 video parser leading to stack overwrite | 2023-09-20 20:00 | [Details](sa-2023-0008.html) |
| **GStreamer-SA-2023-0007**<br/>ZDI-CAN-21661<br/>CVE-2023-40475 | Integer overflow leading to heap overwrite in MXF file handling with AES3 audio | 2023-09-20 20:00 | [Details](sa-2023-0007.html) |
| **GStreamer-SA-2023-0006**<br/>ZDI-CAN-21660<br/>CVE-2023-40474 | Integer overflow leading to heap overwrite in MXF file handling with uncompressed video | 2023-09-20 20:00 | [Details](sa-2023-0006.html) |
| **GStreamer-SA-2023-0005**<br/>ZDI-CAN-21444 | Integer overflow leading to heap overwrite in RealMedia file handling | 2023-07-20 14:00 | [Details](sa-2023-0005.html) |
| **GStreamer-SA-2023-0004**<br/>ZDI-CAN-21443 | Integer overflow leading to heap overwrite in RealMedia file handling | 2023-07-20 14:00 | [Details](sa-2023-0004.html) |
| **GStreamer-SA-2023-0003**<br/>ZDI-CAN-20994<br/>CVE-2023-37329 | Heap overwrite in PGS subtitle overlay decoder | 2023-06-20 18:00 | [Details](sa-2023-0003.html) |
| **GStreamer-SA-2023-0002**<br/>ZDI-CAN-20968<br/>CVE-2023-37328 | Heap overwrite in subtitle parsing | 2023-06-20 18:00 | [Details](sa-2023-0002.html) |
| **GStreamer-SA-2023-0001**<br/>ZDI-CAN-20775<br/>CVE-2023-37327 | Integer overflow leading to heap overwrite in FLAC image tag handling | 2023-06-20 18:00 | [Details](sa-2023-0001.html) |
| **GStreamer-SA-2022-0004**<br/>CVE-2022-1920 | Potential heap overwrite in gst\_matroska\_demux\_add\_wvpk\_header | 2022-06-15 23:00 | [Details](sa-2022-0004.html) |
| **GStreamer-SA-2022-0003**<br/>CVE-2022-2122 | Potential heap overwrite in mp4 demuxing using zlib decompression | 2022-06-15 23:00 | [Details](sa-2022-0003.html) |
| **GStreamer-SA-2022-0002**<br/>CVE-2022-1922<br/>CVE-2022-1923<br/>CVE-2022-1924<br/>CVE-2022-1925 | Potential heap overwrite in mkv demuxing using zlib/bz2/lzo decompression | 2022-06-15 23:00 | [Details](sa-2022-0002.html) |
| **GStreamer-SA-2022-0001**<br/>CVE-2022-1921 | Heap overwrite in avi demuxing | 2022-06-15 23:00 | [Details](sa-2022-0001.html) |
| **GStreamer-SA-2021-0005** | Stack overflow in gst\_ffmpeg\_channel\_layout\_to\_gst() | 2021-03-15 16:00 | [Details](sa-2021-0005.html) |
| **GStreamer-SA-2021-0004** | Out-of-bounds read in realmedia demuxing | 2021-03-15 16:00 | [Details](sa-2021-0004.html) |
| **GStreamer-SA-2021-0003**<br/>CVE-2021-3498 | Heap corruption in matroska demuxing | 2021-03-15 16:00 | [Details](sa-2021-0003.html) |
| **GStreamer-SA-2021-0002**<br/>CVE-2021-3497 | Use-after-free in matroska demuxing | 2021-03-15 16:00 | [Details](sa-2021-0002.html) |
| **GStreamer-SA-2021-0001**<br/>CVE-2021-3522 | Out-of-bounds read in ID3v2 tag parsing | 2021-03-15 16:00 | [Details](sa-2021-0001.html) |
| **GStreamer-SA-2019-0001**<br/>CVE-2019-9928 | Buffer overflow in RTSP parsing | 2019-04-22 00:30 | [Details](sa-2019-0001.html) |
| **GStreamer-SA-2016-0002**<br/>CVE-2016-9634<br/>CVE-2016-9635<br/>CVE-2016-9636<br/>CVE-2016-9807 | Multiple Issues in FLC/FLI/FLX Decoder | 2016-11-23 03:00 | [Details](sa-2016-0002.html) |
| **GStreamer-SA-2016-0001**<br/>CVE-2016-9445<br/>CVE-2016-9446 | Multiple Issues in VMNC decoder | 2016-11-17 16:00 | [Details](sa-2016-0001.html) |
