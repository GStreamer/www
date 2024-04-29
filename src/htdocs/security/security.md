# Security Center
## Security Contacts

Security notifications or problems should be reported in [GitLab](https://gitlab.freedesktop.org/gstreamer) by
[<u>filing an issue</u>](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/new?issue[confidential]=true)
and marking it as *confidential* before submitting it (if you follow the link on the left the confidential checkbox should already be ticked).

If you have patches, please attach them to the confidential issue and not via a merge requests, as merge requests are always public immediately.

The GStreamer project encourages [responsible disclosure](https://en.wikipedia.org/wiki/Responsible_disclosure) of security issues.

## Security Advisories

| ID  | Summary | Date   |     |
| --- | ------- | :----: | --- |
| **GStreamer-SA-2024-0002**<br/>ZDI-CAN-23896 | Integer overflow in EXIF metadata parser leading to potential heap overwrite | 2024-04-29 20:00 | [Details](sa-2024-0002.html) |
| **GStreamer-SA-2024-0001**<br/>ZDI-CAN-22873<br/>CVE-2024-0444  | AV1 codec parser potential buffer overflow during tile list parsing | 2024-01-24 20:00 | [Details](sa-2024-0001.html) |
| **GStreamer-SA-2023-0011**<br/>ZDI-CAN-22300 | AV1 codec parser buffer overflow | 2023-12-18 14:00 | [Details](sa-2023-0011.html) |
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
