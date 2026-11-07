-- Enable PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- Profiles table
CREATE TABLE profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  username TEXT UNIQUE,
  full_name TEXT,
  age INTEGER,
  bio TEXT,
  county TEXT,
  tribe TEXT,
  religion TEXT,
  interests TEXT[],
  photo_urls TEXT[],
  location GEOGRAPHY(POINT, 4326),
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  is_premium BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Matches / Likes
CREATE TABLE likes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  liker_id UUID REFERENCES profiles(id),
  liked_id UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(liker_id, liked_id)
);

-- Messages for chat
CREATE TABLE messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  sender_id UUID REFERENCES profiles(id),
  receiver_id UUID REFERENCES profiles(id),
  content TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Reports
CREATE TABLE reports (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  reporter_id UUID REFERENCES profiles(id),
  reported_id UUID REFERENCES profiles(id),
  reason TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Function for nearby users (example)
CREATE OR REPLACE FUNCTION get_nearby_profiles(user_lat FLOAT, user_lng FLOAT, max_distance_m FLOAT DEFAULT 50000)
RETURNS TABLE (
  id UUID,
  username TEXT,
  full_name TEXT,
  age INTEGER,
  bio TEXT,
  county TEXT,
  photo_urls TEXT[],
  distance_m FLOAT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p.id,
    p.username,
    p.full_name,
    p.age,
    p.bio,
    p.county,
    p.photo_urls,
    ST_Distance(p.location, ST_SetSRID(ST_MakePoint(user_lng, user_lat), 4326)::geography) AS distance_m
  FROM profiles p
  WHERE p.location IS NOT NULL
    AND ST_DWithin(p.location, ST_SetSRID(ST_MakePoint(user_lng, user_lat), 4326)::geography, max_distance_m)
  ORDER BY distance_m;
END;
$$ LANGUAGE plpgsql;

-- RLS policies (basic - expand as needed)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
-- Add policies: users can read public profiles, update own, etc.