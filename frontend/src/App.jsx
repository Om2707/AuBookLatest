import { Route, BrowserRouter as Router, Routes } from 'react-router-dom';
import AshtangChapter1 from './Chapters/AshtangSamhita/ch1';
import AshtangChapter2 from './Chapters/AshtangSamhita/ch2';
// import SushrutChapter1 from './Chapters/SushrutSamhita/ch1';
// import SushrutChapter2 from './Chapters/SushrutSamhita/ch2';
import SushrutChapter6 from './Chapters/SushrutSamhita/ch6';
import AshtangSamgraha from './components/AshtangSamgraha';
import ForgotPassword from './components/ForgotPassword';
import Home from './components/Home';
import Login from './components/Login';
import Signup from './components/Signup';
import SushrutSamhita from './components/SushrutSamhita';


function App() {
  return (
    <Router>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/home" element={<Home />} />
        <Route path="/sushrut" element={<SushrutSamhita />}/>
        <Route path="/ashtang" element={<AshtangSamgraha/>}/>
        <Route path="/ashtang-samgraha/chapter/1" element={<AshtangChapter1 />} />
        <Route path="/ashtang-samgraha/chapter/2" element={<AshtangChapter2 />} />
        <Route path="/sushrut-samhita/chapter/6" element={<SushrutChapter6 />} />
        {/* <Route path="/sushrut-samhita/chapter/1" element={<SushrutChapter1 />} />
        <Route path="/sushrut-samhita/chapter/2" element={<SushrutChapter2 />} /> */}
        <Route path="/forgot-password" element={<ForgotPassword />} />
        <Route index path='/' element={<Login />} />
             </Routes>
    </Router>
  );
}

export default App;
