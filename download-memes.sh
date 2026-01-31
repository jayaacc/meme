#!/bin/bash
# 下载热门表情包

mkdir -p public/images
cd public/images

# 经典meme (imgflip热门)
urls=(
  "https://i.imgflip.com/30b1gx.jpg|001.jpg"
  "https://i.imgflip.com/1g8my4.jpg|002.jpg"
  "https://i.imgflip.com/261o3j.jpg|003.jpg"
  "https://i.imgflip.com/1h7in3.jpg|004.jpg"
  "https://i.imgflip.com/30axps.jpg|005.jpg"
  "https://i.imgflip.com/1ur9b0.jpg|006.jpg"
  "https://i.imgflip.com/26am.jpg|007.jpg"
  "https://i.imgflip.com/9ehk.jpg|008.jpg"
  "https://i.imgflip.com/1otk96.jpg|009.jpg"
  "https://i.imgflip.com/29b5jq.jpg|010.jpg"
)

for url in "${urls[@]}"; do
  IFS='|' read -r img_url filename <<< "$url"
  echo "Downloading $filename..."
  curl -sL -A "Mozilla/5.0" -o "$filename" "$img_url"
done

echo "Done! $(ls *.jpg 2>/dev/null | wc -l) images downloaded."
