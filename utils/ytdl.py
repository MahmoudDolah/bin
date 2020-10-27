#!/usr/bin/env python3
#
# by Siddharth Dushantha (sdushantha)
#
# My very simple version of youtube-dl.
#
# Credits: https://git.io/JTPr9
#

import re
import json
import argparse
import requests

def download(url, filename):
    r = requests.get(url)
    html = r.text

    data = re.findall(r";ytplayer\.config = (.*);ytplayer\.web_player_context_config", html)[0]

    player_response = json.loads(data).get("args").get("player_response")
    videoFormats = json.loads(player_response).get("streamingData").get("formats")

    bitrates = [videoFormat.get("bitrate") for videoFormat in videoFormats]
    bestQualityIndex = bitrates.index(max(bitrates))

    videoStreamURL = videoFormats[bestQualityIndex].get("url")

    r = requests.get(videoStreamURL)
    rawData = r.content

    with open(filename, "wb") as f:
        f.write(rawData)

    print(f"Finished downloading {filename}")

def main():
    parser = argparse.ArgumentParser(description="YouTube Downloader")
    parser.add_argument("url", help="URL to the YouTube video")
    parser.add_argument("filename", help="Name you want the file to be saved as")
    args = parser.parse_args()

    download(args.url, args.filename)


if __name__ == "__main__":
    main()
