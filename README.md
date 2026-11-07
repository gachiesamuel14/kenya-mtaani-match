# Kenya Mtaani Match

Location-based matchmaking website for people in Kenya. Connect with nearby users via profiles, swipe matching, and chat.

## Core Idea
- Users create profiles (photos, age, bio, interests, county, tribe, religion, etc.)
- App requests GPS/location permission
- Shows nearby users within distance radius using coordinates
- Swipe, like, match, chat
- Filters: county, distance, age, interests, lifestyle

## Tech Stack (Recommended)
- **Frontend**: React + Vite + Tailwind CSS (or upgrade to Next.js)
- **Backend / Auth / DB / Storage / Realtime**: [Supabase](https://supabase.com) (PostgreSQL + PostGIS for geo queries)
- **Hosting**: Netlify (connect this GitHub repo)
- **Maps/Location**: Browser Geolocation API + Haversine formula or PostGIS
- **Payments (optional)**: M-Pesa Daraja API (STK Push) via Netlify Functions or Supabase Edge Functions
- **Chat**: Supabase Realtime

## Features Roadmap
1. User registration/login (Supabase Auth - email, phone, Google)
2. Profile setup + photo uploads (Supabase Storage)
3. GPS/location tracking + nearby matching (PostGIS)
4. Matching algorithm (mutual likes + distance)
5. Real-time chat
6. Notifications
7. Safety/report system
8. Premium / M-Pesa subscriptions
9. Localization: Counties (Nairobi, Mombasa, Kisumu, Kiambu...), Sheng vibes, student/professional/church modes

## Getting Started

### 1. Clone & Install
```bash
git clone https://github.com/gachiesamuel14/kenya-mtaani-match.git
cd kenya-mtaani-match
npm install
npm run dev
```

### 2. Supabase Setup
1. Create a free project at [supabase.com](https://supabase.com)
2. Enable PostGIS extension in Database > Extensions
3. Run the SQL in `/supabase/schema.sql` in the SQL Editor
4. Set up RLS policies (users can select public profiles, update own)
5. Create Storage bucket for photos
6. Copy Project URL and anon key to `.env.local`:
```
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

### 3. Location Matching
- Use `navigator.geolocation.getCurrentPosition()` to get user coords
- Store as geography point in profiles.location
- Call the `get_nearby_profiles` RPC for matches within radius (e.g. 50km)

### 4. Deploy to Netlify
1. Push code to this repo
2. In Netlify: New site from Git > select this repo
3. Build command: `npm run build`
4. Publish directory: `dist`
5. Add environment variables (VITE_SUPABASE_...)

## Localization for Kenya
- Match by town/county
- M-Pesa payments for premium features
- Sheng language support
- Modes: Student, Professional, Church

## Safety
- Report/block users
- Photo moderation (optional with AI)
- Age verification recommended

## Next Steps to Build
- Implement Supabase client in `src/lib/supabase.js`
- Auth forms with Supabase Auth
- Profile form + image upload
- Discover page with swipe cards (react-tinder-card or custom)
- Chat with Supabase Realtime
- Geolocation hook

Built with ❤️ for Kenyans connecting nearby (Karibu!).

Repo: https://github.com/gachiesamuel14/kenya-mtaani-match