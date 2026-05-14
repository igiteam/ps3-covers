#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# create_ps3_json.py - Create PS3 games JSON from text file with cover existence check

import json
import os

input_file = "ps3_games_list.txt"
output_file = "ps3_games_rpcs3.json"
missing_file = "ps3_missing_covers.txt"
covers_dir = "covers/default"
default_cover = f"{covers_dir}/ps3_cover_default.png"

# Create covers directory if it doesn't exist
if not os.path.exists(covers_dir):
    print(f"⚠️  Warning: Covers directory '{covers_dir}' not found")
    os.makedirs(covers_dir, exist_ok=True)

# Read the text file
games = []
missing_covers = []

with open(input_file, 'r') as f:
    for line in f:
        line = line.strip()
        if not line or '=' not in line:
            continue
            
        code, title = line.split('=', 1)
        code = code.strip()
        title = title.strip()
        
        filename = f"{code}.jpg"
        cover_path = f"{covers_dir}/{filename}"
        
        if os.path.exists(cover_path):
            cover_url = cover_path
            print(f"✓ Found cover: {code} - {title}")
        else:
            cover_url = default_cover
            missing_covers.append(f"{code} - {title}")
            print(f"❌ Missing cover: {code} - {title}")
        
        games.append({
            "title": title,
            "cover_url": cover_url,
            "filename": filename
        })

# Write JSON file
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(games, f, indent=2, ensure_ascii=False)

# Write missing covers to text file (clean format)
with open(missing_file, 'w', encoding='utf-8') as f:
    for missing in missing_covers:
        f.write(f"{missing}\n")

# Print summary
print("\n" + "="*50)
print(f"✅ Created {output_file} with {len(games)} games")
print(f"📁 Covers found: {len(games) - len(missing_covers)}")
print(f"🖼️  Default covers used: {len(missing_covers)}")
print(f"📝 Missing covers saved to: {missing_file}")

# Show first 5 missing covers as example
if missing_covers:
    print("\n📋 First 5 missing covers:")
    for missing in missing_covers[:5]:
        print(f"   {missing}")