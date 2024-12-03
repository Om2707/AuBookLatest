import React from 'react';
import { Carousel } from 'react-responsive-carousel';
import "react-responsive-carousel/lib/styles/carousel.min.css";

function Slider() {
  return (
    <div className="w-full h-[32rem]"> 
      <div className="w-full h-full">
        <Carousel showThumbs={false} autoPlay infiniteLoop>
          <div>
            <img 
              src="src\Images\Slider3.png" 
              alt="Slide 1" 
              className="w-full h-[32rem] object-fill" 
            />
          </div>
          <div>
            <img 
              src="src\Images\Slide1.png" 
              alt="Slide 2" 
              className="w-full h-[32rem] object-fill" 
            />
          </div>
          <div>
            <img 
              src="src\Images\SliderTwo.jpg"
              alt="Slide 3" 
              className="w-full h-[32rem] object-cover"
            />
          </div>
        </Carousel>
      </div>
    </div>
  );
}

export default Slider;
