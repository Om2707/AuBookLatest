import { useNavigate } from 'react-router-dom';
import BookCard from './BookCard';
import Navbar from './Navbar';
import Slider from './Slider';
import SushrutImg from '../Images/SushrutBookImg.png'
import AshtangImg from '../Images/AshtangBookImg.png'

function Home() {
  const navigate = useNavigate()



  return (
    <div>
      <Navbar />
      <Slider />
      <div className="container mx-auto p-4">
        <h2 className="text-3xl font-bold mb-3 text-center">Books</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 mt-4 gap-8">
          <BookCard
            title="Sushrut Samhita"
            author="Ayurveda"
            description="Ayurvedic Shloks Book along with Audio"
            image="https://t4.ftcdn.net/jpg/06/26/22/67/360_F_626226761_Mx83GpFjuBv1Dviyr6CG5CMX44REGH1q.jpg"
            onClick={() => {
              navigate("/sushrut")
            }}
          />
          <BookCard
            title="Ashtang Samgraha"
            author="Ayurveda"
            description="Ayurvedic Shloks Book along with Audio."
            image={AshtangImg}
            onClick={() => {
              navigate("/ashtang")
            }}
          />
        </div>
      </div>
    </div>
  );
}

export default Home;