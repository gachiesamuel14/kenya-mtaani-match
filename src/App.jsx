import { useState, useEffect } from 'react'
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom'

function App() {
  const [user, setUser] = useState(null)

  return (
    <Router>
      <div className="min-h-screen bg-gradient-to-br from-pink-50 to-purple-50">
        <nav className="bg-white shadow p-4 flex justify-between items-center">
          <Link to="/" className="text-2xl font-bold text-pink-600">Mtaani Match 🇰🇪</Link>
          <div>
            {user ? (
              <Link to="/profile" className="mr-4">Profile</Link>
            ) : (
              <>
                <Link to="/login" className="mr-4 text-pink-600">Login</Link>
                <Link to="/signup" className="bg-pink-600 text-white px-4 py-2 rounded">Sign Up</Link>
              </>
            )}
          </div>
        </nav>

        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/login" element={<Login />} />
          <Route path="/signup" element={<Signup />} />
          <Route path="/discover" element={<Discover />} />
          <Route path="/profile" element={<Profile />} />
        </Routes>
      </div>
    </Router>
  )
}

function Home() {
  return (
    <div className="text-center py-20 px-4">
      <h1 className="text-5xl font-bold mb-4 text-gray-800">Find Love Nearby in Kenya</h1>
      <p className="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
        Location-based matchmaking. Connect with people in your county, town, or neighborhood. Swipe, match, chat.
      </p>
      <Link to="/signup" className="bg-pink-600 text-white text-lg px-8 py-4 rounded-full shadow-lg hover:bg-pink-700">
        Get Started - Karibu!
      </Link>
      <div className="mt-12 grid md:grid-cols-3 gap-6 max-w-4xl mx-auto">
        <div className="bg-white p-6 rounded-lg shadow">
          <h3 className="font-bold text-lg">GPS Matching</h3>
          <p>See people near you using real location.</p>
        </div>
        <div className="bg-white p-6 rounded-lg shadow">
          <h3 className="font-bold text-lg">County Filters</h3>
          <p>Nairobi, Mombasa, Kisumu, Kiambu & more.</p>
        </div>
        <div className="bg-white p-6 rounded-lg shadow">
          <h3 className="font-bold text-lg">Sheng Vibes</h3>
          <p>Local language support and modes.</p>
        </div>
      </div>
    </div>
  )
}

function Login() {
  return <div className="p-8 max-w-md mx-auto">Login form (connect Supabase Auth)</div>
}

function Signup() {
  return <div className="p-8 max-w-md mx-auto">Signup form</div>
}

function Discover() {
  return <div className="p-8">Swipe cards for nearby matches (implement with geolocation)</div>
}

function Profile() {
  return <div className="p-8">Profile setup: photos, bio, county, interests</div>
}

export default App