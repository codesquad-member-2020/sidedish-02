import React, { useState } from 'react';
import Slider from "react-slick";
import DishDetail from './DishDetail';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

const DishList = ({ dishes }) => {

    const [targetId, setTargetId] = useState();

    const viewDetail = (e) => {
        const targetId = e.target.closest("li").id;
        console.log(targetId);
        setTargetId(targetId);
        // DishDetail(targetId);
    }

    const configureBadges = (dish) => {
        return dish.badge ? dish.badge.map(badge => <span className="item-badge">{badge}</span>) : null
    }

    const settings = {
        infinite: true,
        speed: 300,
        slidesToShow: 4,
        slidesToScroll: 4,
        prevArrow: <button type="button" class="slick-prev"></button>,
        nextArrow: <button type="button" class="slick-next"></button>
    };

    const dishList = dishes.map((dish) =>
        <>
            <div className="item" id={dish.detail_hash}>
                {/* {console.log(targetId)} */}
                {/* {targetId ? <DishDetail targetId={targetId} /> : null} */}
                {/* <DishDetail targetId={targetId} /> */}
                <div className="item-image_box">
                    <img className="item-image" src={dish.image} alt={dish.alt} />
                    <div className="overlay">
                        <div className="item-delivery_type">
                            <div>{dish.delivery_type[0]}</div>
                            <hr className="item-delivery_type_line" />
                            <div>{dish.delivery_type[1]}</div>
                        </div>
                    </div>
                </div>
                <p className="item-title">{dish.title}</p>
                <p className="item-description">{dish.description}</p>
                <div className="item-price">
                    <span className="item-original_price">{dish.n_price ? dish.n_price : ''}</span>
                    <span className="item-final_price">{dish.s_price}</span>
                </div>
                {configureBadges(dish)}
            </div>
        </>
    )

    return (
        <Slider {...settings} className="item-wrap">
            {dishList}
        </Slider>
    )
}
export default DishList